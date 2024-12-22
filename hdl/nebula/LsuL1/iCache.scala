package nebula.LsuL1


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.Decoder.INSTRUCTION
import nebula.LsuL1.PC.PCVal
import nebula.LsuL1.PC.VALIDCACHEREAD




class ICacheBus() extends Bundle with IMasterSlave {
  val cmd  = Stream(L1FetchCmd())
  val rsp  = Stream(L1FetchRsp())
  
  override def asMaster() = {
    master(cmd)
    slave(rsp)
  }

}



case class ICache(node : CtrlLink) extends Area {

  val addressWidth = 64 // 64 bits
  val byteOffset = 2
  val nSets = 256
  val upper_lower_select = 1

  val setIndexWidth = log2Up(nSets) 
  val setIndexRange = (setIndexWidth + upper_lower_select + byteOffset -1 downto upper_lower_select + byteOffset)
  // val blockSize = 4  // in bytes
  val tagWidth = addressWidth - setIndexWidth - upper_lower_select - byteOffset
  val tagRange = 63 downto (64 - tagWidth)
  
  println(setIndexWidth)
  println(setIndexRange)
  println(tagWidth)
  println(tagRange)
  println(tagWidth + setIndexWidth + upper_lower_select + byteOffset)

  import spinal.core.sim._

  val l1bus = new ICacheBus()
  val ramBus = new RamBus() 
  ramBus.ramFetchRsp simPublic()

  case class Tag() extends Bundle {
    val valid = Bool()
    val address = UInt(tagWidth bits)
  }

  val mem = Mem(Bits(64 bits), nSets) simPublic()
  val tagBank = Mem(Tag(), nSets)

  val haltPc = Bool()


  val read = new node.Area {
    l1bus.cmd.payload.address := PCVal
    val index = l1bus.cmd.payload.address(setIndexRange)
    val reqTag = l1bus.cmd.payload.address(tagRange)
    val tag = tagBank.readAsync(index)
    val word  = mem.readAsync(index)

    val lowerHalf = word(31 downto 0) simPublic()
    val upperHalf = word(63 downto 32) simPublic()
    
    val hit = tag.valid && (tag.address === reqTag) simPublic()
    
    INSTRUCTION.assignDontCare()
    l1bus.rsp.setIdle()
    ramBus.ramFetchCmd.valid := False
    ramBus.ramFetchCmd.payload.address.assignDontCare()

    l1bus.cmd.valid := VALIDCACHEREAD

    haltPc := False
    when(l1bus.cmd.valid) {
        when(hit) {
          l1bus.rsp.valid := True
          val upper_lower = Bool() simPublic()
          upper_lower := l1bus.cmd.payload.address(3)
          l1bus.rsp.payload.data := l1bus.cmd.payload.address(2) ? upperHalf | lowerHalf
          INSTRUCTION := l1bus.cmd.payload.address(2) ? upperHalf | lowerHalf
          l1bus.rsp.payload.miss := False
          haltPc := False
        }.otherwise {
          l1bus.rsp.payload.miss := True
          l1bus.rsp.valid := False
          l1bus.rsp.payload.data.assignDontCare()
          haltIt()
          haltPc := True

          ramBus.ramFetchCmd.valid := True
          // ramBus.ramFetchCmd.payload.address := (l1bus.cmd.payload.address) / 2
        }
    }
  }
  val refill = new node.Area {
    val fetching = RegInit(False)
    
    when(fetching) {
      when(ramBus.ramFetchRsp.valid) {
        val tag = Tag()
        tag.valid := True
        tag.address := l1bus.cmd.payload.address(tagRange)
        val index = l1bus.cmd.payload.address(setIndexRange)

        mem.write(index, ramBus.ramFetchRsp.payload.data)
        tagBank.write(index, tag)
        fetching := False
      }
    }
    ramBus.ramFetchRsp.ready := False
    
    when(ramBus.ramFetchCmd.valid) {
      fetching := True
      ramBus.ramFetchRsp.ready := True
      ramBus.ramFetchCmd.payload.address := l1bus.cmd.payload.address / 8
    }

  }
  
  val logic = new node.Area {
    l1bus.cmd.ready := True
    when(refill.fetching && l1bus.rsp.valid ) {
      l1bus.cmd.ready := False

    }

  }

  
  val invalidate = new node.Area {
  //  val invalidateCounter = Reg(UInt(log2Up(nSets) bits)) init 0

    // val clearTag = Tag()
    // clearTag.valid := False
    // clearTag.address := 0

    // when(invalidateCounter =/= (nSets-1)) {
    //   tagBank.write(invalidateCounter, clearTag)
    //   invalidateCounter := invalidateCounter + 1
    // } 
  }


}


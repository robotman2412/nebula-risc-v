package nebula.LsuL1


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._




class ICacheBus() extends Bundle with IMasterSlave {
  val cmd  = Flow(L1FetchCmd())
  val rsp  = Flow(L1FetchRsp())
  
  override def asMaster() = {
    in(cmd)
    out(rsp)
  }

}

class ICacheRamBus() extends Bundle with IMasterSlave {
  val cmd = Flow(RamFetchCmd())
  val rsp = Stream(RamFetchRsp())
  
  override def asMaster() = {
    in(rsp)
    out(cmd)
  }
}


case class ICache() extends Area {



  val addressWidth = 64 // 64 bits
  val byteOffset = 2
  val nSets = 256
  val setIndexWidth = log2Up(nSets)
  val setIndexRange = (setIndexWidth + 1 downto 2)
  // val blockSize = 4  // in bytes
  val tagWidth = addressWidth - setIndexWidth - byteOffset
  val tagRange = 63 downto setIndexWidth + byteOffset
  

  val l1bus = new ICacheBus()
  val ramBus = new ICacheRamBus()





  case class Tag() extends Bundle {
    val valid = Bool()
    val address = UInt(tagWidth bits)
  }

  val mem = Mem(Bits(32 bits), nSets) init(Seq.fill(nSets)(B"0"))
  val tagBank = Mem(Tag(), nSets)

  val read = new Area {
    val index = l1bus.cmd.payload.address(setIndexRange)
    val reqTag = l1bus.cmd.payload.address(tagRange)
    val tag = tagBank.readAsync(index)
    
    val hit = tag.valid && tag.address === reqTag
    
    l1bus.rsp.setIdle()
    // l1bus.cmd.setIdle()
    ramBus.cmd.valid := False
    ramBus.cmd.payload.address.assignDontCare()
    when(l1bus.cmd.valid) {
        when(hit) {
          l1bus.rsp.valid := True
          l1bus.rsp.payload.data := mem.readAsync(index)
          l1bus.rsp.payload.miss := False
        }.otherwise {
          l1bus.rsp.payload.miss := True
          l1bus.rsp.valid := False
          l1bus.rsp.payload.data.assignDontCare()

          ramBus.cmd.valid := True
          ramBus.cmd.payload.address := l1bus.cmd.payload.address
        }
    }
  }
  val refill = new Area {
    val fetching = RegInit(False)
    
    when(fetching) {
      when(ramBus.rsp.valid) {
        val tag = Tag()
        tag.valid := True
        tag.address := l1bus.cmd.payload.address(tagRange)
        val index = l1bus.cmd.payload.address(setIndexRange)
        mem.write(index, ramBus.rsp.payload.data)
        tagBank.write(index, tag)
        fetching := False
      }
    }
    ramBus.rsp.ready := False
    // ramBus.cmd.payload.address.assignDontCare()
    // ramBus.cmd.valid := False
    // ramBus.cmd.setIdle()
    when(ramBus.cmd.valid) {
      fetching := True
      ramBus.rsp.ready := True
      ramBus.cmd.payload.address := l1bus.cmd.payload.address
    }

  }


}


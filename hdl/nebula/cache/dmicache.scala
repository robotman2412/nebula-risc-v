package nebula.cache


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._



case class RamFetchCmdDM() extends Bundle {
}
case class RamFetchRspDM() extends Bundle {
}
case class L1FetchCmdDM() extends Bundle {
}
case class L1FetchRspDM() extends Bundle {
}

class ramBus() extends Bundle with IMasterSlave {
  val cmd = Stream(RamFetchCmdDM())
  val rsp = Flow(RamFetchRspDM())

  def asMaster(): Unit = {
    master(cmd)
    slave(rsp)
  }
}

class L1Bus() extends Bundle with IMasterSlave {
  val cmd = Stream(L1FetchCmdDM())
  val rsp = Flow(L1FetchRspDM())
  
  def asMaster(): Unit = {
    master(cmd)
    slave(rsp)
  }
}

//Direct-mapped
case class DMICache(node : Node) extends Area {
  
  val rambus = new ramBus()
  val l1bus = new L1Bus()
  
  val wordSize : Int = 32
  val cacheSize : Int = 4096 // in words (32 or 64 bits)
  val nSets : Int = 256 
  val blockSize : Int = 16 // words per block

  assert(cacheSize == nSets * blockSize)

  val indexWidth : Int = log2Up(nSets)
  val blockWidth : Int = log2Up(blockSize) // Block Index Width
  val byteWidth = 2 // byte index Width // in bits

  val tagWidth = 32 - (indexWidth + blockWidth + byteWidth)

  val tagRange = 31 downto log2Up(nSets * blockSize * byteWidth)
  val indexRange = tagRange.low - 1 downto log2Up(blockSize * byteWidth)
  val blockRange = indexRange.low - 1 downto 2
  val byteRange = 1 downto 0


  case class Tag() extends Bundle {
    val loaded = Bool()
    val valid = Bool()
    val address = Bits(tagWidth bits)
  }

  case class Block() extends Bundle {
    val data = Bits(32 * blockSize bits)

  }

  val banks = new Area {
    val mem = Mem(Block(), nSets)
    val write = mem.writePort()
    val read = mem.readSyncPort
  }
  val tagBank = new Area {
    val mem = Mem(Tag(), nSets)
    val write = mem.writePort()
    val read = mem.readSyncPort
  }

  val cache_hit = Bool()
  val cache_miss = Bool()
  


  
  val read = new Area {
    when(l1bus.cmd.valid) {
      //read address
      // if hit, rsp
      // if miss, send refill cmd

    }



  }
  val refill = new Area {

  }



}

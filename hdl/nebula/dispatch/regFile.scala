package nebula.dispatch


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
// import nebula.decode.AccessKeys._
import nebula.decode.Decoder._
import nebula.decode.RS1

case class RegFileWriteCmd() extends Bundle with IMasterSlave {
  
  val valid = Bool()
  val address = UInt(32 bits)
  val data = Bits(32 bits)

  override def asMaster() = {
    out(valid, address, data)
  }
}

case class RegFileReadCmd() extends Bundle with IMasterSlave {

  val valid = Bool()
  val address = UInt(32 bits)
  val data = Bits(32 bits)

  override def asMaster() = {
    out(address, valid)
    in(data)
  }
}


case class IntRegFile(stage: CtrlLink, readSync: Boolean, dataWidth : Int) extends Area {
  import nebula.decode.AccessKeys._
  val io = new Bundle {
    val RS1_address = in port UInt(5 bits)
    val RS1_Enable = in port Bool()
    val RS2_address = in port UInt(5 bits)
    val RS2_Enable = in port Bool()
    val RD_address = in port UInt(5 bits)
    val RD_Enable = in port Bool()
    val RD_data = in port Bits(dataWidth bits)

    val RS1_data = out port Bits(dataWidth bits)
    val RS2_data = out port Bits(dataWidth bits)

  }

  val readIO = slave(RegFileReadCmd())
  val writeIO = slave(RegFileWriteCmd())

  val reggy = new stage.Area {
    val mem = Mem.fill(32)(Bits(32 bits)) init(Seq.fill(32)(B"0".resize(32)))
    val readRS1 = mem.readSync(io.RS1_address, io.RS1_Enable)
    val readRS2 = mem.readSync(io.RS2_address, io.RS2_Enable)
    val write = mem.write(io.RD_address, io.RD_data, (io.RD_Enable && !(io.RD_address === U(0))))

    io.RS1_data := readRS1
    io.RS2_data := readRS2
  }
}

package nebula.dispatch


import spinal.core.sim._
import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
// import nebula.decode.AccessKeys._
import nebula.decode.Decoder._
import spinal.lib.bus.regif.AccessType.RS

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

class regFileBus() extends Area {
  val read = slave(RegFileReadCmd())
  val write = slave(RegFileWriteCmd())
}

object IntRegFile extends AreaObject {

  val RegFile_RS1 = Payload(Bits(64 bits))
  val RegFile_RS2 = Payload(Bits(64 bits))

}

abstract class RegFile {
  def returnIO : Bundle
}

case class IntRegFile(stage: CtrlLink, readSync: Boolean, dataWidth : Int) extends RegFile with Area {
  import IntRegFile._


  // val IO = new regFileBus()
  val io = new Bundle {
    val RD_address = UInt(5 bits)
    val RD_Enable = Bool()
    val RD_data = Bits(dataWidth bits)
  }

  // val readIO = slave(RegFileReadCmd())
  // val writeIO = slave(RegFileWriteCmd())
  
  override def returnIO: Bundle = io
  val reggy = new stage.Area {
  val accessIntRfRS1 = nebula.decode.Decoder.RS1TYPE === nebula.decode.REGFILE.RSTYPE.RS_INT
  val accessIntRfRS2 = nebula.decode.Decoder.RS2TYPE === nebula.decode.REGFILE.RSTYPE.RS_INT


    val mem = Mem.fill(32)(Bits(64 bits)) 

    val readRS1 = mem.readAsync(nebula.decode.Decoder.RS1.asUInt)
    val readRS2 = mem.readAsync(nebula.decode.Decoder.RS2.asUInt)

    val write = mem.write(io.RD_address, io.RD_data, (io.RD_Enable && !(io.RD_address === U(0))))

    (RegFile_RS1).assignDontCare()
    (RegFile_RS2).assignDontCare()
    when(accessIntRfRS1){
      (RegFile_RS1) := readRS1
    }
    when(accessIntRfRS1 && RS1 === 0){
      RegFile_RS1 := B"0".resize(64)
    }
    when(accessIntRfRS2) {
      (RegFile_RS2) := readRS2
    }
    when(accessIntRfRS2 && RS2 === 0) {
      (RegFile_RS2) := 0
    }
  }
}

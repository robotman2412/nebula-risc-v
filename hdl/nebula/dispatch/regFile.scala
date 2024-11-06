package nebula.dispatch


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
// import nebula.decode.AccessKeys._
import nebula.decode.Decoder._
import nebula.decode.RS1
import nebula.decode.RS2

// case class RegFileWriteCmd() extends Bundle with IMasterSlave {
  
//   val valid = Bool()
//   val address = UInt(32 bits)
//   val data = Bits(32 bits)

//   override def asMaster() = {
//     out(valid, address, data)
//   }
// }

// case class RegFileReadCmd() extends Bundle with IMasterSlave {

//   val valid = Bool()
//   val address = UInt(32 bits)
//   val data = Bits(32 bits)

//   override def asMaster() = {
//     out(address, valid)
//     in(data)
//   }
// }

// class regFileBus() extends Area {
//   val read = slave(RegFileReadCmd())
//   val write = slave(RegFileWriteCmd())
// }

object IntRegFile extends AreaObject {

  val RegFile_RS1 = Payload(Bits(32 bits))
  val RegFile_RS2 = Payload(Bits(32 bits))

}

abstract class RegFile {
  def returnIO : Bundle
}

case class IntRegFile(stage: CtrlLink, readSync: Boolean, dataWidth : Int) extends RegFile with Area {
  import IntRegFile._

  rfaKeys(RS1)

  // val IO = new regFileBus()
  val io = new Bundle {
    //val RS1_address = in port UInt(5 bits)
    //val RS1_Enable = in port Bool()
    //val RS2_address = in port UInt(5 bits)
    //val RS2_Enable = in port Bool()
    val RD_address = in port UInt(5 bits)
    val RD_Enable = in port Bool()
    val RD_data = in port Bits(dataWidth bits)

    //val RS1_data = out port Bits(dataWidth bits)
    //val RS2_data = out port Bits(dataWidth bits)

  }

  // val readIO = slave(RegFileReadCmd())
  // val writeIO = slave(RegFileWriteCmd())
  
  override def returnIO: Bundle = io
  val reggy = new stage.Area {
  val accessIntRfRS1 = (rfaKeys(RS1).RFID === U"1") && (rfaKeys(RS1).ENABLE === True)
  val accessIntRfRS2 = (rfaKeys(RS2).RFID === U"1") && (rfaKeys(RS2).ENABLE === True)

  val rfaRS1 = rfaKeys(RS1)
  val rfaRS2 = rfaKeys(RS2)

    val mem = Mem.fill(32)(Bits(32 bits)) init(Seq.fill(32)(B"0".resize(32)))
    //val readRS1 = mem.readSync(io.RS1_address, io.RS1_Enable)
    // val readRS1 = mem.readSync(rfaRS1.PHYS, accessIntRfRS1)
    val readRS1 = if(readSync) mem.readSync(rfaRS1.PHYS, accessIntRfRS1) else mem.readAsync(rfaRS1.PHYS)

    //val readRS2 = mem.readSync(io.RS2_address, io.RS2_Enable)
    val readRS2 = mem.readSync(rfaRS2.PHYS, accessIntRfRS2)
    val write = mem.write(io.RD_address, io.RD_data, (io.RD_Enable && !(io.RD_address === U(0))))

    (RegFile_RS1).assignDontCare()
    (RegFile_RS2).assignDontCare()
    //io.RS1_data := readRS1
    //io.RS2_data := readRS2
    when(accessIntRfRS1){
      (RegFile_RS1) := readRS1
    }
    when(accessIntRfRS2) {
      (RegFile_RS2) := readRS2
    }
  }
}

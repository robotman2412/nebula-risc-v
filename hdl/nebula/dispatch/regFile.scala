package nebula.dispatch


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
// import nebula.decode.AccessKeys._
import nebula.decode.Decoder._
import nebula.decode.RS1
import nebula.decode.RS2


class regFileWriteBus() extends Area {


}


case class IntRegFile(stage: CtrlLink, readSync: Boolean, dataWidth : Int) extends Area {

  rfaKeys(RS1)
  val accessIntRfRS1 = (rfaKeys(RS1).RFID === U"1") && (rfaKeys(RS1).ENABLE === True)
  val accessIntRfRS2 = (rfaKeys(RS2).RFID === U"1") && (rfaKeys(RS2).ENABLE === True)

  val rfaRS1 = rfaKeys(RS1)
  val rfaRS2 = rfaKeys(RS2)

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
  val RegFile_RS1 = Payload(Bits(32 bits))
  val RegFile_RS2 = Payload(Bits(32 bits))

  val reggy = new stage.Area {
    val mem = Mem.fill(32)(Bits(32 bits)) init(Seq.fill(32)(B"0".resize(32)))
    //val readRS1 = mem.readSync(io.RS1_address, io.RS1_Enable)
    val readRS1 = mem.readSync(rfaRS1.PHYS, accessIntRfRS1)
    //val readRS2 = mem.readSync(io.RS2_address, io.RS2_Enable)
    val readRS2 = mem.readSync(rfaRS2.PHYS, accessIntRfRS2)
    val write = mem.write(io.RD_address, io.RD_data, (io.RD_Enable && !(io.RD_address === U(0))))

    down(RegFile_RS1).assignDontCare()
    down(RegFile_RS2).assignDontCare()
    //io.RS1_data := readRS1
    //io.RS2_data := readRS2
    when(accessIntRfRS1){
      down(RegFile_RS1) := readRS1
    }
    when(accessIntRfRS2) {
      down(RegFile_RS2) := readRS2
    }
  }
}

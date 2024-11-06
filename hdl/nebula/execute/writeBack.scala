package nebula.execute


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.Decoder._
import nebula.dispatch._



case class IntWriteBackPlugin(stage : CtrlLink, rfaAddress : UInt, rfaEnable : Bool, rfaData : Bits, regfile : RegFile) extends Area {

  val rfaRD = nebula.decode.Decoder.rfaKeys(nebula.decode.RD)
  // val rdaRD = 
  
  val io = new Bundle {
    val RD_address = out port UInt(5 bits)
    val RD_Enable = out port Bool()
    val RD_data = out port Bits(64 bits)
  }
  
  regfile.returnIO <> io

  val logic = new stage.Area {
    io.RD_address := rfaRD.PHYS
    io.RD_Enable  := (rfaRD.ENABLE) && (rfaRD.RFID === U"0")
    io.RD_data    := up(nebula.execute.Execute.RESULT).asBits

  }



}

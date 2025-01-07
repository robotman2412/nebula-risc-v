package nebula.execute


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.Decoder._
import nebula.dispatch._



case class IntWriteBackPlugin(stage : CtrlLink, regfile : IntRegFile) extends Area {

  // val rdaRD = 
  
  val io = new Bundle {
    val RD_address = UInt(5 bits)
    val RD_Enable = Bool()
    val RD_data = Bits(64 bits)
  }
  
  
  regfile.io.RD_Enable := io.RD_Enable
  regfile.io.RD_address := io.RD_address
  regfile.io.RD_data := io.RD_data

  import spinal.core.sim._

  val logic = new stage.Area {
    import nebula.decode.REGFILE._
    // instrReg := INSTRUCTION
    io.RD_Enable := False
    io.RD_address.assignDontCare()
    io.RD_data.assignDontCare()
    when(up.isFiring) {
      io.RD_address := up(RD).asUInt
      io.RD_Enable  := (up(nebula.decode.Decoder.RDTYPE) === (RDTYPE.RD_INT))
      io.RD_data    := up(nebula.execute.Execute.RESULT).asBits
    }
  }
}

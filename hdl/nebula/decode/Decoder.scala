package nebula.decode

import spinal.core._
import spinal.lib._
import spinal.lib.logic.Masked._
import spinal.lib.logic._
import nebula.decode.Rv32i.TypeRuops

object Decoder extends Area {
  // println(decode_rv32) 
}

object rv32enum extends SpinalEnum {
  val ADD = newElement()
}

class Decoder() extends Area {
  val io = new Bundle {
    val instr = in port(Bits(32 bits))
  }
  
  
  
  val masked_ADD = Masked(rv32enum.ADD)

  val decode_rv32 = new DecodingSpec(Bits(32 bits))

  decode_rv32.addNeeds(TypeRuops, Masked(Rv32i.ADD.resources))
    
  decode_rv32.build(io.instr,TypeRuops)
}



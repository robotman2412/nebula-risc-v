package nebula.decode

import spinal.core._
import spinal.lib._
import spinal.lib.logic.Masked._
import spinal.lib.logic._
import nebula.decode.Rv32i.TypeRuops
import nebula.decode.Rv32i.TypeIuops
// import nebula.decode.Rv32i.TypeRuops
// import spinal.lib.com.usb.phy.UsbHubLsFs.Ctrl

// object Decoder extends AreaObject {
//   // println(decode_rv32) 
// }

// object rv32enum extends SpinalEnum {
//   val ADD = newElement()
// }

// class CtrlSigs extends Bundle {
//   val alu = Bool()
// }

class Decoder() extends Area {
  val io = new Bundle {
    val instr = in port(Bits(32 bits))
    val result = out port(Bits(16 bits))
  }
  
  
  
  // val masked_ADD = Masked(rv32enum.ADD)

  val decode_rv32 = new DecodingSpec(Bits(16 bits))
  
  // val ctrl = new CtrlSigs
  
  // decode_rv32.addNeeds(TypeRuops, Masked(Rv32i.ADD.resources))
  // decode_rv32.addNeeds(TypeRuops, Masked(U"000111000"))
  decode_rv32.addNeeds(TypeRuops, Masked(U"000111000"))
  decode_rv32.addNeeds(TypeIuops, Masked(U"100111000"))
  decode_rv32.setDefault(Masked(U"111111111111"))
  
  io.result := decode_rv32.build(io.instr, TypeRuops)
    
  // io.result := decode_rv32.build(io.instr,TypeRuops)
}



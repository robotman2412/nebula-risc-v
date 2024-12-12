package nebula.decode

import spinal.lib.misc.pipeline._
import spinal.core._
import spinal.lib._
import spinal.lib.logic.Masked
import spinal.lib.logic.DecodingSpec
import scala.collection.mutable
import nebula.decode.Decoder.{INSTRUCTION => INSTRUCTION}
import nebula.decode.Decoder.{RD => RD}
import spinal.lib.cpu.riscv.impl.Alu


object Decoder extends AreaObject {
  val INSTRUCTION = Payload(Bits(32 bits))

  val LEGAL          = Payload(YESNO())
  val IS_FP          = Payload(YESNO())
  val EXECUTION_UNIT = Payload(ExecutionUnit())
  val RDTYPE         = Payload(REGFILE.RDTYPE())
  val RS1TYPE        = Payload(REGFILE.RSTYPE())
  val RS2TYPE        = Payload(REGFILE.RSTYPE())
  val FSR3EN         = Payload(YESNO())
  val IMMSEL         = Payload(Imm_Select())
  val ALUOP          = Payload(AluOp())
  val IS_BR          = Payload(YESNO())
  val IS_W           = Payload(YESNO())
  val USE_LDQ        = Payload(YESNO())
  val USE_STQ        = Payload(YESNO())
  
  val RD = Payload(Bits(5 bits))
  val RS1 = Payload(Bits(5 bits))
  val RS2 = Payload(Bits(5 bits))


}

object ExecutionUnit extends SpinalEnum(binarySequential) {
  val ALU, FPU, AGU, BR,NA = newElement() 
}

object REGFILE {
  object REGTYPES extends SpinalEnum(binarySequential) {
    val INT, FP, VEC = newElement()
  }
  object RDTYPE extends SpinalEnum (binarySequential) {
    val RD_INT, RD_FP, RD_VEC , RD_NA = newElement()
  }
  object RSTYPE extends SpinalEnum (binarySequential) {
    val RS_INT, RS_FP, RS_VEC ,IMMED, RS_NA= newElement()
  }
}
object Imm_Select extends SpinalEnum (binarySequential) {
    val N_IMM, I_IMM, S_IMM , B_IMM, U_IMM, J_IMM = newElement()
}

object YESNO extends SpinalEnum(binarySequential) {
  val Y,N = newElement()
}


object AluOp extends SpinalEnum(binarySequential) {
  val add, sub, sll, srl, sra, or, xor, slt, sltu, and, na, lui= newElement()
  val addw,sllw,sraw,srlw, subw = newElement()
  val jal, jalr = newElement()
  val beq, bne, bge, bgeu, blt, bltu = newElement()

}

case class Decoder(stage : CtrlLink) extends Area {
  import DecodeTable._
  import ExecutionUnit._
  import Decoder._


  
  // every instr to be mapped to ctrlSigs, through decoder
  // for every ctrlsig, associated value and MaskedLiteral
  // every ctrlsig has a decodingSpec
  // for every instruction, ctrlSig decoding spec gets value
  // then for every ctrlSig build decoder
  // val sigs = Seq(execution_unit, rdtype, rs1type, rs2type)

  
  val all = mutable.LinkedHashSet[Masked]()
  val payloads = Seq(LEGAL,IS_FP, EXECUTION_UNIT , RDTYPE, RS1TYPE, RS2TYPE, FSR3EN, IMMSEL, ALUOP , IS_BR , IS_W )

  val specs = payloads.map(k => new DecodingSpec(k)).zip(payloads)



  // CREATE DEFAULT DECODE
  
  assert(payloads.length == specs.length)
  for((instr, vals) <- X_table) {
    all += Masked(instr)
    for (((spec,signal),i) <- specs.zipWithIndex) {
      // each spec is the DecodingSpec and its associated CtrlSig
      spec.addNeeds(Masked(instr),Masked(vals(i)))
    }
  }
  // for ((vals,i) <- default_decode.zipWithIndex) {
  //   specs(i)._1.setDefault(Masked(vals))
  // }
  // for (vals <- default_decode) {

  // }
  // println(default_decode.zipWithIndex.size)
  // for((vals,i) <- default_decode.zipWithIndex) {
  //   specs(i)._1.setDefault(Masked(vals))
  // }
  // specs(0)._1.setDefault(Masked(default_decode(0)))


  // specs(0)._1.setDefault(Masked(YESNO.N))

  val validDecode = new DecodingSpec(Bool())
  all.foreach(e => validDecode.addNeeds(e, Masked(True)))
  validDecode.setDefault(Masked(False))
  import spinal.core.sim._
  val trap = new stage.Area {
    val shouldHalt = Bool() simPublic()

    shouldHalt := validDecode.build(INSTRUCTION, all)
    // haltWhen(down(Decoder.IS_VAL_INSTR) === YESNO.N)
  }
  // println(all.contains(Masked(M"-------------------------0110111")))

  val decodeLane = new stage.Area {
    for (spec <- specs) {
      down(spec._2).assignDontCare()
      when(up.isFiring) {
        down(spec._2).assignFromBits(spec._1.build(up(INSTRUCTION),all).asBits)
      }
    }
  }
   
  val logic = new stage.Area {
    down(Decoder.RD) :=  up(Decoder.INSTRUCTION)(11 downto 7)
    down(Decoder.RS1) := up(Decoder.INSTRUCTION)(19 downto 15)
    down(Decoder.RS2) := up(Decoder.INSTRUCTION)(24 downto 20)

  }
}




        

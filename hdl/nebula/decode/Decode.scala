package nebula.decode

import spinal.lib.misc.pipeline._
import spinal.core._
import spinal.lib._
import spinal.lib.logic.Masked
import spinal.lib.logic.DecodingSpec
import scala.collection.mutable
import nebula.decode.Decoder.{INSTRUCTION => INSTRUCTION}


object Decoder extends AreaObject {
  val INSTRUCTION = Payload(Bits(32 bits))

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
  
  val RD = Payload(Bits(5 bits))
  val RS1 = Payload(Bits(5 bits))
  val RS2 = Payload(Bits(5 bits))


}

object ExecutionUnit extends SpinalEnum(binarySequential) {
  val ALU, FPU, AGU = newElement() 
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
    val I_IMM, S_IMM ,N_IMM, B_IMM = newElement()
}

object YESNO extends SpinalEnum(binarySequential) {
  val Y,N = newElement()
}


object AluOp extends SpinalEnum(binarySequential) {
  val add, sub, sll, srl, sra, or, xor, slt, sltu, and= newElement()
  val addw,sllw,sraw,srlw, subw = newElement()

}

class CtrlSigs() extends Bundle {
  val is_fp          = YESNO()
  val execution_unit = ExecutionUnit()
  val rdtype         = REGFILE.RDTYPE()
  val rs1type        = REGFILE.RSTYPE()
  val rs2type        = REGFILE.RSTYPE()
  val fsr3en         = YESNO()
  val immSel         = Imm_Select()
  val aluop          = AluOp()
  val is_br          = YESNO()
  val is_w           = YESNO()
  
  val sigs = Seq(is_fp, execution_unit, rdtype, rs1type, rs2type, fsr3en, immSel, aluop, is_br, is_w)
  // val sigs = Seq()
}
case class Decoder(stage : CtrlLink) extends Area {
  import DecodeTable._
  // import CtrlSigs._
  import ExecutionUnit._

  val ctrlSigs = new CtrlSigs()

  
  // every instr to be mapped to ctrlSigs, through decoder
  // for every ctrlsig, associated value and MaskedLiteral
  // every ctrlsig has a decodingSpec
  // for every instruction, ctrlSig decoding spec gets value
  // then for every ctrlSig build decoder
  // val sigs = Seq(execution_unit, rdtype, rs1type, rs2type)

  
  val all = mutable.LinkedHashSet[Masked]()

  val specs = ctrlSigs.sigs.map(k => new DecodingSpec(k)).zip(ctrlSigs.sigs)

  // specs.foreach(e => e._1.setDefault())
  assert(ctrlSigs.sigs.length == specs.length)
  for((instr, vals) <- X_table) {
    all += Masked(instr)
    for (((spec,signal),i) <- specs.zipWithIndex) {
      // each spec is the DecodingSpec and its associated CtrlSig
      spec.addNeeds(Masked(instr),Masked(vals(i)))
      // println(instr, (vals(i)))

     // println(Masked(vals(i)).)
      // gets decodingSpec from spec (spec : decodingSpec, CtrlSig) and adds thing
    }
  }

  val validDecode = new DecodingSpec(Bool())
  all.foreach(e => validDecode.addNeeds(e, Masked(True)))
  validDecode.setDefault(Masked(False))
  val trap = new stage.Area {
    val shouldHalt = Bool()

    shouldHalt := !validDecode.build(up(Decoder.INSTRUCTION), all)
    haltWhen(shouldHalt)
}
  // specs : ((decodingSpec, CtrlSig), Int)
  val decodeLane = new stage.Area {

    for((spec) <- specs) {
      spec._2.assignDontCare()
      when(up.isFiring) {
        spec._2.assignFromBits(spec._1.build(up(Decoder.INSTRUCTION), all).asBits)
      }
    }
  }
  //  val payloads = Seq(Payload(execution_unit), Payload(rdtype), Payload(rs1type), Payload(rs2type)).zip(sigs)
   
  val logic = new stage.Area {
    down(Decoder.IS_FP)          := ctrlSigs.is_fp          
    down(Decoder.EXECUTION_UNIT) := ctrlSigs.execution_unit 
    down(Decoder.RDTYPE)         := ctrlSigs.rdtype         
    down(Decoder.RS1TYPE)        := ctrlSigs.rs1type        
    down(Decoder.RS2TYPE)        := ctrlSigs.rs2type        
    down(Decoder.FSR3EN)         := ctrlSigs.fsr3en         
    down(Decoder.IMMSEL)         := ctrlSigs.immSel         
    down(Decoder.ALUOP)          := ctrlSigs.aluop          
    down(Decoder.IS_BR)          := ctrlSigs.is_br
    down(Decoder.IS_W)           := ctrlSigs.is_w

    
    down(Decoder.RD) :=  up(Decoder.INSTRUCTION)(11 downto 7)
    down(Decoder.RS1) := up(Decoder.INSTRUCTION)(19 downto 15)
    down(Decoder.RS2) := up(Decoder.INSTRUCTION)(24 downto 20)

  }
}


object DecodeTable {
  import RV32I._
  import RV64I._
  import REGFILE._
  import Imm_Select._
  import YESNO._
  // val Y = (1,1)
  // val N = (0,1)
  val X_table: Seq[(MaskedLiteral, Seq[Any])] = Seq(
              //                                                             frs3_en
              //               is val inst?                                  |  imm sel
              //               |  is fp inst?                                |  |     uses_ldq
              //               |  |                          rs1 regtype     |  |     |  uses_stq        is unique? (clear pipeline for it)
              //               |  |                          |       rs2 type|  |     |  |  is_amo       |  flush on commit
              //               |  |  func unit               |       |       |  |     |  |  |            |  |  csr cmd
              //               |  |  |                       |       |       |  |     |  |  |            |  |  |      fcn_dw                      swap12         fma
              //               |  |  |               dst     |       |       |  |     |  |  |  mem       |  |  |      |       fcn_op              | swap32       | div
              //               |  |  |               regtype |       |       |  |     |  |  |  cmd       |  |  |      |       |                   | | typeTagIn  | | sqrt
              //               |  |  |               |       |       |       |  |     |  |  |  |         |  |  |      |       |        ldst       | | | typeTagOut | | wflags
              //               |  |  |               |       |       |       |  |     |  |  |  |         |  |  |      |       |        | wen      | | | | from_int | | |
              //               |  |  |               |       |       |       |  |     |  |  |  |         |  |  |      |       |        | | ren1   | | | | | to_int | | |
              //               |  |  |               |       |       |       |  |     |  |  |  |         |  |  |      |       |        | | | ren2 | | | | | | fast | | |
              //               |  |  |               |       |       |       |  |     |  |  |  |         |  |  |      |       |        | | | | ren3 | | | | | |  | | | |
              //               |  |  |               |       |       |       |  |     |  |  |  |         |  |  |      |       |        | | | | |  | | | | | | |  | | | |
    //                    List(N, N, DC(FC_SZ)     , RT_X  , DC(2) , DC(2) , X, IS_N, X, X, X, M_X,      N, X, CSR.X, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X)

              //                                                                                frs3_en
              //                                                                                |    imm sel       is_br
              //             is fp inst?                                                        |    |      fcn_op   |         uses_ldq
              //             |                                     rs1 regtype                  |    |        |      | is_w      |  uses_stq        is unique? (clear pipeline for it)
              //             |                                          |           rs2 type    |    |        |      |  |        |  |  is_amo       |  flush on commit
              //             |       func unit                          |               |       |    |        |      |  |        |  |  |            |  |  csr cmd
              //             |       |                                  |               |       |    |        |      |  |        |  |  |            |  |  |      fcn_dw                      swap12         fma
              //             |       |                  dst             |               |       |    |        |      |  |        |  |  |  mem       |  |  |      |       fcn_op              | swap32       | div
              //             |       |                  regtype         |               |       |    |        |      |  |        |  |  |  cmd       |  |  |      |       |                   | | typeTagIn  | | sqrt
              //             |       |                  |               |               |       |    |        |      |  |        |  |  |  |         |  |  |      |       |        ldst       | | | typeTagOut | | wflags
              //             |       |                  |               |               |       |    |        |      |  |        |  |  |  |         |  |  |      |       |        | wen      | | | | from_int | | |
              //             |       |                  |               |               |       |    |        |      |  |        |  |  |  |         |  |  |      |       |        | | ren1   | | | | | to_int | | |
              //             |       |                  |               |               |       |    |        |      |  |        |  |  |  |         |  |  |      |       |        | | | ren2 | | | | | | fast | | |
              //             |       |                  |               |               |       |    |        |      |  |        |  |  |  |         |  |  |      |       |        | | | | ren3 | | | | | |  | | | |
              //             |       |                  |               |               |       |    |        |      |  |        |  |  |  |         |  |  |      |       |        | | | | |  | | | | | | |  | | | |
    //                  List(N, ExecutionUnit.FPU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, I_IMM, AluOp.ADD, N, N           X, X, X, M_X,      N, X, CSR.X, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X)

    // LD                 -> List(False, ExecutionUnit.NA, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, False, I_IMM, AluOp.SRA),
  // LWU     -> List(Y, N, X, uopLD   , IQT_MEM, FU_MEM , RT_FIX, RT_FIX, RT_X  , N, IS_I, Y, N, N, N, N, M_XRD, 3.U, N, N, N, N, N, CSR.N),
  // SD      -> List(Y, N, X, uopSTA  , IQT_MEM, FU_MEM , RT_X  , RT_FIX, RT_FIX, N, IS_S, N, Y, N, N, N, M_XWR, 0.U, N, N, N, N, N, CSR.N),

  SLLI        ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.sll , N, N),
  SRLI        ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.srl , N, N),
  SRAI        ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.sra , N, N),
                                                                                                                       
  ADDIW       ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.addw, N, Y),
  SLLIW       ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.sllw, N, Y),
  SRAIW       ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.sraw, N, Y),
  SRLIW       ->       List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.srlw, N, Y),
                                                                                                                       
  ADDW        ->        List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM, AluOp.addw, N, Y),
  SUBW        ->        List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM, AluOp.subw, N, Y),
  SLLW        ->        List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM, AluOp.sllw, N, Y),
  SRAW        ->        List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM, AluOp.sraw, N, Y),
  SRLW        ->        List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM, AluOp.srlw, N, Y),
 
  // LW      -> List(False, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, False, NA   , AluOp.SLL),
  // LH      -> List(Y, N, X, uopLD   , IQT_MEM, FU_MEM , RT_FIX, RT_FIX, RT_X  , N, IS_I, Y, N, N, N, N, M_XRD, 3.U, N, N, N, N, N, CSR.N),
  // LHU     -> List(Y, N, X, uopLD   , IQT_MEM, FU_MEM , RT_FIX, RT_FIX, RT_X  , N, IS_I, Y, N, N, N, N, M_XRD, 3.U, N, N, N, N, N, CSR.N),
  // LB      -> List(Y, N, X, uopLD   , IQT_MEM, FU_MEM , RT_FIX, RT_FIX, RT_X  , N, IS_I, Y, N, N, N, N, M_XRD, 3.U, N, N, N, N, N, CSR.N),
  // LBU     -> List(Y, N, X, uopLD   , IQT_MEM, FU_MEM , RT_FIX, RT_FIX, RT_X  , N, IS_I, Y, N, N, N, N, M_XRD, 3.U, N, N, N, N, N, CSR.N),

  // SW      -> List(Y, N, X, uopSTA  , IQT_MEM, FU_MEM , RT_X  , RT_FIX, RT_FIX, N, IS_S, N, Y, N, N, N, M_XWR, 0.U, N, N, N, N, N, CSR.N),
  // SH      -> List(Y, N, X, uopSTA  , IQT_MEM, FU_MEM , RT_X  , RT_FIX, RT_FIX, N, IS_S, N, Y, N, N, N, M_XWR, 0.U, N, N, N, N, N, CSR.N),
  // SB      -> List(Y, N, X, uopSTA  , IQT_MEM, FU_MEM , RT_X  , RT_FIX, RT_FIX, N, IS_S, N, Y, N, N, N, M_XWR, 0.U, N, N, N, N, N, CSR.N),

  // LUI     -> List(Y, N, X, uopLUI  , IQT_INT, FU_ALU , RT_FIX, RT_X  , RT_X  , N, IS_U, N, N, N, N, N, M_X  , 1.U, Y, N, N, N, N, CSR.N),

  ADDI               -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.add , N, N),
  ANDI               -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.and , N, N),
  ORI                -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.or  , N, N),
  XORI               -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.xor , N, N),
  SLTI               -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.slt , N, N),
  SLTIU              -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM, AluOp.sltu, N, N),

  SLL     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.sll , N, N),
  ADD     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.add , N, N),
  SUB     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.sub , N, N),
  SLT     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.slt , N, N),
  SLTU    -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.sltu, N, N),
  AND     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.and , N, N),
  OR      -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.or  , N, N),
  XOR     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.xor , N, N),
  SRA     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.sra , N, N),
  SRL     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N,N_IMM , AluOp.srl , N, N),
  

  // MUL     -> List(Y, N, X, uopMUL  , IQT_INT, FU_MUL , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_, NX  , 0.U, N, N, N, N, N, CSR.N),
  // MULH    -> List(Y, N, X, uopMULH , IQT_INT, FU_MUL , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // MULHU   -> List(Y, N, X, uopMULHU, IQT_INT, FU_MUL , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // MULHSU  -> List(Y, N, X, uopMULHSU,IQT_INT, FU_MUL , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // MULW    -> List(Y, N, X, uopMULW , IQT_INT, FU_MUL , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),

  // DIV     -> List(Y, N, X, uopDIV  , IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // DIVU    -> List(Y, N, X, uopDIVU , IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // REM     -> List(Y, N, X, uopREM  , IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // REMU    -> List(Y, N, X, uopREMU , IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // DIVW    -> List(Y, N, X, uopDIVW , IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // DIVUW   -> List(Y, N, X, uopDIVUW, IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // REMW    -> List(Y, N, X, uopREMW , IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),
  // REMUW   -> List(Y, N, X, uopREMUW, IQT_INT, FU_DIV , RT_FIX, RT_FIX, RT_FIX, N, IS_X, N, N, N, N, N, M_X  , 0.U, N, N, N, N, N, CSR.N),

  // AUIPC   -> List(Y, N, X, uopAUIPC, IQT_INT, FU_JMP , RT_FIX, RT_X  , RT_X  , N, IS_U, N, N, N, N, N, M_X  , 1.U, N, N, N, N, N, CSR.N), // use BRU for the PC read
  // JAL     -> List(Y, N, X, uopJAL  , IQT_INT, FU_JMP , RT_FIX, RT_X  , RT_X  , N, IS_J, N, N, N, N, N, M_X  , 1.U, N, N, N, N, N, CSR.N),
  // JALR    -> List(Y, N, X, uopJALR , IQT_INT, FU_JMP , RT_FIX, RT_FIX, RT_X  , N, IS_I, N, N, N, N, N, M_X  , 1.U, N, N, N, N, N, CSR.N),
  // BEQ     -> List(Y, N, X, uopBEQ  , IQT_INT, FU_ALU , RT_X  , RT_FIX, RT_FIX, N, IS_B, N, N, N, N, N, M_X  , 0.U, N, Y, N, N, N, CSR.N),
  
  BNE     -> List(N, ExecutionUnit.ALU, RDTYPE.RD_NA, RSTYPE.RS_INT, RSTYPE.RS_INT, N,B_IMM , AluOp.sub , Y, N),
  // BGE     -> List(Y, N, X, uopBGE  , IQT_INT, FU_ALU , RT_X  , RT_FIX, RT_FIX, N, IS_B, N, N, N, N, N, M_X  , 0.U, N, Y, N, N, N, CSR.N),
  // BGEU    -> List(Y, N, X, uopBGEU , IQT_INT, FU_ALU , RT_X  , RT_FIX, RT_FIX, N, IS_B, N, N, N, N, N, M_X  , 0.U, N, Y, N, N, N, CSR.N),
  // BLT     -> List(Y, N, X, uopBLT  , IQT_INT, FU_ALU , RT_X  , RT_FIX, RT_FIX, N, IS_B, N, N, N, N, N, M_X  , 0.U, N, Y, N, N, N, CSR.N),
  // BLTU    -> List(Y, N, X, uopBLTU , IQT_INT, FU_ALU , RT_X  , RT_FIX, RT_FIX, N, IS_B, N, N, N, N, N, M_X  , 0.U, N, Y, N, N, N, CSR.N),

 
  )
}


        

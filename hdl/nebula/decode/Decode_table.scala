package nebula.decode

import spinal.core._

object RV32I {
  

  val ADD                = M"0000000----------000-----0110011"
  val SUB                = M"0100000----------000-----0110011"
  val SLL                = M"0000000----------001-----0110011"
  val SLT                = M"0000000----------010-----0110011"
  val SLTU               = M"0000000----------011-----0110011"
  val XOR                = M"0000000----------100-----0110011"
  val SRL                = M"0000000----------101-----0110011"
  val SRA                = M"0100000----------101-----0110011"
  val OR                 = M"0000000----------110-----0110011"
  val AND                = M"0000000----------111-----0110011"

  val ADDI               = M"-----------------000-----0010011"
  val SLLI               = M"000000-----------001-----0010011"
  val SLTI               = M"-----------------010-----0010011"
  val SLTIU              = M"-----------------011-----0010011"
  val XORI               = M"-----------------100-----0010011"
  val SRLI               = M"000000-----------101-----0010011"
  val SRAI               = M"010000-----------101-----0010011"
  val ORI                = M"-----------------110-----0010011"
  val ANDI               = M"-----------------111-----0010011"

  val LUI                = M"-------------------------0110111"
  val AUIPC              = M"-------------------------0010111"

  val BEQ                = M"-----------------000-----1100011"
  val BNE                = M"-----------------001-----1100011"
  val BLT                = M"-----------------100-----1100011"
  val BGE                = M"-----------------101-----1100011"
  val BLTU               = M"-----------------110-----1100011"
  val BGEU               = M"-----------------111-----1100011"
  val JALR               = M"-----------------000-----1100111"
  val JAL                = M"-------------------------1101111"
  
  val LB                 = M"-----------------000-----0000011"
  val LH                 = M"-----------------001-----0000011"
  val LW                 = M"-----------------010-----0000011"
  val LBU                = M"-----------------100-----0000011"
  val LHU                = M"-----------------101-----0000011"

  val SB                 = M"-----------------000-----0100011"
  val SH                 = M"-----------------001-----0100011"
  val SW                 = M"-----------------010-----0100011"

  val EBREAK             = M"00000000000100000000000001110011"
  val ECALL              = M"00000000000000000000000001110011"
  val MRET               = M"00110000001000000000000001110011"
  val SRET               = M"00010000001000000000000001110011"
  val URET               = M"00000000001000000000000001110011"
  val FENCEI             = M"00000000000000000001000000001111"
  val WFI                = M"00010000010100000000000001110011"

  val FENCE              = M"-----------------000-----0001111"
  val SFENCE_VMA         = M"0001001----------000000001110011"

  val FLUSH_DATA         = M"-------00000-----101-----0001111"
 
}

object RV64I {
  val LWU                = M"-----------------110-----0000011"
  val LD                 = M"-----------------011-----0000011"
  val SD                 = M"-----------------011-----0100011"
  
  val ADDW               = M"0000000----------000-----0111011"
  val SUBW               = M"0100000----------000-----0111011"
  val ADDIW              = M"-----------------000-----0011011"

  val SLLW               = M"0000000----------001-----0111011"
  val SRLW               = M"0000000----------101-----0111011"
  val SRAW               = M"0100000----------101-----0111011"

  val SLLIW              = M"000000-----------001-----0011011"
  val SRLIW              = M"000000-----------101-----0011011"
  val SRAIW              = M"010000-----------101-----0011011"
}




object DecodeTable {
  import RV32I._
  import RV64I._
  import REGFILE._
  import Imm_Select._
  import YESNO._
  val default_decode =  Seq(N,N, ExecutionUnit.NA, RDTYPE.RD_NA, RSTYPE.RS_NA, RSTYPE.RS_NA, N, N_IMM, AluOp.na, N, N)
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

              //                                                                                  frs3_en
              //         valid?                                                                   |    imm sel         is_br
              //            | is fp inst?                                                         |    |      fcn_op     |    uses_ldq
              //            | |                                     rs1 regtype                   |    |        |        | is_w|  uses_stq        is unique? (clear pipeline for it)
              //            | |                                          |           rs2 type     |    |        |        |  |  |  |  is_amo       |  flush on commit
              //            | |       func unit                          |               |        |    |        |        |  |  |  |  |            |  |  csr cmd
              //            | |       |                                  |               |        |    |        |        |  |  |  |  |            |  |  |      fcn_dw                      swap12         fma
              //            | |       |                  dst             |               |        |    |        |        |  |  |  |  |  mem       |  |  |      |       fcn_op              | swap32       | div
              //            | |       |                  regtype         |               |        |    |        |        |  |  |  |  |  cmd       |  |  |      |       |                   | | typeTagIn  | | sqrt
              //            | |       |                  |               |               |        |    |        |        |  |  |  |  |  |         |  |  |      |       |        ldst       | | | typeTagOut | | wflags
              //            | |       |                  |               |               |        |    |        |        |  |  |  |  |  |         |  |  |      |       |        | wen      | | | | from_int | | |
              //            | |       |                  |               |               |        |    |        |        |  |  |  |  |  |         |  |  |      |       |        | | ren1   | | | | | to_int | | |
              //            | |       |                  |               |               |        |    |        |        |  |  |  |  |  |         |  |  |      |       |        | | | ren2 | | | | | | fast | | |
              //            | |       |                  |               |               |        |    |        |        |  |  |  |  |  |         |  |  |      |       |        | | | | ren3 | | | | | |  | | | |
              //            | |       |                  |               |               |        |    |        |        |  |  |  |  |  |         |  |  |      |       |        | | | | |  | | | | | | |  | | | |
    //                 List(N,N, ExecutionUnit.FPU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT,  N, I_IMM, AluOp.ADD,   N, N  X, X, X, M_X,      N, X, CSR.X, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X)

  SLLI        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.sll , N, N, N, N),
  SRLI        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.srl , N, N, N, N),
  SRAI        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.sra , N, N, N, N),
                                                                                                                                   
  ADDIW       ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.addw, N, Y, N, N),
  SLLIW       ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.sllw, N, Y, N, N),
  SRAIW       ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.sraw, N, Y, N, N),
  SRLIW       ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.srlw, N, Y, N, N),
                                                                                                                                   
  ADDW        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.addw, N, Y, N, N),
  SUBW        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.subw, N, Y, N, N),
  SLLW        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.sllw, N, Y, N, N),
  SRAW        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.sraw, N, Y, N, N),
  SRLW        ->       List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.srlw, N, Y, N, N),
                                                                                                                                   

  // LD          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),
  // LWU         ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),
  // LW          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),
  // LH          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),
  // LHU         ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),
  // LB          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),
  // LBU         ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, Y, N),

  // SW          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, N, Y),
  // SH          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, N, Y),
  // SB          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, N, Y),
  // SD          ->       List(Y, N, ExecutionUnit.AGU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, N, Y),

  LUI        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, N, N),

  ADDI       ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.add , N, N, N, N),
  ANDI       ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.and , N, N, N, N),
  ORI        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.or  , N, N, N, N),
  XORI       ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.xor , N, N, N, N),
  SLTI       ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.slt , N, N, N, N),
  SLTIU      ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.IMMED , N, I_IMM , AluOp.sltu, N, N, N, N),
                                                                                                                                  
  SLL        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.sll , N, N, N, N),
  ADD        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.add , N, N, N, N),
  SUB        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.sub , N, N, N, N),
  SLT        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.slt , N, N, N, N),
  SLTU       ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.sltu, N, N, N, N),
  AND        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.and , N, N, N, N),
  OR         ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.or  , N, N, N, N),
  XOR        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.xor , N, N, N, N),
  SRA        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.sra , N, N, N, N),
  SRL        ->        List(Y, N, ExecutionUnit.ALU, RDTYPE.RD_INT, RSTYPE.RS_INT, RSTYPE.RS_INT, N, N_IMM , AluOp.srl , N, N, N, N),
                                                                                                                              
  // AUIPC      ->        List(Y, N, ExecutionUnit.BR, RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.IMMED , N, U_IMM , AluOp.lui , N, N, N, N),
  JAL        ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.RS_NA , N, J_IMM , AluOp.jal , N, N, N, N),
  JALR       ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_INT, RSTYPE.RS_NA , RSTYPE.RS_NA , N, I_IMM , AluOp.jalr, N, N, N, N),
  BEQ        ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_NA , RSTYPE.RS_NA , RSTYPE.RS_NA , N, B_IMM , AluOp.beq , N, N, N, N),

  BNE        ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_NA , RSTYPE.RS_NA , RSTYPE.RS_NA , N, B_IMM , AluOp.bne , Y, N, N, N),
  BGE        ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_NA , RSTYPE.RS_NA , RSTYPE.RS_NA , N, B_IMM , AluOp.bge , Y, N, N, N),
  BGEU       ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_NA , RSTYPE.RS_NA , RSTYPE.RS_NA , N, B_IMM , AluOp.bgeu, Y, N, N, N),
  BLT        ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_NA , RSTYPE.RS_NA , RSTYPE.RS_NA , N, B_IMM , AluOp.blt , Y, N, N, N),
  BLTU       ->        List(Y, N, ExecutionUnit.BR,  RDTYPE.RD_NA , RSTYPE.RS_NA , RSTYPE.RS_NA , N, B_IMM , AluOp.bltu, Y, N, N, N),
                                                                                                                              
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


//  CSRRW              -> List(Y, N, fc2oh(FC_CSR) , RT_FIX, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.W, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  CSRRS              -> List(Y, N, fc2oh(FC_CSR) , RT_FIX, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.S, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  CSRRC              -> List(Y, N, fc2oh(FC_CSR) , RT_FIX, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.C, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//
//  CSRRWI             -> List(Y, N, fc2oh(FC_CSR) , RT_FIX, RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.W, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  CSRRSI             -> List(Y, N, fc2oh(FC_CSR) , RT_FIX, RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.S, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  CSRRCI             -> List(Y, N, fc2oh(FC_CSR) , RT_FIX, RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.C, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//
//  SFENCE_VMA          ->List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_FIX, RT_FIX, N, IS_N, N, N, N,M_SFENCE , Y, Y, CSR.R, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  ECALL              -> List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.I, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  EBREAK             -> List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.I, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  SRET               -> List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.I, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  MRET               -> List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.I, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  DRET               -> List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.I, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//
//  WFI                -> List(Y, N, fc2oh(FC_CSR) , RT_X  , RT_X  , RT_X  , N, IS_I, N, N, N, M_X     , Y, Y, CSR.I, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//
//  FENCE_I            -> List(Y, N, 0.U(FC_SZ.W)  , RT_X  , RT_X  , RT_X  , N, IS_N, N, N, N, M_X     , Y, Y, CSR.N, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//  FENCE              -> List(Y, N, 0.U(FC_SZ.W)  , RT_X  , RT_X  , RT_X  , N, IS_N, N, Y, N, M_X     , Y, Y, CSR.N, DW_XPR, FN_ADD , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//
//
  

 
  )
}

 // def F_table: Seq[(BitPat, List[BitPat])] = Seq(
//   FLW                -> List(Y, Y, fc2oh(FC_AGEN), RT_FLT, RT_FIX, RT_X  , N, IS_I, Y, N, N, M_XRD   , N, N, CSR.N, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//   FLD                -> List(Y, Y, fc2oh(FC_AGEN), RT_FLT, RT_FIX, RT_X  , N, IS_I, Y, N, N, M_XRD   , N, N, CSR.N, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//   FSW                -> List(Y, Y, FCOH_F2IMEM   , RT_X  , RT_FIX, RT_FLT, N, IS_S, N, Y, N, M_XWR   , N, N, CSR.N, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X), // sort of a lie; broken into two micro-ops
//   FSD                -> List(Y, Y, FCOH_F2IMEM   , RT_X  , RT_FIX, RT_FLT, N, IS_S, N, Y, N, M_XWR   , N, N, CSR.N, DW_X  , FN_X   , X,X,X,X,X, X,X,X,X,X,X,X, X,X,X,X),
//
//   FCLASS_S           -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,S,S,N,Y,N, N,N,N,N),
//   FCLASS_D           -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,D,N,Y,N, N,N,N,N),
//
//   FMV_W_X            -> List(Y, Y, fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,S,D,Y,N,N, N,N,N,N),
//   FMV_D_X            -> List(Y, Y, fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,D,D,Y,N,N, N,N,N,N),
//   FMV_X_W            -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,S,N,Y,N, N,N,N,N),
//   FMV_X_D            -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,D,N,Y,N, N,N,N,N),
//
//   FSGNJ_S            -> List(Y, Y, fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,N,Y, N,N,N,N),
//   FSGNJ_D            -> List(Y, Y, fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,N,Y, N,N,N,N),
//   FSGNJX_S           -> List(Y, Y, fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,N,Y, N,N,N,N),
//   FSGNJX_D           -> List(Y, Y, fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,N,Y, N,N,N,N),
//   FSGNJN_S           -> List(Y, Y, fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,N,Y, N,N,N,N),
//   FSGNJN_D           -> List(Y, Y, fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,N,Y, N,N,N,N),
//
//   // FP to FP
//   FCVT_S_D           -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,S,N,N,Y, N,N,N,Y),
//   FCVT_D_S           -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,S,D,N,N,Y, N,N,N,Y),
//
//   // Int to FP
//   FCVT_S_W           -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,S,S,Y,N,N, N,N,N,Y),
//   FCVT_S_WU          -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,S,S,Y,N,N, N,N,N,Y),
//   FCVT_S_L           -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,S,S,Y,N,N, N,N,N,Y),
//   FCVT_S_LU          -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,S,S,Y,N,N, N,N,N,Y),
//
//   FCVT_D_W           -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,D,D,Y,N,N, N,N,N,Y),
//   FCVT_D_WU          -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,D,D,Y,N,N, N,N,N,Y),
//   FCVT_D_L           -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,D,D,Y,N,N, N,N,N,Y),
//   FCVT_D_LU          -> List(Y, Y,fc2oh(FC_I2F) , RT_FLT, RT_FIX, RT_X  , N, IS_I, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,N,N,N, X,X,D,D,Y,N,N, N,N,N,Y),
//
//   // FP to Int
//   FCVT_W_S           -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,S,S,N,Y,N, N,N,N,Y),
//   FCVT_WU_S          -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,S,S,N,Y,N, N,N,N,Y),
//   FCVT_L_S           -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,S,S,N,Y,N, N,N,N,Y),
//   FCVT_LU_S          -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,S,S,N,Y,N, N,N,N,Y),
//
//   FCVT_W_D           -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,D,N,Y,N, N,N,N,Y),
//   FCVT_WU_D          -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,D,N,Y,N, N,N,N,Y),
//   FCVT_L_D           -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,D,N,Y,N, N,N,N,Y),
//   FCVT_LU_D          -> List(Y, Y,fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,N, N,X,D,D,N,Y,N, N,N,N,Y),
//
//
//   FEQ_S              -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,Y,N, N,N,N,Y),
//   FLT_S              -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,Y,N, N,N,N,Y),
//   FLE_S              -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,Y,N, N,N,N,Y),
//
//   FEQ_D              -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,Y,N, N,N,N,Y),
//   FLT_D              -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,Y,N, N,N,N,Y),
//   FLE_D              -> List(Y, Y, fc2oh(FC_F2I) , RT_FIX, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,Y,N, N,N,N,Y),
//
//   FMIN_S             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,N,Y, N,N,N,Y),
//   FMAX_S             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,S,S,N,N,Y, N,N,N,Y),
//   FMIN_D             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,N,Y, N,N,N,Y),
//   FMAX_D             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,N, N,N,D,D,N,N,Y, N,N,N,Y),
//
//   FADD_S             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_00  ,X,X,Y,Y,N, N,Y,S,S,N,N,N, Y,N,N,Y),
//   FSUB_S             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_01  ,X,X,Y,Y,N, N,Y,S,S,N,N,N, Y,N,N,Y),
//   FMUL_S             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_00  ,X,X,Y,Y,N, N,N,S,S,N,N,N, Y,N,N,Y),
//   FADD_D             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_00  ,X,X,Y,Y,N, N,Y,D,D,N,N,N, Y,N,N,Y),
//   FSUB_D             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_01  ,X,X,Y,Y,N, N,Y,D,D,N,N,N, Y,N,N,Y),
//   FMUL_D             -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_00  ,X,X,Y,Y,N, N,N,D,D,N,N,N, Y,N,N,Y),
//
//   FMADD_S            -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_00  ,X,X,Y,Y,Y, N,N,S,S,N,N,N, Y,N,N,Y),
//   FMSUB_S            -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_01  ,X,X,Y,Y,Y, N,N,S,S,N,N,N, Y,N,N,Y),
//   FNMADD_S           -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_11  ,X,X,Y,Y,Y, N,N,S,S,N,N,N, Y,N,N,Y),
//   FNMSUB_S           -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_10  ,X,X,Y,Y,Y, N,N,S,S,N,N,N, Y,N,N,Y),
//   FMADD_D            -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_00  ,X,X,Y,Y,Y, N,N,D,D,N,N,N, Y,N,N,Y),
//   FMSUB_D            -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_01  ,X,X,Y,Y,Y, N,N,D,D,N,N,N, Y,N,N,Y),
//   FNMADD_D           -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_11  ,X,X,Y,Y,Y, N,N,D,D,N,N,N, Y,N,N,Y),
//   FNMSUB_D           -> List(Y, Y,fc2oh(FC_FPU) , RT_FLT, RT_FLT, RT_FLT, Y, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_10  ,X,X,Y,Y,Y, N,N,D,D,N,N,N, Y,N,N,Y)
// )
// def FDivSqrt_table: Seq[(BitPat, List[BitPat])] = Seq(
//   FDIV_S             -> List(Y, Y, fc2oh(FC_FDV) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,X, X,X,S,S,X,X,X, X,Y,N,Y),
//   FDIV_D             -> List(Y, Y, fc2oh(FC_FDV) , RT_FLT, RT_FLT, RT_FLT, N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,Y,X, X,X,D,D,X,X,X, X,Y,N,Y),
//   FSQRT_S            -> List(Y, Y, fc2oh(FC_FDV) , RT_FLT, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,X, X,X,S,S,X,X,X, X,N,Y,Y),
//   FSQRT_D            -> List(Y, Y, fc2oh(FC_FDV) , RT_FLT, RT_FLT, RT_X  , N, IS_N, N, N, N, M_X     , N, N, CSR.N, DW_X  , FN_X   ,X,X,Y,N,X, X,X,D,D,X,X,X, X,N,Y,Y),
// )
//
//

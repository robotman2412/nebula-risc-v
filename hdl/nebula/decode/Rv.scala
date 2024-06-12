package nebula.decode

import spinal.core._
import spinal.lib.logic._

object Rv32i extends AreaObject {
  import IntRegFileAccess._
  
  val ADD                = TypeR(M"0000000----------000-----0110011")
  val SUB                = TypeR(M"0100000----------000-----0110011")
  val SLL                = TypeR(M"0000000----------001-----0110011")
  val SLT                = TypeR(M"0000000----------010-----0110011")
  val SLTU               = TypeR(M"0000000----------011-----0110011")
  val XOR                = TypeR(M"0000000----------100-----0110011")
  val SRL                = TypeR(M"0000000----------101-----0110011")
  val SRA                = TypeR(M"0100000----------101-----0110011")
  val OR                 = TypeR(M"0000000----------110-----0110011")
  val AND                = TypeR(M"0000000----------111-----0110011")

  val ADDI               = TypeI(M"-----------------000-----0010011")
  val SLLI               = TypeI(M"000000-----------001-----0010011")
  val SLTI               = TypeI(M"-----------------010-----0010011")
  val SLTIU              = TypeI(M"-----------------011-----0010011")
  val XORI               = TypeI(M"-----------------100-----0010011")
  val SRLI               = TypeI(M"000000-----------101-----0010011")
  val SRAI               = TypeI(M"010000-----------101-----0010011")
  val ORI                = TypeI(M"-----------------110-----0010011")
  val ANDI               = TypeI(M"-----------------111-----0010011")

  val LUI                = TypeU(M"-------------------------0110111")
  val AUIPC              = TypeUPC(M"-------------------------0010111")

  val BEQ                = TypeB(M"-----------------000-----1100011")
  val BNE                = TypeB(M"-----------------001-----1100011")
  val BLT                = TypeB(M"-----------------100-----1100011")
  val BGE                = TypeB(M"-----------------101-----1100011")
  val BLTU               = TypeB(M"-----------------110-----1100011")
  val BGEU               = TypeB(M"-----------------111-----1100011")
  val JALR               = TypeI(M"-----------------000-----1100111")
  val JAL                = TypeJ(M"-------------------------1101111")
  
  val LB                 = TypeILQ(M"-----------------000-----0000011")
  val LH                 = TypeILQ(M"-----------------001-----0000011")
  val LW                 = TypeILQ(M"-----------------010-----0000011")
  val LBU                = TypeILQ(M"-----------------100-----0000011")
  val LHU                = TypeILQ(M"-----------------101-----0000011")

  val SB                 = TypeSSQ(M"-----------------000-----0100011")
  val SH                 = TypeSSQ(M"-----------------001-----0100011")
  val SW                 = TypeSSQ(M"-----------------010-----0100011")

  val EBREAK             = TypeNone(M"00000000000100000000000001110011")
  val ECALL              = TypeNone(M"00000000000000000000000001110011")
  val MRET               = TypeNone(M"00110000001000000000000001110011")
  val SRET               = TypeNone(M"00010000001000000000000001110011")
  val URET               = TypeNone(M"00000000001000000000000001110011")
  val FENCEI             = TypeNone(M"00000000000000000001000000001111")
  val WFI                = TypeNone(M"00010000010100000000000001110011")

  val FENCE              = TypeNone(M"-----------------000-----0001111")
  val SFENCE_VMA         = TypeNone(M"0001001----------000000001110011")

  val FLUSH_DATA         = TypeNone(M"-------00000-----101-----0001111")

  val UOPs = List(ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, ADDI, SLLI, SLTI, SLTIU, XORI, SRLI, SRAI, ORI, ANDI, LUI, AUIPC, BEQ, BNE, BLT, BGE, BLTU, BGEU, JALR, JAL, LB, LH, LW, LBU, LHU, SB, SH, SW, EBREAK, ECALL, MRET, SRET, URET, FENCEI, WFI, FENCE, SFENCE_VMA, FLUSH_DATA)
  val uopZipped = UOPs.zipWithIndex
  val uopsMasked = uopZipped.map{case (microOp, key) => (Masked(microOp), Masked(key))}
  
  val TypeRuops = Seq(ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND).map(Masked(_))
}

object Rv64i extends AreaObject {
  import IntRegFileAccess._
  
  val LWU                = TypeILQ(M"-----------------110-----0000011")
  val LD                 = TypeILQ(M"-----------------011-----0000011")
  val SD                 = TypeSSQ(M"-----------------011-----0100011")
  
  val ADDW               = TypeR(M"0000000----------000-----0111011")
  val SUBW               = TypeR(M"0100000----------000-----0111011")
  val ADDIW              = TypeI(M"-----------------000-----0011011")

  val SLLW               = TypeR(M"0000000----------001-----0111011")
  val SRLW               = TypeR(M"0000000----------101-----0111011")
  val SRAW               = TypeR(M"0100000----------101-----0111011")

  val SLLIW              = TypeI(M"000000-----------001-----0011011")
  val SRLIW              = TypeI(M"000000-----------101-----0011011")
  val SRAIW              = TypeI(M"010000-----------101-----0011011")
}

object Rv32M extends AreaObject {
  import IntRegFileAccess._
  

  val MUL                = TypeR(M"0000001----------000-----0110011")
  val MULH               = TypeR(M"0000001----------001-----0110011")
  val MULHSU             = TypeR(M"0000001----------010-----0110011")
  val MULHU              = TypeR(M"0000001----------011-----0110011")

  val DIV                = TypeR(M"0000001----------100-----0110011")
  val DIVU               = TypeR(M"0000001----------101-----0110011")
  val REM                = TypeR(M"0000001----------110-----0110011")
  val REMU               = TypeR(M"0000001----------111-----0110011")
  

}

object Rv64M extends AreaObject {
  import IntRegFileAccess._
  
  val MULW               = TypeR(M"0000001----------000-----0111011")
  val DIVW               = TypeR(M"0000001----------100-----0111011")
  val DIVUW              = TypeR(M"0000001----------101-----0111011")
  val REMW               = TypeR(M"0000001----------110-----0111011")
  val REMUW              = TypeR(M"0000001----------111-----0111011")

}


object Rv3264Zicsr extends AreaObject {
  import IntRegFileAccess._
  
  val CSRRW              = TypeI (M"-----------------001-----1110011")
  val CSRRS              = TypeI (M"-----------------010-----1110011")
  val CSRRC              = TypeI (M"-----------------011-----1110011")
  val CSRRWI             = TypeIC(M"-----------------101-----1110011")
  val CSRRSI             = TypeIC(M"-----------------110-----1110011")
  val CSRRCI             = TypeIC(M"-----------------111-----1110011")

}

object Rv3264Zifencei extends AreaObject {
  import IntRegFileAccess._

  val FENCE_I            = TypeNone(M"-----------------001-----0001111")
}

object Rv32a extends AreaObject {
  import IntRegFileAccess._
  
  val LRW                = TypeILQ(M"00010--00000-----010-----0101111")
  val SCW                = TypeASQ(M"00011------------010-----0101111")

  val LRD                = TypeILQ(M"00010--00000-----011-----0101111")
  val SCD                = TypeASQ(M"00011------------011-----0101111")

  val AMOSWAPW           = TypeASQ(M"00001------------010-----0101111")
  val AMOADDW            = TypeASQ(M"00000------------010-----0101111")
  val AMOXORW            = TypeASQ(M"00100------------010-----0101111")
  val AMOANDW            = TypeASQ(M"01100------------010-----0101111")
  val AMOORW             = TypeASQ(M"01000------------010-----0101111")
  val AMOMINW            = TypeASQ(M"10000------------010-----0101111")
  val AMOMAXW            = TypeASQ(M"10100------------010-----0101111")
  val AMOMINUW           = TypeASQ(M"11000------------010-----0101111")
  val AMOMAXUW           = TypeASQ(M"11100------------010-----0101111")
}
object Rv64A extends AreaObject {
  import IntRegFileAccess._

  val AMOSWAPD           = TypeASQ(M"00001------------011-----0101111")
  val AMOADDD            = TypeASQ(M"00000------------011-----0101111")
  val AMOXORD            = TypeASQ(M"00100------------011-----0101111")
  val AMOANDD            = TypeASQ(M"01100------------011-----0101111")
  val AMOORD             = TypeASQ(M"01000------------011-----0101111")
  val AMOMIND            = TypeASQ(M"10000------------011-----0101111")
  val AMOMAXD            = TypeASQ(M"10100------------011-----0101111")
  val AMOMINUD           = TypeASQ(M"11000------------011-----0101111")
  val AMOMAXUD           = TypeASQ(M"11100------------011-----0101111")

}

object Rv32f extends AreaObject {
  import FloatRegFileAccess._
  
  def FLW                = TypeILQ(M"-----------------010-----0000111")
  def FSW                = TypeSSQ(M"-----------------010-----0100111")

  def FMADD_S            = TypeR4(M"-----00------------------1000011")
  def FMSUB_S            = TypeR4(M"-----00------------------1000111")
  def FNMSUB_S           = TypeR4(M"-----00------------------1001011")
  def FNMADD_S           = TypeR4(M"-----00------------------1001111")

  def FADD_S             = TypeR_RM(M"0000000------------------1010011")
  def FSUB_S             = TypeR_RM(M"0000100------------------1010011")
  def FMUL_S             = TypeR_RM(M"0001000------------------1010011")
  def FDIV_S             = TypeR_RM(M"0001100------------------1010011")
  def FSQRT_S            = TypeR1_RM(M"010110000000-------------1010011")

  def FSGNJ_S            = TypeR(M"0010000----------000-----1010011")
  def FSGNJN_S           = TypeR(M"0010000----------001-----1010011")
  def FSGNJX_S           = TypeR(M"0010000----------010-----1010011")
  def FMIN_S             = TypeR(M"0010100----------000-----1010011")
  def FMAX_S             = TypeR(M"0010100----------001-----1010011")

  def FCVT_W_S           = TypeF2I_RM(M"110000000000-------------1010011")
  def FCVT_WU_S          = TypeF2I_RM(M"110000000001-------------1010011")

  def FMV_X_W            = TypeF2I(M"111000000000-----000-----1010011")
  def FEQ_S              = TypeFCI(M"1010000----------010-----1010011")
  def FLT_S              = TypeFCI(M"1010000----------001-----1010011")
  def FLE_S              = TypeFCI(M"1010000----------000-----1010011")

  def FCLASS_S           = TypeF2I(M"111000000000-----001-----1010011")
  def FCVT_S_W           = TypeI2F_RM(M"110100000000-------------1010011")
  def FCVT_S_WU          = TypeI2F_RM(M"110100000001-------------1010011")
  def FMV_W_X            = TypeI2F(M"111100000000-----000-----1010011")

}

object Rv64F extends AreaObject {
  import FloatRegFileAccess._
  
  def FCVT_L_S           = TypeF2I_RM(M"110000000010-------------1010011")
  def FCVT_LU_S          = TypeF2I_RM(M"110000000011-------------1010011")
  def FCVT_S_L           = TypeI2F_RM(M"110100000010-------------1010011")
  def FCVT_S_LU          = TypeI2F_RM(M"110100000011-------------1010011")

}

object Rv32D extends AreaObject {
  import FloatRegFileAccess._
  
  def FLD                = TypeILQ(M"-----------------011-----0000111")
  def FSD                = TypeSSQ(M"-----------------011-----0100111") 

  def FMADD_D            = TypeR4(M"-----01------------------1000011")
  def FMSUB_D            = TypeR4(M"-----01------------------1000111")
  def FNMSUB_D           = TypeR4(M"-----01------------------1001011")
  def FNMADD_D           = TypeR4(M"-----01------------------1001111")

  def FADD_D             = TypeR_RM(M"0000001------------------1010011")
  def FSUB_D             = TypeR_RM(M"0000101------------------1010011")
  def FMUL_D             = TypeR_RM(M"0001001------------------1010011")
  def FDIV_D             = TypeR_RM(M"0001101------------------1010011")
  
  def FSQRT_D            = TypeR1_RM(M"010110100000-------------1010011")
  def FSGNJ_D            = TypeR(M"0010001----------000-----1010011")
  def FSGNJN_D           = TypeR(M"0010001----------001-----1010011")
  def FSGNJX_D           = TypeR(M"0010001----------010-----1010011")
  def FMIN_D             = TypeR(M"0010101----------000-----1010011")
  def FMAX_D             = TypeR(M"0010101----------001-----1010011")
  
  def FCVT_S_D           = TypeR1_RM(M"010000000001-------------1010011")
  def FCVT_D_S           = TypeR1(M"010000100000-------------1010011")

  def FEQ_D              = TypeFCI(M"1010001----------010-----1010011")
  def FLT_D              = TypeFCI(M"1010001----------001-----1010011")
  def FLE_D              = TypeFCI(M"1010001----------000-----1010011")

  def FCLASS_D           = TypeF2I(M"111000100000-----001-----1010011")
  def FCVT_W_D           = TypeF2I_RM(M"110000100000-------------1010011")
  def FCVT_WU_D          = TypeF2I_RM(M"110000100001-------------1010011")
  def FCVT_D_W           = TypeI2F(M"110100100000-------------1010011")
  def FCVT_D_WU          = TypeI2F(M"110100100001-------------1010011")
}

object Rv64D extends AreaObject {
  import FloatRegFileAccess._
  
  def FCVT_L_D           = TypeF2I_RM(M"110000100010-------------1010011")
  def FCVT_LU_D          = TypeF2I_RM(M"110000100011-------------1010011")
  def FMV_X_D            = TypeF2I(M"111000100000-----000-----1010011")
  def FCVT_D_L           = TypeI2F_RM(M"110100100010-------------1010011")
  def FCVT_D_LU          = TypeI2F_RM(M"110100100011-------------1010011")
  def FMV_D_X            = TypeI2F(M"111100100000-----000-----1010011")
}

object Rvv extends AreaObject {
  import VectorRegFileAccess._
}


object Rvc extends AreaObject {
  
}
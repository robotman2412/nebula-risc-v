package nebula.decode

import spinal.core._
import spinal.lib._


class Resource
case class RfResource(rf : RegFileAccess, acess: RfAccess) extends Resource
class RfAccess
class RfRead extends RfAccess 
class RfWrite extends RfAccess

object RS1 extends RfRead with AreaObject
object RS2 extends RfRead with AreaObject
object RS3 extends RfRead with AreaObject
object RD  extends RfWrite with AreaObject
object VS1 extends RfRead with AreaObject
object VS2 extends RfRead with AreaObject
object VD extends RfWrite with AreaObject
object PC_READ  extends Resource with AreaObject
// object PC_NEXT extends Resource with AreaObject
// object INSTRUCTION_SIZE  extends Resource with AreaObject
object LQ  extends Resource with AreaObject
object SQ  extends Resource with AreaObject
object FPU extends Resource with AreaObject
object RM  extends Resource with AreaObject // RM = Rounding Mode
object VPU extends Resource with AreaObject
object LMUL extends Resource with AreaObject

abstract class MicroOp(val resources : Seq[Resource]) {
  def key : MaskedLiteral
}

case class SingleDecoding(key : MaskedLiteral, override val resources : Seq[Resource]) extends MicroOp(resources)
case class MultiDecoding(key: MaskedLiteral, uop : Seq[MicroOp])

trait RegFileAccess {
  // def -> (access : RfAccess) = RfResource(this, access)
}
object IntRegFileAccess extends RegFileAccess with AreaObject {
  def TypeR(key : MaskedLiteral) = SingleDecoding(
    key = key, 
    // resources = List(RS1,RS2, RD).map()
    resources = List(RS1, RS2, RD).map(this -> _)
  )
  def TypeI(key : MaskedLiteral) = SingleDecoding(
    key = key,
    resources = List(RS1, RD).map(this -> _)
  )
  def TypeJ(key : MaskedLiteral) = SingleDecoding(
    key = key,
    resources = List(RD).map(this -> _)
  )
  def TypeB(key : MaskedLiteral) = SingleDecoding(
    key = key,
    resources = List(RS1, RS2).map(this -> _) :+ PC_READ 
  )
  def TypeU(key : MaskedLiteral) = SingleDecoding(
    key = key,
    // resources = List(RD).map(this -> _)
    resources = List(RfResource(RD))
  )
  def TypeUPC(key : MaskedLiteral) = SingleDecoding(
    key = key,
    // resources = List(RD).map(this -> _) :+ PC_READ
    resources = List(
      RfResource(IntRegFileAccess, RD),
      PC_READ
    )
  )
  // def TypeILQ(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RD).map(this -> _) :+ LQ :+ PC_READ //PC_READ is used to reschedule a load which had some store hazard
  // )
  // def TypeSSQ(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RS2).map(this -> _) :+ SQ
  // )
  // def TypeASQ(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RS2, RD).map(this -> _) :+ SQ
  // )
  // def TypeIC(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RD).map(this -> _)
  // )
  // def TypeNone(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = Nil
  // ) 
}

// object FloatRegFileAccess extends RegfileSpec with AreaObject {
  // override def sizeArch = 32
  // override def width = if(Riscv.RVD) 64 else 32
  // override def x0AlwaysZero = false
  // override def getName() = "float"
  // override def initialValue: BigInt = 0 //if(Riscv.RVD) 0x7FF8000000000000l else 0x7fc00000l

  // def TypeR(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RS2, RD).map(this -> _) :+ FPU
  // )
  // def TypeR_RM(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RS2, RD).map(this -> _) :+ FPU :+ RM
  // )
  // def TypeR3_RM(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RS2, RS3, RD).map(this -> _) :+ FPU :+ RM
  // )
  // def TypeR1_RM(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RD).map(this -> _) :+ FPU :+ RM
  // )
  // def TypeR1(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(RS1, RD).map(this -> _) :+ FPU
  // )

  // def TypeILQ(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(IntRegFile -> RS1, FloatRegFile -> RD, LQ, PC_READ)  :+ FPU//PC_READ is used to reschedule a load which had some store hazard
  // )
  // def TypeSSQ(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(IntRegFile -> RS1, FloatRegFile -> RS2, SQ) :+ FPU
  // )

  // def TypeF2I(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(this -> RS1, IntRegFile -> RD) :+ FPU
  // )
  // def TypeF2I_RM(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(this -> RS1, IntRegFile -> RD) :+ FPU :+ RM
  // )
  // def TypeI2F(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(IntRegFile -> RS1, this -> RD) :+ FPU
  // )
  // def TypeI2F_RM(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(IntRegFile -> RS1, this -> RD) :+ FPU :+ RM
  // )
  // def TypeFCI(key : MaskedLiteral) = SingleDecoding(
  //   key = key,
  //   resources = List(this -> RS1, this -> RS2, IntRegFile -> RD) :+ FPU
  // )
// }
// 

object VectorRegFileAccess extends RegFileAccess with AreaObject {
  def TypeVL(key : MaskedLiteral) = SingleDecoding(
    key = key,
    resources = List(
      RfResource(VectorRegFileAccess, VD), 
      RfResource(IntRegFileAccess, RS1)
      )
  )

}
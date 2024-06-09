package nebula.decode

import spinal.core._
import spinal.lib._


class Resource
case class RfResource(acess: RfAccess) extends Resource
class RfAccess
class RfRead extends RfAccess
class RfWrite extends RfAccess

object RS1 extends RfRead with AreaObject
object RS2 extends RfRead with AreaObject
object RS3 extends RfRead with AreaObject
object RD  extends RfWrite with AreaObject
object PC_READ  extends Resource with AreaObject
// object PC_NEXT extends Resource with AreaObject
object INSTRUCTION_SIZE  extends Resource with AreaObject
object LQ  extends Resource with AreaObject
object SQ  extends Resource with AreaObject
object FPU extends Resource with AreaObject
object RM  extends Resource with AreaObject

abstract class MicroOp(val resources : Seq[Resource]) {
  def key : MaskedLiteral
}

case class SingleDecoding(key : MaskedLiteral, override val resources : Seq[Resource]) extends MicroOp(resources)
case class MultiDecoding(key: MaskedLiteral, uop : Seq[MicroOp])

trait RegFileAccess {
  def -> (access : RfAccess) = RfResource(this, access)
}
object IntRefFileAccess extends RegFileAccess with AreaObject {
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
    resources = List(RS1, RS2).map(this -> _) :+ PC_READ :+ INSTRUCTION_SIZE
  )
  def TypeU(key : MaskedLiteral) = SingleDecoding(
    key = key,
    resources = List(RD).map(this -> _)
  )
  // TODO: Finish
}
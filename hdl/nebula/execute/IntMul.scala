package nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


object IntMul extends AreaObject {
  val Ctrl = new SpinalEnum() {
    val MUL, MULH, MULHSU, MULHU, MULW= newElement()
  }
}


class IntMul(thisNode : Node, SRC1 : Payload[Bits], SRC2 : Payload[Bits]) extends Area {
  import IntMul._

}
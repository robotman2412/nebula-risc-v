package nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


object IntMul extends AreaObject {
  val Ctrl = new SpinalEnum() {
    val MUL, MULH, MULHSU, MULHU, MULW= newElement()
  }
}


case class IntMul(mulNode : Node, SRC1 : Payload[Bits], SRC2 : Payload[Bits]) extends Area {
  import IntMul._

  val MUL_RESULT = Payload(SInt(64 bits))
  val CTRL = Payload(IntMul.Ctrl())

  val test = new this.mulNode.Area {
    MUL_RESULT := CTRL.mux(
      Ctrl.MUL     -> ((SRC1.asSInt * SRC2.asSInt)(31 downto 0)).resized,
      Ctrl.MULH    -> ((SRC1.asSInt * SRC2.asSInt)(63 downto 32)).resized,
      Ctrl.MULHSU  -> ???,
      Ctrl.MULHU   -> (SRC1.asUInt * SRC2.asUInt).resized,
      Ctrl.MULW    -> (SRC1.asSInt * SRC2.asSInt).resized
    )

  }
}

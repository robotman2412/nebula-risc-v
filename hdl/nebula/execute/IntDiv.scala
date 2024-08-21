package nebula.cpu.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

object IntDiv extends AreaObject {
  val Ctrl = new SpinalEnum() {
    val DIV, DIVU, REM, REMU, DIVW, DIVUW, REMW, REMUW = newElement
  }
}



case class IntDiv(divNode : Node, SRC1 : Payload[Bits], SRC2 : Payload[Bits]) extends Area {
  import IntDiv._

  val DIV_RESULT = Payload(SInt(64 bits))
  val CTRL = Payload(IntDiv.Ctrl())

  val logic = new divNode.Area {
    DIV_RESULT := CTRL.mux(
      Ctrl.DIV     -> ((SRC1.asSInt * SRC2.asSInt)(31 downto 0)).resize(64),
      Ctrl.DIVU    -> ((SRC1.asSInt * SRC2.asSInt)(63 downto 32)).resize(64),
      Ctrl.REM  -> ???,
      Ctrl.REMU   -> (SRC1.asUInt * SRC2.asUInt),
      Ctrl.DIVW    -> (SRC1.asSInt * SRC2.asSInt).resize(32).resize(64),
      Ctrl.DIVUW  -> (SRC1.asUInt * SRC2.asUInt),
      Ctrl.REMW   -> (SRC1.asUInt * SRC2.asUInt),
      Ctrl.REMUW  -> (SRC1.asUInt * SRC2.asUInt)
    )

  }
}

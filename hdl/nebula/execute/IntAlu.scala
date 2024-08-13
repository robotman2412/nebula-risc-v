package nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

object IntAluCtrl extends AreaObject {
  val BitWiseCtrl = new SpinalEnum() {
    val XOR, OR, AND = newElement()
  }

  val AluCtrl = new SpinalEnum() {
    val ADD_SUB, SLT_SLTU, SLLI, SRLI, SRAI, SUB= newElement()
  }

  
}

class IntAlu(thisNode : Node, SRC1 : Payload[SInt],SRC2 : Payload[SInt]) extends Area {
  import IntAluCtrl._
  val node = thisNode

  val RESULT = Payload(Bits(32 bits))
  val logit = new node.Area {
    RESULT.mux(
      BitWiseCtrl.XOR  -> (SRC1 ^ SRC2),
      BitWiseCtrl.OR   -> (SRC1 | SRC2),
      BitWiseCtrl.AND  -> (SRC1 & SRC2),
      AluCtrl.ADD_SUB      -> (SRC1 + SRC2),
      AluCtrl.SLT_SLTU      -> ???,
      AluCtrl.SLLI      -> ???,
      AluCtrl.SRLI      -> ???,
      AluCtrl.SRAI      -> ???,
      AluCtrl.SUB      -> (SRC1 - SRC2)
    )
  }



  
}

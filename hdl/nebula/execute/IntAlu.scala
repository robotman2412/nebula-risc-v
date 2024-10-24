package nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

object IntAluCtrl extends AreaObject {
  val AluCtrl = new SpinalEnum() {
    val ADD_SUB, SLT_SLTU, SLLI, SRLI, SRAI, SUB= newElement()
    val XOR, OR, AND = newElement()
  }
}

case class IntAlu(aluNode : CtrlLink) extends Area {
  import IntAluCtrl._

  val SRC1 = Payload(SInt(32 bits))
  val SRC2 = Payload(SInt(32 bits))
  val CTRL = Payload(AluCtrl())
  val RESULT = Payload(Bits(32 bits))
  
  
  val aluNodeStage = new aluNode.Area {
    val logic = new aluNode.Area {
      import nebula.dispatch.Dispatch._

      when(alu_valid === True) {
      val result = up(CTRL).mux(
        AluCtrl.XOR  -> (up(SRC1) ^ up(SRC2)),
        AluCtrl.OR   -> (SRC1 | SRC2),
        AluCtrl.AND  -> (SRC1 & SRC2),
        AluCtrl.ADD_SUB      -> (SRC1 + SRC2),
        AluCtrl.SLT_SLTU      -> ???,
        AluCtrl.SLLI      -> ???,
        AluCtrl.SRLI      -> ???,
        AluCtrl.SRAI      -> ???,
        AluCtrl.SUB      -> (SRC1 - SRC2)
      )
      down(RESULT) := result.asBits
        
      }
    }
  }
}

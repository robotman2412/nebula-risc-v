package nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.Decoder.FUNCT3

object AluCtrl {
  val ADD  = B"000"
  val SUB  = B"000"
  val SLL  = B"001"
  val SLT  = B"010"
  val SLTU = B"011"
  val XOR  = B"100"
  val SRL  = B"101"
  val SRA  = B"101"
  val OR   = B"110"
  val AND  = B"111"
  
  // val op2List = List(ADD,SUB,SLL,SLT,SLTU,XOR,SRL,SRA,OR,AND)
  // val alu_ctrl = Bits(log2Up(op2List.size) bits)
  // val op2Enum = op2List.zipWithIndex.map{case (op,i) => op -> B(i, widthOf(alu_ctrl) bits)}
}

case class IntAlu(aluNode : CtrlLink) extends ExecutionUnit with Area {
  import AluCtrl._

  // val SRC1 = Payload(SInt(32 bits))
  val SRC1 = nebula.dispatch.SrcPlugin.RS1
  // val SRC2 = Payload(SInt(32 bits))
  val SRC2 = nebula.dispatch.SrcPlugin.RS2
  // val RESULT = Payload(Bits(32 bits))
  
  import nebula.execute.Execute._
  // add(Rvi32.ADD).decode(CTRL -> AluCtrl.ADD_SUB)
  
  val aluNodeStage = new aluNode.Area {
    val logic = new aluNode.Area {
      import nebula.dispatch.Dispatch._

      when(up(SEL) === True) {
      val result = up(FUNCT3).mux(
        AluCtrl.XOR  -> (up(SRC1) ^ up(SRC2)),
        AluCtrl.OR   -> (SRC1 | SRC2),
        AluCtrl.AND  -> (SRC1 & SRC2),
        AluCtrl.ADD      -> (SRC1.asSInt + SRC2.asSInt),
        AluCtrl.SLT      -> ???,
        AluCtrl.SLTU      -> ???,
        AluCtrl.SLL      -> ???,
        AluCtrl.SRL      -> ???,
        AluCtrl.SRA      -> ???,
        AluCtrl.SUB      -> (SRC1.asSInt - SRC2.asSInt)
      )
      down(RESULT) := result.asBits
        
      }
    }
  }
}

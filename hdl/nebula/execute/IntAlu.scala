package nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.Decoder._
import nebula.decode.YESNO
import nebula.decode.Imm_Select
import nebula.decode.ExecutionUnitEnum.ALU
import nebula.dispatch.SrcPlugin.IMMED


case class IntAlu(aluNode : CtrlLink) extends FunctionalUnit with Area {
  val SRC1 = nebula.dispatch.SrcPlugin.RS1
  val SRC2 = nebula.dispatch.SrcPlugin.RS2
  
  override val FUType = nebula.decode.ExecutionUnitEnum.ALU
  import nebula.execute.Execute._
  
  val aluNodeStage = new aluNode.Area {
      import nebula.dispatch.Dispatch._
      import nebula.decode.AluOp
      
      val result = Bits(64 bits)
      result.assignDontCare()
      when(up(nebula.dispatch.Dispatch.SENDTOALU) === True && aluNode.isValid && up(SEL)) {
        result := up(ALUOP).muxDc(
          AluOp.xor      -> (SRC1 ^ SRC2),
          AluOp.or       -> (SRC1 | SRC2),
          AluOp.and      -> (SRC1 & SRC2),
          AluOp.add      -> (SRC1.asSInt + SRC2.asSInt).asBits,
          AluOp.sll      -> (SRC1.asUInt |<< (SRC2(6 downto 0)).asUInt).asBits,
          AluOp.srl      -> (SRC1.asUInt |>> (SRC2(6 downto 0)).asUInt).asBits,
          AluOp.sra      -> (SRC1.asUInt  >> (SRC2(6 downto 0)).asUInt).asBits,
          AluOp.sub      -> (SRC1.asSInt - SRC2.asSInt).asBits,

          AluOp.addw     -> (SRC1.asSInt + SRC2.asSInt)(31 downto 0).resize(64).asBits,
          AluOp.sllw     -> (SRC1.asUInt |<< SRC2(4 downto 0).asUInt)(31 downto 0).resize(64).asBits,
          AluOp.sraw     -> (SRC1.asUInt  >> SRC2(4 downto 0).asUInt)(31 downto 0).resize(64).asBits,
          AluOp.srlw     -> (SRC1.asUInt |>> SRC2(4 downto 0).asUInt)(31 downto 0).resize(64).asBits,
          AluOp.subw     -> (SRC1.asSInt - SRC2.asSInt)(31 downto 0).resize(64).asBits,
          AluOp.lui      -> SRC2.asBits
        )
      }
      

      when(up(ALUOP) === AluOp.slt) {
        val slt = (SRC1.asSInt < SRC2.asSInt)
        result := slt.asBits.resize(64)
        
      }
      when(up(ALUOP) === AluOp.sltu) {
        val sltu = (SRC1.asUInt < SRC2.asUInt)
        result := sltu.asBits.resize(64)
      }
      down(RESULT).assignDontCare()
      import YESNO._
      when(up.isFiring) {
        when(up(nebula.decode.Decoder.IS_W) === Y) {
          down(RESULT) := result(31 downto 0).resize(64).asBits
        } otherwise {
          down(RESULT) := result.asBits
        }
      }
  }
}

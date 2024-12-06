package nebula.execute


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode.AluOp
import nebula.cache.PC
import nebula.cache.JumpCmd
import nebula.decode.Decoder.ALUOP
import nebula.dispatch.SrcPlugin.IMMED




case class CtrlHazardThrowPipeline(decodeNode : CtrlLink, hzRange : Seq[CtrlLink], pc : PC) extends Area {
  val logic = new decodeNode.Area {
    when(up(nebula.decode.Decoder.ALUOP) === AluOp.jal) {
      decodeNode.haltWhen(pc.jumpcmd.valid && hzRange.map(e => e.up(nebula.decode.Decoder.ALUOP) === AluOp.jal).reduce(_ || _))
      decodeNode.throwWhen(pc.jumpcmd.valid)
      // when JAL, stall pipeline, update PC, carryone
    }
    
    when(up(nebula.decode.Decoder.ALUOP) === AluOp.jalr) {
      decodeNode.haltWhen(pc.jumpcmd.valid && hzRange.map(e => e.up(nebula.decode.Decoder.ALUOP) === AluOp.jalr).reduce(_ || _))
      decodeNode.throwWhen(pc.jumpcmd.valid)
      // when JAL, stall pipeline, update PC, carryone
    }
  }
}

case class Branch(node : CtrlLink) extends Area {
  
  val SRC1 = nebula.dispatch.SrcPlugin.RS1
  val SRC2 = nebula.dispatch.SrcPlugin.RS2
  
  val doJump = Bool()
  val doBranch = Bool()
  
  val jmpCmd = Flow(JumpCmd())
  
  val logic = new node.Area {
    doJump := False
    when(up(nebula.decode.Decoder.ALUOP) === AluOp.jal || up(nebula.decode.Decoder.ALUOP) === AluOp.jalr) {
      doJump := True
    }

  }
  
  val branchlogic = new node.Area {
    doBranch := False
    when(up(nebula.dispatch.Dispatch.SENDTOBRANCH) === True && up.isValid) {
      doBranch := (ALUOP).muxDc(
        AluOp.beq -> (SRC1.asSInt === SRC2.asSInt),
        AluOp.bne -> (SRC1.asSInt =/= SRC2.asSInt),
        AluOp.bge -> (SRC1.asSInt >= SRC2.asSInt),
        AluOp.bgeu -> (SRC1.asUInt >= SRC2.asUInt),
        AluOp.blt -> (SRC1.asSInt <= SRC2.asSInt),
        AluOp.bltu -> (SRC1.asUInt <= SRC2.asUInt),
      )
    }
    jmpCmd.valid := False
    jmpCmd.payload.address.assignDontCare()
    when(doJump) {
      jmpCmd.valid := True
      jmpCmd.payload.address := IMMED.asUInt
    }

  }
  
  
  

}

case class Jal(node : CtrlLink) extends Area {
  val jumpLocation =  Flow(JumpCmd())
  
  
  val SRC2 = nebula.dispatch.SrcPlugin.RS2
  
  val logic = new node.Area {
    val validJump = Bool()
    jumpLocation.address.assignDontCare()
    jumpLocation.valid := False
    
    when(up(nebula.dispatch.Dispatch.SENDTOBRANCH) === True && up.isValid) {
      // RESULT := PCPLUS4
      jumpLocation.address := SRC2.asUInt
      jumpLocation.valid := True
    }
  }
}
package nebula.cache

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.misc.pipeline._

case class JumpCmd() extends Bundle {
  val address = UInt(64 bits)
}

trait throwPipe extends AreaObject {
  val jumpCmd = Flow(JumpCmd())

  
}


case class PC(node : CtrlLink) extends Area with throwPipe {
  
  val jumpcmd = Flow(JumpCmd())
  
  val PC = Payload(UInt(64 bits))
  val PCPLUS4 = Payload(UInt(64 bits))

  val pc = new node.Area {
    val pcReg = Reg(PC) init(0) simPublic()
    up(PC) := pcReg
    // PCPLUS4 := PC + 4
    PCPLUS4 := pcReg + 4
    up.valid := True

    when(up.isFiring) {
      pcReg := jumpcmd.valid ? jumpcmd.payload.address | (PC + 4)
    }
  }
}

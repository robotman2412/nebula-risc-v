package nebula.LsuL1

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
object PC extends AreaObject {
  val PCVal = Payload(UInt(64 bits))
  val PCPLUS4 = Payload(UInt(64 bits))
}


case class PC(node : CtrlLink) extends Area with throwPipe {
  import PC._
  
  val jumpcmd = Flow(JumpCmd())
  


  val pclogic = new node.Area {
    val pcReg = Reg(PCVal) init(0) simPublic()
    up(PCVal) := pcReg
    PCPLUS4 := pcReg + 4
    up.valid := True

    when(up.isFiring) {
      pcReg := jumpcmd.valid ? jumpcmd.payload.address | (PCVal + 4)
    }
  }
}

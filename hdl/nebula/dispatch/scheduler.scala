package nebula.dispatch

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


object Dispatch extends AreaObject {
  val alu_valid = Payload(Bool())
}

case class Dispatch(node: CtrlLink, hazardRange: Seq[CtrlLink]) extends Area {

  import nebula.decode.Decoder._
  import Dispatch._
  val uop = List(IS_INT, NEED_PC, FU_ALU)
  val op = uop.toStream
  
  val hazard = Bool()
  hazard := False
  
  val nodeArea = new node.Area {
    down(alu_valid) := False

    when(hazard) {
      haltIt()
    }
    when(up(FU_ALU) && !hazard) {
      down(alu_valid) := True

    }
    
  }

  // what EU does it want

  // when not hazard, and EU free
  
}
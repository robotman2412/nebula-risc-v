package nebula.dispatch

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.sim._
import spinal.lib.misc.pipeline._

import nebula.decode.Decoder._
import nebula.decode.Decoder
import nebula.decode.ExecutionUnitEnum
import nebula.decode.AluOp
import nebula.LsuL1.PC


// object Dispatch extends AreaObject {
//   val alu_valid = Payload(Bool())
// }

// class UopLayerSpec(val uop: MicroOp, val elImpl : LaneLayer) {

// }

// class LaneLayer(val name : String, var priority : Int) {

// }

/*
How to detect RD->RSx hazards for a given candidate:
0)  for each ctrl (pipeline deepness)
      for each execute lane
        decode if RD is readable or not
1)  for each ctrl (pipeline deepness)
      for each execute lane,
        generate a hazard signal := ctrl.rd == RSx
      Aggregate the lanes hazards
2)  for each implementation slot
      process if scheduled to that slot would produce hazards
3)  schedule to the implementation slot with the best priority

 */



case class HazardChecker(hzRange : Seq[CtrlLink]) extends Area {
  // RAW Hazards
  // WAW hazard
  // Control hazards (branch not yet resolved)
  // Structural hazard
  
  // hzRange = rfRead -> rfWriteback

  // WAR hazard
  // intended : write RD after reading RS

  // something like
  // takes in range
  // gets Stage(1), Stage(2)
  // checks if RD /RS is same
  // then call functionally on whole range
  // if match, stallIt/Upper until hazard fixed

  // RAW hazard
  // if RD is hzRange(0) === RSx in hzRange(1 .. n-1) 

  // hzRange.head(RD)
  // val rs1Hazard = for (stage <- hzRange.tail) {
    
  // }

  val isRs1Haz = hzRange.tail.map(e => 
    (hzRange.head(RS1) =/= 0) &&
    (hzRange.head(RS1) === e(RD)) &&
    e.up(nebula.decode.Decoder.RDTYPE) === (nebula.decode.REGFILE.RDTYPE.RD_INT))

    // isRs1Haz.zipWithIndex.foreach(e => hzRange(e._2).haltWhen(e._1))
  hzRange.head.haltWhen(isRs1Haz.reduce(_ || _) simPublic())
  // when (isRs1Haz.reduce(_ || _) simPublic()) {
    // hzRange.head.haltIt() 
    // hzRange.head.isReady := False
  // }

  val isRs2Haz = hzRange.tail.map(e => 
    (hzRange.head(RS2) =/= 0) &&
    (hzRange.head(RS2) === e(RD)) &&
    e.up(nebula.decode.Decoder.RDTYPE) === (nebula.decode.REGFILE.RDTYPE.RD_INT))
    
  // isRs2Haz.zipWithIndex.foreach(e => hzRange(e._2).haltWhen(e._1))

  when (isRs2Haz.reduce(_ || _) simPublic()) {
    hzRange.head.haltIt()
  }

}


/*
How to check if a instruction can schedule :
- If one of the pipeline which implement its micro op is free
- There is no inflight non-bypassed RF write to one of the source operand
- There is no scheduling fence
- For credit based execution, check there is enough credit

Schedule heuristic :
- In priority order, go through the slots
- Check which pipeline could schedule it (free && compatible)
- Select the pipeline which the highest priority (to avoid using the one which can do load and store, for instance)
- If the slot can't be schedule, disable all following ones with same HART_ID
*/


object Dispatch extends AreaObject {
  val SENDTOALU = Payload(Bool())
  val SENDTOBRANCH = Payload(Bool())
}

case class Dispatch(dispatchNode: CtrlLink) extends Area {

  //import nebula.decode.Decoder._
  import Dispatch._
  // val op = uop.toStream


  // if uop match EU uop
  // check hazards
  // set EU to fire

  val logic = new dispatchNode.Area {
    // when(up.isValid) {
    //   eus.foreach(f => f.SEL := False) 
    // }
    down(SENDTOALU) := False
    down(SENDTOBRANCH) := False
    when(up(Decoder.EXECUTION_UNIT) === ExecutionUnitEnum.ALU) {
      down(SENDTOALU) := True
    }
    when(up(Decoder.EXECUTION_UNIT) === ExecutionUnitEnum.BR) {
      down(SENDTOBRANCH) := True
    }

  }

  // logic?
  // for each EU check if UOP maps.
  // if maps send to, and execute, as long as no hazard
  // if uop match EU, SEL := TRUE
  // eus.foreach {
  //   if (uopList(op)) {
  //     eus.SEL := True
  //   }
  //   // check if transaction is moving, indicates EU is free/stage is free
  //   eus.node.isMoving()
  // }


  
  // val nodeArea = new dispatchNode.Area {
  //   down(alu_valid) := False

  //   when(hazard) {
  //     haltIt()
  //   }
  //   when(up(FU_ALU) && !hazard) {
  //     down(alu_valid) := True

  //   }
    
  // }

  // what EU does it want

  // when not hazard, and EU free
  
}

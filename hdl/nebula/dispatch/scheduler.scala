package nebula.dispatch

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._

import nebula.decode.Decoder._


object Dispatch extends AreaObject {
  val alu_valid = Payload(Bool())
}

class UopLayerSpec(val uop: MicroOp, val elImpl : LaneLayer) {

}

class LaneLayer(val name : String, var priority : Int) {

}

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
  
  // hzRange = rfRead -> rfWriteback

  // WAR hazard
  // intended : write RD after reading RS





  // RAW hazard
  // intended : read RS before Write
  // if instr 1 rd === inst 2 rs
  val RAW = for ((stages,id) <- hzRange.zipWithIndex) {
    // if hzRange[i].rd === [hzRange[i-1].rs

  }

}

case class SrcPlugin() extends Area {
  // if RF then RF should read
  // also maybe choose forwarded value


  // Maybe with EXU, tell SRC which OPS want which IMM. also acts as SEXT plugin


  val RS1 = Payload(Bits (32 bits))
  val RS2 = Payload(Bits (32 bits))

  match(RS1_SRC) {
    case(RF) {
      RS1 := RegFile_RS1
    }
    case (U) {
      ???
    }
  }
  match(RS2_SRC) {
    case(RF) {RS1 := RegFile_RS1}
    case(I) {}
    case(S) {}
    case(PC) {}
  }



}

/*
How to check if a instruction can schedule :
- If one of the pipeline which implement its micro op is free
- There is no inflight non-bypassed RF write to one of the source operand
- There is no scheduling fence
- For credit based execution, check there is enough credit

Schedule euristic :
- In priority order, go through the slots
- Check which pipeline could schedule it (free && compatible)
- Select the pipeline which the highest priority (to avoid using the one which can do load and store, for instance)
- If the slot can't be schedule, disable all following ones with same HART_ID
*/



case class Dispatch(dispatchNode: CtrlLink, rfReadNode: CtrlLink, hazardRange: Seq[CtrlLink]) extends Area {

  //import nebula.decode.Decoder._
  import Dispatch._
  val uop = List(IS_INT, NEED_PC, FU_ALU)
  val op = uop.toStream


  // if uop match EU uop
  // check hazards
  // set EU to fire

  val eus = List[ExecutionUnit]()

  down(RS1) := RS1_Source.mux(
    SrcKeys.SRC1.RF ->
    


    )


  // logic?
  // for each EU check if UOP maps.
  // if maps send to, and execute, as long as no hazard
  // if uop match EU, SEL := TRUE
  eus.foreach {
    if (uopList(op)) {
      eus.SEL := True
    }
    // check if transaction is moving, indicates EU is free/stage is free
    eus.node.isMoving()
  }


  
  val hazard = Bool()
  hazard := False
  
  val nodeArea = new dispatchNode.Area {
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

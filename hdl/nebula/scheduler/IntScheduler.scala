package nebula.schedule


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode._
import scala.collection.mutable
import nebula.decode.RegFileAccess



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


// TODO 
// something like, 
// track every RD/RS in the pipeline
// store in circular buffer/ROB
// check for hazards
// when no hazards execute



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

// things to keep in mind. regfile data dependencies
// branches and impact on pipeline
// atomic ops and impact on pipeline


// Keep in mind
// control/data dependency
// pipeline flushing



class HazardChecker(hazardsRange: Seq[CtrlLink]) extends Area {
  val opReadStage = hazardsRange.head
  // hazard Range = from Operand read to writeback/execute
 // val intAt = ???
 // val floatAt = ???
 // val memAt = ???
 // val rfaReads = Decoder.rfaKeys.filter(_._1.isInstanceOf[RfRead])


 // class HazardLine() extends Bundle {

 //   val rs1,rs2,rs3,rd = Bits(5 bits)
 // }

  //val reservationChecker = ???

  //RAW hazards
  // isRAW = is RD(stage+n) === RS(operand read stage)
  //
  val rfaReads = Decoder.rfaKeys.filter(_._1.isInstanceOf[RfRead])
  val rfaWrites = Decoder.rfaKeys.filter(_._1.isInstanceOf[RfWrite])

  case class rfDependecyLine() extends Bundle {
    val register = Bits(5 bits)
    val regFile = UInt(2 bits)
  }
  val rfTable = Mem.fill(32)(rfDependecyLine())
  
  
  val rfDependencyTable = ???
  val RAWChecker = new opReadStage.Area {
    val currentRS1 = mutable.LinkedHashMap[RegFileAccess, AccessKeys]()
    val isRAW = for (stage <- hazardsRange.tail) yield new Area {
      val checkHazard = rfaReads(RS1).PHYS
    }
  }






  val resources = mutable.LinkedHashSet[Resource]()
  val readAccess = Seq[AccessKeys]()


  val flushSpec = ???
  val canForwardSpec = ???



  val onRs = for (rs <- readAccess) yield new Area {
    val uopsOnRs = mutable.ArrayBuffer[(MicroOp, Int)]()
    val readAts = mutable.LinkedHashSet[Int]() 
    val regFiles = mutable.LinkedHashSet[RegFileAccess]() 
    val rfa = rs.rfa.asInstanceOf[RfRead]



  }





}


class Scheduler(node: CtrlLink) extends Area{
  val thisNode = node

  val lanes = 4

  //dispatch logic?
  val logic = for (lane <- 0 until lanes) yield new Area {

  }
  val flushSpec = ???
  //architecture? dispatch here, send to respective scheduler

  def IntIssueQueue = ???
  def MemIssueQueue = ???
  def FltIssueQueue = ???
  def VecIssueQueue = ???

  val dispatch = for (lane <- 0 until lanes) yield new thisNode.Area {
    when(Decoder.IS_INT === True) {

    }

  }

  val scoreBoard = ???




}







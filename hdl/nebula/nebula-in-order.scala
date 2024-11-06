package nebula


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


import nebula.decode._
import nebula.dispatch._
import nebula.execute._


//  rough core pipelein
// PC
// Fetch
// align (if rvc)
// decode 
// dispatcher
// rf read
// E1
// E2
// E3
// Writeback







class nebulaRVIO() extends Component  {
  
  val d0 = CtrlLink()
  val dis0 = CtrlLink()
  val rfread0 = CtrlLink()
  val E1 = CtrlLink()
  val E2 = CtrlLink()
  val E3 = CtrlLink()
  val wbStage = CtrlLink()
  
  val stages = Array.fill(8){CtrlLink()}
  
  val hazards = Seq(stages(3), stages(4),stages(5),stages(6),stages(7))
  // val hazards = stages.

  // val decoder = Decoder(d0)
  val decoder = Decoder(stages(0))
  val dispatch = Dispatch(dispatchNode = stages(1), rfReadNode = stages(2),hazardRange = hazards)
  val intregFile = IntRegFile(stages(2), readSync = true, dataWidth = 64)
  val intalu = IntAlu(E1)



  val wb = Writeback(wbStage)






}

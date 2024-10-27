package nebula


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


import nebula.decode._
import nebula.dispatch._


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
  
  val hazards = Seq(rfread0, E1, E2 ,E3)
  val decoder = Decoder(d0)
  val dispatch = Dispatch(dis0, hazards)
  val intregFile = IntRegFile(rfread0)
  val intalu = IntAlu(E1)



  val wb = WritebackPlugin(wbStage)






}

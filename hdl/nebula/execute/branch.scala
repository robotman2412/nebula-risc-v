package nebula.execute


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


case class AGU() extends ExecutionUnit with Area {


}

case class branchPlugin(stage : CtrlLink) extends ExecutionUnit with Area {

  


  val shouldBranch = Bool()
  val isPredictCorrect = Bool()



}

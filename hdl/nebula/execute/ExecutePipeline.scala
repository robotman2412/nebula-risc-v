package nebula.execute


import spinal.core._
import spinal.lib.misc.pipeline._


case class ExecutePipeline(aluNode : CtrlLink) extends Area {
  
  val intalu = IntAlu(aluNode)
  val jal = Jal(aluNode)
  
}
package nebula.execute


import spinal.core._
import spinal.lib.misc.pipeline._
import scala.collection.mutable.ArrayBuffer


case class ExecutePipeline(node : CtrlLink) extends ExecutionUnit with Area {
  
  override val FUs = ArrayBuffer[FunctionalUnit]()
  add(IntAlu(node))
  add(Branch(node))
  add(AGU(node))
  
  
}
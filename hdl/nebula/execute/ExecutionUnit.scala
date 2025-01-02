package  nebula.execute

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import scala.collection.mutable.ArrayBuffer
import nebula.decode.ExecutionUnitEnum
import nebula.decode.AluOp


// object ExecutionUnit{
  // class Api(layer: LaneLayer, val srcPlugin: SrcPlugin, val SEL : Payload[Bool], val rsUnsignedPlugin: RsUnsignedPlugin = null) {
  //   var iwbpp = Option.empty[(IntFormatPlugin, Flow[Bits])]

  //   def setWriteback(ifp : IntFormatPlugin, bus : Flow[Bits]): Unit = {
  //     iwbpp = Some(ifp -> bus)
  //   }
  //   def newWriteback(ifp : IntFormatPlugin, at: Int) : Flow[Bits] = {
  //     val bus = ifp.access(at)
  //     setWriteback(ifp, bus)
  //     bus
  //   }

  //   val uoplist = ArrayBuffer[MicroOp]()
  //   def add(microOp : MicroOp) = new {
  //     val uop = microOp
  //     uopList += uop
  //     val impl = layer.add(uop)
  //     val spec = layer(uop)

  //     decode(SEL -> True)

  //     iwbpp.foreach(v => v._1.addMicroOp(v._2, impl))

  //     def decode(decoding: DecodeListType = Nil): this.type = {
  //       impl.addDecoding(decoding)
  //       this
  //     }

  //     def decode(head: (Payload[_ <: BaseType], Any), tail: (Payload[_ <: BaseType], Any)*): this.type = {
  //       impl.addDecoding(head +: tail)
  //       this
  //     }

  //     def srcs(srcKeys: Seq[SrcKeys]): this.type = {
  //       if (srcKeys.nonEmpty) srcPlugin.specify(impl, srcKeys)
  //       this
  //     }

  //     def srcs(head: SrcKeys, tail: SrcKeys*): this.type = {
  //       this.srcs(head +: tail)
  //       this
  //     }

  //     def rsUnsigned(rs1Signed : Boolean, rs2Signed : Boolean, cond : Boolean = true) : this.type = {
  //       if (cond) rsUnsignedPlugin.addUop(impl, rs1Signed, rs2Signed)
  //       else impl.addDecoding(RsUnsignedPlugin.RS1_SIGNED -> Bool(rs1Signed), RsUnsignedPlugin.RS2_SIGNED -> Bool(rs2Signed))
  //       this
  //     }
  //   }
  // }
// }




abstract class FunctionalUnit {
  // import nebula.execute.MicroOp
  val SEL = Payload(Bool())
  
  val FUType : ExecutionUnitEnum.E
  def returnFUType = FUType

  val supportedUOPS = ArrayBuffer[AluOp.E]()
  def add(uop : AluOp.E) = supportedUOPS += uop
  def getUOPs  = supportedUOPS
}


abstract class ExecutionUnit() {
  val SEL = Payload(Bool())
  
  val FUs : ArrayBuffer[FunctionalUnit]

  def getFUs = FUs
  def add(fu : FunctionalUnit) = FUs += fu

  // class Logic extends ExecutionUnit.Api(layer, host.find[SrcPlugin](_.layer == layer), SEL, rsUnsignedPlugin = host.get[RsUnsignedPlugin].getOrElse(null)) with Area  with PostInitCallback {
  //   val el = layer.lane
  //   val srcp = srcPlugin
  //   val ifp = host.find[IntFormatPlugin](_.lane == layer.lane)
  //   val uopRetainer = retains(el.uopLock, srcp.elaborationLock, ifp.elaborationLock)
  //   val euPipelineRetainer = retains(el.pipelineLock)

  //   el.setDecodingDefault(SEL, False)

  //   override def postInitCallback() = {
  //     euPipelineRetainer.release()
  //     this
  //   }
  // }
  

  // writeback Plugin
}


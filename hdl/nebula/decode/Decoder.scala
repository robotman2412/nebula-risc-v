package nebula.decode

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.lib.logic.Masked._
import spinal.lib.logic._
import scala.collection.mutable
import java.util.LinkedHashSet
import java.util.LinkedHashMap


object Riscv extends AreaObject {
  val RVD, RVF = Boolean
}

package object Decode extends AreaObject {
  type DecodeListType = Seq[(Payload[_ <: BaseType], Any)]
  val INSTRUCTION = Payload(Bits(32 bits))
}
// package object decode{
// }

case class AccessKeys(rfa : RfAccess, physWidth : Int, rfMapping : Seq[RegFileAccess]) extends Area {
  // how many bits to access RFAccess def
  val rfIdWidth = log2Up(rfMapping.size)
  // Checks whether given UInt mapping maps to RegFile
  def is(rfs: RegFileAccess, that: UInt) = that === idOf(rfs)
  // gets ID of RegFile
  def idOf(rfs: RegFileAccess) = rfMapping.indexOf(rfs)
  
  val ENABLE = Payload(Bool()) // Enable read for regfile
  val PHYS = Payload(UInt(physWidth bits)) // physical register access.
  val RFID = Payload(UInt(rfIdWidth bits)) // which RegFile
}

class Decoder(thisNode: spinal.lib.misc.pipeline.Node, lane: Int) {
  val node = thisNode
  import Decode._
  val decodingSpecs = mutable.LinkedHashMap[Payload[_ <: BaseType], DecodingSpec[_ <: BaseType]]()
  // def getDecodingSpec(key: Payload[_ <:BaseType]) = decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key))
  def setDecodingDefault(key: Payload[_ <: BaseType], value: BaseType): Unit = {
    decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key)).setDefault(Masked(value))
  }
  //What is this doint
  def DecodeList(e: (Payload[_ <: BaseType], Any)*) = List(e: _*)
  def addMicroOpDecoding(microOp: MicroOp, decoding: DecodeListType) = {
    val op = Masked(microOp.key)
    for ((key, value) <- decoding) {
      decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key)).addNeeds(op, Masked(value))
    }
  }
  def addMicroOpDecoding[T <: BaseType](microOp: MicroOp, key : Payload[T], value: T) : Unit = addMicroOpDecoding(microOp, DecodeList(key -> value))
  
  def addMicroOpDecodingDefault(key: Payload[_ <: BaseType], value: BaseType) = {
    decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key)).setDefault(Masked(value))
  }
  
  val logic = new Area {
    val INSTRUCTION_WIDTH = 32
    // val UOP_ID = Payload(UInt(UOP_ID_WIDTH bits))
    // val UOP_ID_WIDTH = 5

    def microOps : Seq[MicroOp] = ???
    def resources = microOps.flatMap(_.resources).distinctLinked

    // Linked Hash Set of all RFAccess stuff. So RS1, RS2, VS1, RD etc.
    // val rfAccesses = mutable.LinkedHashSet[RfAccess]()
    // resources.foreach{
    //   case r : RfResource => rfAccesses += r.access
    //   case _ =>
    // }
    
    val rfAccesses: mutable.LinkedHashSet[RfAccess] = mutable.LinkedHashSet[RfAccess](RS1, RS2, RS3, RD)

    val rfaKeys = mutable.LinkedHashMap[RfAccess, AccessKeys]()
    rfaKeys(RS1) = AccessKeys(RS1, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
    rfaKeys(RS2) = AccessKeys(RS2, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
    rfaKeys(RS3) = AccessKeys(RS3, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
    rfaKeys(RD)  = AccessKeys(RD , 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))

    val singleDecodings = mutable.LinkedHashSet[SingleDecoding]()
    microOps.foreach {
      case sd: SingleDecoding => singleDecodings += sd
    }

    val NEED_FPU = Payload(Bool())
    val NEED_RM  = Payload(Bool())
    val NEED_VPU = Payload(Bool())

    decodingSpecs.getOrElseUpdate(NEED_FPU, new DecodingSpec(NEED_FPU)).setDefault(Masked(False)) 
    decodingSpecs.getOrElseUpdate(NEED_VPU, new DecodingSpec(NEED_VPU)).setDefault(Masked(False)) 
    decodingSpecs.getOrElseUpdate(NEED_RM , new DecodingSpec(NEED_RM )).setDefault(Masked(False)) 



    val encodings = new Area {
      val all = mutable.LinkedHashSet[Masked]()
      // Creates a decoding spec that specifies access to which regfile
      class RfAccessDecoding(val rfa : RfAccess){
        val rfaKey = rfaKeys(rfa)
        val read = new DecodingSpec(Bool()).setDefault(zero)
        val rfid = new DecodingSpec(UInt(rfaKey.rfIdWidth bits))
      }
      // val rfAccessDec = rfAccesses.map(rfa => rfa -> new RfAccessDecoding(rfa)).toMapLinked()
      val rfAccessDec: mutable.LinkedHashMap[RfAccess, RfAccessDecoding] = mutable.LinkedHashMap(RS1 -> new RfAccessDecoding(RS1), RS2 -> new RfAccessDecoding(RS2), RS3 -> new RfAccessDecoding(RS3) ,RD -> new RfAccessDecoding(RD))
      for (e <- singleDecodings) {
        val key = Masked(e.key)
        all += key
        
        e.resources.foreach {
          case r: RfResource => {
            val dec = rfAccessDec(r.access)
            dec.read.addNeeds(key, Masked.one)
            dec.rfid.addNeeds(key, Masked(dec.rfaKey.idOf(r.rf), 3))
          }
          case PC_READ => 
          case LQ => 
          case FPU => addMicroOpDecoding(e, NEED_FPU, True)
          case RM => addMicroOpDecoding(e, NEED_RM, True)
          case SQ =>
        }
      } 
      // what in the fuck are these numbers?
      // if(Riscv.RVF || Riscv.RVD){
      //   for (x <- 1 to 3; y <- 1 to 3) getDecodingSpec(NEED_FPU).addNeeds(Masked(0x73 + (x << 20) + (y << 12), 0xFFF0307Fl), Masked.one)
      // }
    }
    // val predictionSpec = new Area {
    //   val branchKeys = List(Rv32i.BEQ).map(e => Masked(e.key))
    //   val jalKeys = List(Rv32i.JAL).map(e => Masked(e.key))
    //   val any = new DecodingSpec(Bool()).setDefault(Masked.zero)

    //   any.addNeeds(branchKeys ++ jalKeys, Masked.one)
    // }
    
    val someLaneLogic = new node.Area {
      for (rfa <- rfAccesses) {
        val keys = rfaKeys(rfa)
        val dec = encodings.rfAccessDec(rfa)
        keys.ENABLE := dec.read.build(Decode.INSTRUCTION, encodings.all)
        keys.RFID   := dec.rfid.build(Decode.INSTRUCTION, encodings.all)
        keys.PHYS   := Decode.INSTRUCTION(rfa match {
          case RS1 => 19 downto 15
          case RS2 => 24 downto 20
          case RS3 => 31 downto 27
          case RD => 11 downto 7
        }).asUInt
      }
      // LEGAL := Symplify(Decode.INSTRUCTION, encodings.all) && !Decode.DECOMPRESSION_FAULT
      // Checks if FP instr is valid??
    //  val fp = Riscv.RVF.get generate new Area {
    //     val csrRm = host[FpuCsrPlugin].api.rm
    //     val instRm = Decode.UOP(Const.funct3Range)
    //     val rm = U((instRm === 7) ? csrRm | instRm)
    //     val enabled = host[PrivilegedPlugin].fpuEnable(0); assert(Global.HART_COUNT.get == 1)
    //     val triggered = NEED_FPU && !enabled || NEED_RM && rm >= 5
    //     when(triggered) {
    //       LEGAL := False
    //     }
    //   } 
    //   

    }


  }
}
package nebula.decode

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.lib.logic.Masked._
import spinal.lib.logic._
import scala.collection.mutable


package object decode{
  type DecodeListType = Seq[(Payload[_ <: BaseType], Any)]
}

case class AccessKeys(rfa : RfAccess, physWidth : Int, rfMapping : Seq[RegFileAccess]) extends Area {
  // how many bits to access RFAccess def
  val rfIdWidth = log2Up(rfMapping.size)
  // Checks whether given UInt mapping maps to RegFile
  def is(rfs: RegFileAccess, that: UInt) = that === idOf(rfs)
  // gets ID of RegFile
  def idOf(rfs: RegFileAccess) = rfMapping.indexOf(rfs)
  

  val ENABLE = Payload(Bool()) // signals enable to given regfile
  val PHYS = Payload(UInt(physWidth bits)) // physical register file access
  val RFID = Payload(UInt(rfIdWidth bits)) // which RegFile
}

class Decoder() {
  import decode._
  val decodingSpecs = mutable.LinkedHashMap[Payload[_ <: BaseType], DecodingSpec[_ <: BaseType]]()
  def getDecodingSpec(key: Payload[_ <:BaseType]) = decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key))
  def setDecodingDefault(key: Payload[_ <: BaseType], value: BaseType): Unit = {
    getDecodingSpec(key).setDefault(Masked(value))
  }
  
  def addMicroOpDecoding(microOp: MicroOp, decoding: DecodeListType) = {
    val op = Masked(microOp.key)
    for ((key, value) <- decoding) {
      getDecodingSpec(key).addNeeds(op, Masked(value))
    }
  }
  
  def addMicroOpDecodingDefault(key: Payload[_ <: BaseType], value: BaseType) = {
    getDecodingSpec(key).setDefault(Masked(value))
  }
  
  def covers(uops: Seq[MicroOp]) = {
    uops.map(e => Masked(e.key))
  }

  val logic = new Area {
    val INSTRUCTION_WIDTH = 32

    def microOps : Seq[MicroOp] = ???
    def resources = microOps.flatMap(_.resources).distinctLinked
    val rfAccesses = mutable.LinkedHashSet[RfAccess]()
    resources.foreach{
      case r : RfResource => rfAccesses += r.access
      case _ =>
    }

    val rfaKeys = mutable.LinkedHashMap[RfAccess, AccessKeys]()
    for (rfa <- rfAccesses) {
      val physWidth = 5
      val rfMapping = resources.collect{case r : RfResource => r.rf}.toList
      val ak = AccessKeys(rfa, physWidth, rfMapping)
      ak.setPartialName(rfa)
      rfaKeys(rfa) = ak
    }

    val singleDecodings = mutable.LinkedHashSet[SingleDecoding]()
    microOps.foreach {
      case sd: SingleDecoding => singleDecodings += sd
    }

    val NEED_FPU = Payload(Bool())
    val NEED_RM = Payload(Bool())
    addMicroOpDecodingDefault(NEED_FPU, False)
    addMicroOpDecodingDefault(NEED_RM, False) 
    val encodings = new Area {
      val all = mutable.LinkedHashSet[Maked]()
    }


  }
}
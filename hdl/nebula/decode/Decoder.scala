package nebula.decode

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import spinal.lib.logic.Masked._
import spinal.lib.logic._
import scala.collection.mutable


object Riscv extends AreaObject {
  val RVD, RVF = Boolean
}

object UOP extends Bundle {
  
}

object Decoder extends Bundle {
  type DecodeListType = Seq[(Payload[_ <: BaseType], Any)]
  val INSTRUCTION = Payload(Bits(32 bits))


  val RS_Sources = new SpinalEnum() {
    val RF, U, I, S, PC, NA = newElement()

  }

  val RS1_SRC = Payload(RS_Sources())
  val RS2_SRC = Payload(RS_Sources())


  val IS_INT   = Payload(Bool()) 
  val NEED_PC  = Payload(Bool())
  val FU_ALU  = Payload(Bool())
  val NEED_FPU = Payload(Bool())
  val NEED_RM  = Payload(Bool())
  val NEED_VPU = Payload(Bool())
  // val IMM_SEL = Payload(IMM())
  val FUNCT3 = Payload(Bits(3 bits))
  val FUNCT7 = Payload(Bits(7 bits))
  val OPCODE = Payload(Bits(7 bits))
  val need_funct3 = Payload(Bool())

  val UOP = Payload(Bits(32 bits))


  val rfaKeys = mutable.LinkedHashMap[RfAccess, AccessKeys]()

}


case class IMM(instruction  : Bits) extends Area{
  // immediates
  def i = instruction(31 downto 20)
  def h = instruction(31 downto 24)
  def s = instruction(31 downto 25) ## instruction(11 downto 7)
  def b = instruction(31) ## instruction(7) ## instruction(30 downto 25) ## instruction(11 downto 8)
  def u = instruction(31 downto 12) ## U"x000"
  def j = instruction(31) ## instruction(19 downto 12) ## instruction(20) ## instruction(30 downto 21)
  def z = instruction(19 downto 15)

  // sign-extend immediates
  def i_sext = S(i).resize(Riscv.XLEN)
  def h_sext = S(h).resize(Riscv.XLEN)
  def s_sext = S(s).resize(Riscv.XLEN)
  def b_sext = S(b ## False).resize(Riscv.XLEN)
  def j_sext = S(j ## False).resize(Riscv.XLEN)
}



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

case class Decoder(decodeNode : CtrlLink, lane: Option[Int] = None) extends Area {
  import Decoder._
  import SrcKeys._
  val decodingSpecs = mutable.LinkedHashMap[Payload[_ <: BaseType], DecodingSpec[_ <: BaseType]]()
  def getDecodingSpec(key: Payload[_ <:BaseType]) = decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key))
  def setDecodingDefault(key: Payload[_ <: BaseType], value: BaseType): Unit = {
    decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key)).setDefault(Masked(value))
  }
  def DecodeList(e: (Payload[_ <: BaseType], Any)*) = List(e: _*)
  def addMicroOpDecoding[T <: BaseType](microOp: MicroOp, key : Payload[T], value : T) = {
    val op = Masked(microOp.key)
    decodingSpecs.getOrElseUpdate(key, new DecodingSpec(key)).addNeeds(op, Masked(value))
  }
  
  def addMicroOpDecodingDefault(key: Payload[_ <: BaseType], value: BaseType) = {
    getDecodingSpec(key).setDefault(Masked(value))
  }


  val logic = new Area {
    def getMicroOps = ???
    // def microOps : Seq[MicroOp] = Seq(Rv32i.ADD, Rv32i.SUB, Rv32i.BEQ ,Rv32i.JAL ,Rv32i.ADDI ,Rv32i.SB ,Rv32i.LB ,Rv32i.AUIPC)
    def microOps : Seq[MicroOp] = Rv32i.UOPs
    def resources = microOps.flatMap(_.resources).distinctLinked


    rfaKeys(RS1) = AccessKeys(RS1, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
    rfaKeys(RS2) = AccessKeys(RS2, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
    rfaKeys(RS3) = AccessKeys(RS3, 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))
    rfaKeys(RD)  = AccessKeys(RD , 5, List(IntRegFileAccess, FloatRegFileAccess, VectorRegFileAccess))

    val singleDecodings = mutable.LinkedHashSet[SingleDecoding]()
    microOps.foreach {
      case sd: SingleDecoding => singleDecodings += sd
    }

    addMicroOpDecodingDefault(IS_INT, False)
    addMicroOpDecodingDefault(NEED_FPU, False)
    addMicroOpDecodingDefault(NEED_RM , False)
    addMicroOpDecodingDefault(NEED_VPU, False)
    addMicroOpDecodingDefault(NEED_PC, False)
    addMicroOpDecodingDefault(need_funct3, False)
    addMicroOpDecodingDefault(FU_ALU, False)
    addMicroOpDecodingDefault(RS1_SRC, NA)
    addMicroOpDecodingDefault(RS2_SRC, NA)


    val encodings = new Area {
      val all = mutable.LinkedHashSet[Masked]()
      // Creates a decoding spec that specifies access to which regfile
      class RfAccessDecoding(val rfa : RfAccess){
        val rfaKey = rfaKeys(rfa)
        val read = new DecodingSpec(Bool()).setDefault(zero)
        val rfid = new DecodingSpec(UInt(rfaKey.rfIdWidth bits))
      }

      val rfAccessDec: mutable.LinkedHashMap[RfAccess, RfAccessDecoding] = {
        mutable.LinkedHashMap(RS1 -> new RfAccessDecoding(RS1), RS2 -> new RfAccessDecoding(RS2), RS3 -> new RfAccessDecoding(RS3) ,RD -> new RfAccessDecoding(RD))
      }
      for (e <- singleDecodings) {
        val key = Masked(e.key)
        all += key
        
        e.resources.foreach {
          case r: RfResource => {
            val dec = rfAccessDec(r.access)
            dec.read.addNeeds(key, Masked.one)

            dec.rfid.addNeeds(key, Masked(dec.rfaKey.idOf(r.rf), 3))
          }
          case PC_READ => addMicroOpDecoding(e, NEED_PC, True)
          case LQ => 
          case FPU => addMicroOpDecoding(e, NEED_FPU, True)
          case RM => addMicroOpDecoding(e, NEED_RM, True)
          case VPU => addMicroOpDecoding(e, NEED_VPU, True)
          case SQ =>
          case INT => addMicroOpDecoding(e, IS_INT, True)
          case ALU => addMicroOpDecoding(e, FU_ALU, True)
          case funct3 => addMicroOpDecoding(e, need_funct3, True)
        }
        e.srckeys.foreach {
          case src1 : SrcKeys.SRC1 => {
            case  SRC1.RF => addMicroOpDecoding(e, RS1_SRC, RF)
            case  SRC1.U => addMicroOpDecoding(e, RS1_SRC, U)

          }
          case src2 : SrcKeys.SRC2 => {
            case  SRC2.RF => addMicroOpDecoding(e, RS1_SRC, RF)
            case  SRC2.I => addMicroOpDecoding(e, RS1_SRC, I)
            case  SRC2.S => addMicroOpDecoding(e, RS1_SRC, S)
            case  SRC2.PC => addMicroOpDecoding(e, RS1_SRC, PC)
          }
        }
      } 
    //   // what in the fuck are these numbers?
    //   // if(Riscv.RVF || Riscv.RVD){
    //   //   for (x <- 1 to 3; y <- 1 to 3) getDecodingSpec(NEED_FPU).addNeeds(Masked(0x73 + (x << 20) + (y << 12), 0xFFF0307Fl), Masked.one)
    //   // }
    }
    // val predictionSpec = new Area {
    //   val branchKeys = List(Rv32i.BEQ).map(e => Masked(e.key))
    //   val jalKeys = List(Rv32i.JAL).map(e => Masked(e.key))
    //   val any = new DecodingSpec(Bool()).setDefault(Masked.zero)

    //   any.addNeeds(branchKeys ++ jalKeys, Masked.one)
    // }
    
    val someLaneLogic = new decodeNode.Area {
      for (rfa <- rfaKeys) {
        val keys = rfa
        val dec = encodings.rfAccessDec(keys._1)
        down(keys._2.ENABLE) := dec.read.build(up(INSTRUCTION), encodings.all)
        down(keys._2.RFID)   := dec.rfid.build(up(INSTRUCTION), encodings.all)
        down(keys._2.PHYS)   := up(INSTRUCTION)(rfa._1 match {
          case RS1 => 19 downto 15
          case RS2 => 24 downto 20
          case RS3 => 31 downto 27
          case RD  => 11 downto 7
        }).asUInt
      }
      down(FUNCT3) := up(INSTRUCTION)(14 downto 12)
      down(FUNCT7) := up(INSTRUCTION)(31 downto 25)
      down(OPCODE) := up(INSTRUCTION)(6  downto 0)
      down(UOP)    :- up(INSTRUCTION)


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
    

    // val predictionUpdated = new node.Area(lane) {

    // }
    
    val laneDecoding =  new decodeNode.Area {
      for ((key, spec) <- decodingSpecs) {
        down(key).assignDontCare()
        when(isValid) {
          down(key).assignFromBits(spec.build(up(INSTRUCTION), encodings.all).asBits)
        }
      }
    }
  }
}


package nebula.decode

import spinal.core._
import spinal.lib._

class Resource
case class RfResource(rf: RegFileAccess, acess: RfAccess) extends Resource
class RfAccess
class RfRead extends RfAccess
class RfWrite extends RfAccess

object RS1 extends RfRead with AreaObject
object RS2 extends RfRead with AreaObject
object RS3 extends RfRead with AreaObject
object RD extends RfWrite with AreaObject
object VS1 extends RfRead with AreaObject
object VS2 extends RfRead with AreaObject
object VS3 extends RfRead with AreaObject
object VD extends RfWrite with AreaObject
object PC_READ extends Resource with AreaObject
// object PC_NEXT extends Resource with AreaObject
// object INSTRUCTION_SIZE    extends Resource with AreaObject
object LQ extends Resource with AreaObject
object SQ extends Resource with AreaObject
object FPU extends Resource with AreaObject
object RM extends Resource with AreaObject // RM = Rounding Mode
object VPU extends Resource with AreaObject
// object LMUL extends Resource with AreaObject

abstract class MicroOp(val resources: Seq[Resource]) {
    def key: MaskedLiteral
}

case class SingleDecoding(
        key: MaskedLiteral,
        override val resources: Seq[Resource]
) extends MicroOp(resources)
case class MultiDecoding(key: MaskedLiteral, uop: Seq[MicroOp])

trait RegFileAccess {
    // def -> (access : RfAccess) = RfResource(this, access)
    //
    def sizeArch: Int
    def width: Int

    val test = Bits(32 bits)
}
object IntRegFileAccess extends RegFileAccess with AreaObject {
    override def sizeArch: Int = 64
    override def width: Int = 64

    // R-type
    def TypeR(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RS1, RS2, RD).map(this -> _)
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(IntRegFileAccess, RS2),
            RfResource(IntRegFileAccess, RD)
        )
    )
    // I-type
    def TypeI(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RS1, RD).map(this -> _)
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(IntRegFileAccess, RD)
        )
    )
    // J-type
    def TypeJ(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RD).map(this -> _)
        resources = List(
            RfResource(IntRegFileAccess, RD)
        )
    )
    // B-type
    def TypeB(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RS1, RS2).map(this -> _) :+ PC_READ
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(IntRegFileAccess, RS2),
            PC_READ
        )
    )
    def TypeU(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RD).map(this -> _)
        // resources = List(RfResource(RD))
        resources = List(
            RfResource(IntRegFileAccess, RD)
        )
    )
    def TypeUPC(key: MaskedLiteral) = SingleDecoding(
        key = key,
        // resources = List(RD).map(this -> _) :+ PC_READ
        resources = List(
            RfResource(IntRegFileAccess, RD),
            PC_READ
        )
    )
    //Integer Load Queue?
    def TypeILQ(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(RS1, RD).map(this -> _) :+ LQ :+ PC_READ //PC_READ is used to reschedule a load which had some store hazard
    )
    // Int store Queue
    def TypeSSQ(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(RS1, RS2).map(this -> _) :+ SQ
    )
    // Atomic store queue
    def TypeASQ(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(RS1, RS2, RD).map(this -> _) :+ SQ
    )
    // Status registers
    def TypeIC(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(RD).map(this -> _)
    )
    def TypeNone(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = Nil
    )
}

object FloatRegFileAccess extends RegFileAccess with AreaObject {

    override def sizeArch: Int = 64
    override def width: Int = 64

    def TypeR(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RS2),
            RfResource(FloatRegFileAccess, RD),
            FPU
        )
    )
    def TypeR_RM(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RS2),
            RfResource(FloatRegFileAccess, RD),
            FPU,
            RM
        )
    )
    def TypeR4(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RS2),
            RfResource(FloatRegFileAccess, RS3),
            RfResource(FloatRegFileAccess, RD),
            FPU,
            RM
        )
    )
    def TypeR1_RM(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RD),
            FPU,
            RM
        )
    )
    def TypeR1(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RD),
            FPU,
        )
    )

    def TypeILQ(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RD),
            LQ,
            PC_READ
        )
    )
    def TypeSSQ(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RS2),
            SQ,
            FPU
        )
    )

    def TypeF2I(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(IntRegFileAccess, RD),
            FPU
        )
    )
    def TypeF2I_RM(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(IntRegFileAccess, RD),
            FPU,
            RM
        )
    )
    def TypeI2F(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RD),
            FPU
        )
    )
    def TypeI2F_RM(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(IntRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RD),
            FPU,
            RM
        )
    )
    def TypeFCI(key : MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(FloatRegFileAccess, RS1),
            RfResource(FloatRegFileAccess, RS2),
            RfResource(IntRegFileAccess, RD),
            FPU
        )
    )
 }


object VectorRegFileAccess extends RegFileAccess with AreaObject {
    override def sizeArch: Int = 64
    override def width: Int = ???

    def TypeVL(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RS1)
        )
    )
    def TypeVLS(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RS1),
            RfResource (FloatRegFileAccess, RS2)
        )
    )
    def TypeVLX(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RS1),
            RfResource (FloatRegFileAccess, VS2)
        )
    )
    def TypeVS(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VS3),
            RfResource(FloatRegFileAccess, RS1)
        )
    )
    def TypeVSS(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VS3),
            RfResource(FloatRegFileAccess, RS1),
            RfResource (FloatRegFileAccess, RS2)
        )
    )
    def TypeVSX(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VS3),
            RfResource(FloatRegFileAccess, RS1),
            RfResource (VectorRegFileAccess, VS2)
        )
    )

    def TypeOPIVV(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(VectorRegFileAccess, VS1),
            RfResource (VectorRegFileAccess, VS2)
        )
    )
    def TypeOPFVV(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RD),
            RfResource(VectorRegFileAccess, VS1),
            RfResource (VectorRegFileAccess, VS2)
        )
    )
    def TypeOPMVV(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RD),
            RfResource(VectorRegFileAccess, VS1),
            RfResource (VectorRegFileAccess, VS2)
        )
    )
    def TypeOPIVI(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(VectorRegFileAccess, VS2)
        )
    )
    def TypeOPIVX(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RS1),
                RfResource (VectorRegFileAccess, VS2)
        )
    )
    def TypeOPFVF(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RS1),
            RfResource (VectorRegFileAccess, VS2)
        )
    )
    def TypeOPMVX(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource(VectorRegFileAccess, VD),
            RfResource(FloatRegFileAccess, RD),
            RfResource(FloatRegFileAccess, RS1),
            RfResource (VectorRegFileAccess, VS2)
        )
    )

    def TypeVSETVLI(key: MaskedLiteral) = SingleDecoding(
        key = key,
        resources = List(
            RfResource()
        )
    )

}

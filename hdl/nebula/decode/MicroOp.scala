package nebula.decode

import spinal.core._
import spinal.lib._

class Resource
case class RfResource(rf: RegFileAccess, access: RfAccess) extends Resource
case class AluOp(fu : Resource, op: Resource) extends Resource
class RfAccess 
class RfRead extends RfAccess
class RfWrite extends RfAccess



object RS1 extends RfRead with AreaObject
object RS2 extends RfRead with AreaObject
object RS3 extends RfRead with AreaObject
object RD extends RfWrite with AreaObject
// object PC_NEXT extends Resource with AreaObject
// object RM extends Resource with AreaObject 
// object VPU extends Resource with AreaObject
// object IMM extends Resource with AreaObject
object funct3 extends Resource with AreaObject
object funct7 extends Resource with AreaObject

class ExecutionUnit extends Resource
object FPU extends ExecutionUnit 
object INTALU extends ExecutionUnit 
object LQ extends ExecutionUnit 
object SQ extends ExecutionUnit 
object BRANCHUNIT extends ExecutionUnit

class SrcKeys
class Src1Keys extends SrcKeys
class Src1Values extends Src1Keys
class Src2Values extends Src2Keys
class Src2Keys extends SrcKeys
object SRC1 extends Src1Keys {
    object RF extends Src1Values
    object U extends Src1Values
}
object SRC2 extends Src2Keys {
    object RF extends Src2Values
    object I extends Src2Values
    object S extends Src2Values
    object PC extends Src2Values
}


// object LMUL extends Resource with AreaObject



abstract class MicroOp(val resources: Seq[Resource]) {
    def key: MaskedLiteral
}

case class SingleDecoding(
        key: MaskedLiteral,
        override val resources: Seq[Resource],
        srckeys : Seq[SrcKeys],
        eu : ExecutionUnit,
) extends MicroOp(resources)
// case class MultiDecoding(key: MaskedLiteral, uop: Seq[MicroOp])

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
            RfResource(IntRegFileAccess, RD),
            funct3,
        ),
      srckeys = List(
        SRC1.RF,
        SRC2.RF
        ),
        eu = INTALU
    )
    // I-type
    // def TypeI(key: MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RS1, RD).map(this -> _)
    //     resources = List(
    //         RfResource(IntRegFileAccess, RS1),
    //         RfResource(IntRegFileAccess, RD),
    //         funct3
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )
    // )

    // // J-type
    // def TypeJ(key: MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RD).map(this -> _)
    //     resources = List(
    //         RfResource(IntRegFileAccess, RD)
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // // B-type
    // def TypeB(key: MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RS1, RS2).map(this -> _) :+ PC_READ
    //     resources = List(
    //         RfResource(IntRegFileAccess, RS1),
    //         RfResource(IntRegFileAccess, RS2),
    //         PC_READ,
    //         funct3
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // def TypeU(key: MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RD).map(this -> _)
    //     // resources = List(RfResource(RD))
    //     resources = List(
    //         RfResource(IntRegFileAccess, RD)
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // def TypeUPC(key: MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RD).map(this -> _) :+ PC_READ
    //     resources = List(
    //         RfResource(IntRegFileAccess, RD),
    //         PC_READ
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // //Integer Load Queue?
    // def TypeILQ(key : MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RS1, RD).map(this -> _) :+ LQ :+ PC_READ //PC_READ is used to reschedule a load which had some store hazard
    //     resources = List(
    //         RfResource(IntRegFileAccess, RS1),
    //         RfResource(IntRegFileAccess, RD),
    //         LQ,
    //         PC_READ,
    //         funct3
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // // Int store Queue
    // def TypeSSQ(key : MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RS1, RS2).map(this -> _) :+ SQ
    //     resources = List(
    //         RfResource(IntRegFileAccess, RS1),
    //         RfResource(IntRegFileAccess, RS2),
    //         SQ,
    //         funct3
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // // Atomic store queue
    // def TypeASQ(key : MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RS1, RS2, RD).map(this -> _) :+ SQ
    //     resources = List(
    //         RfResource(IntRegFileAccess, RS1),
    //         RfResource(IntRegFileAccess, RS2),
    //         RfResource(IntRegFileAccess, RD),
    //         SQ,
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // // Status registers
    // def TypeIC(key : MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     // resources = List(RD).map(this -> _)
    //     resources = List(
    //         RfResource(IntRegFileAccess, RD),
    //     ),
    //   srckeys = List(
    //     SRC1.RF,
    //     SRC2.RF
    //     )

    // )
    // def TypeNone(key : MaskedLiteral) = SingleDecoding(
    //     key = key,
    //     resources = Nil
    // )
}

object FloatRegFileAccess extends RegFileAccess with AreaObject {

//     override def sizeArch: Int = 64
//     override def width: Int = 64

//     def TypeR(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RS2),
//             RfResource(FloatRegFileAccess, RD),
//             FPU
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeR_RM(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RS2),
//             RfResource(FloatRegFileAccess, RD),
//             FPU,
//             RM
//         )
//     )
//     def TypeR4(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RS2),
//             RfResource(FloatRegFileAccess, RS3),
//             RfResource(FloatRegFileAccess, RD),
//             FPU,
//             RM
//         )
//     )
//     def TypeR1_RM(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RD),
//             FPU,
//             RM
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeR1(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RD),
//             FPU,
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )

//     def TypeILQ(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(IntRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RD),
//             LQ,
//             PC_READ
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeSSQ(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(IntRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RS2),
//             SQ,
//             FPU
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )

//     def TypeF2I(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(IntRegFileAccess, RD),
//             FPU
//         )
//     )
//     def TypeF2I_RM(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(IntRegFileAccess, RD),
//             FPU,
//             RM
//         )
//     )
//     def TypeI2F(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(IntRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RD),
//             FPU
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeI2F_RM(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(IntRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RD),
//             FPU,
//             RM
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeFCI(key : MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource(FloatRegFileAccess, RS2),
//             RfResource(IntRegFileAccess, RD),
//             FPU
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
 }


object VectorRegFileAccess extends RegFileAccess with AreaObject {
//     override def sizeArch: Int = 64
//     override def width: Int = ???

//     def TypeVL(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RS1)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeVLS(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource (FloatRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )


//     )
//     def TypeVLX(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource (FloatRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeVS(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RS3),
//             RfResource(FloatRegFileAccess, RS1)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeVSS(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RS3),
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource (FloatRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeVSX(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RS3),
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource (VectorRegFileAccess, RS2)
//         )
//     )

//     def TypeOPIVV(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(VectorRegFileAccess, RS1),
//             RfResource (VectorRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeOPFVV(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RD),
//             RfResource(VectorRegFileAccess, RS1),
//             RfResource (VectorRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeOPMVV(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RD),
//             RfResource(VectorRegFileAccess, RS1),
//             RfResource (VectorRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeOPIVI(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(VectorRegFileAccess, RS2)
//         ),
//       srckeys = List(
//         SRC1.RF,
//         SRC2.RF
//         )

//     )
//     def TypeOPIVX(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RS1),
//                 RfResource (VectorRegFileAccess, RS2)
//         )
//     )
//     def TypeOPFVF(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource (VectorRegFileAccess, RS2)
//         )
//     )
//     def TypeOPMVX(key: MaskedLiteral) = SingleDecoding(
//         key = key,
//         resources = List(
//             RfResource(VectorRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RD),
//             RfResource(FloatRegFileAccess, RS1),
//             RfResource (VectorRegFileAccess, RS2)
//         )
//     )

//     // def TypeVSETVLI(key: MaskedLiteral) = SingleDecoding(
//     //     key = key,
//     //     resources = List(
//     //         RfResource()
//     //     )
//     // )

}

package nebula.dispatch


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._




case class SrcPlugin() extends Area {
  // if RF then RF should read
  // also maybe choose forwarded value


  // Maybe with EXU, tell SRC which OPS want which IMM. also acts as SEXT plugin
  // JUST TELL EXU UNIT WHETHER TO USEj


  val RS1 = Payload(Bits (32 bits))
  val RS2 = Payload(Bits (32 bits))

  val imm = new IMM(Decode.UOP)

  match(RS1_SRC) {
    case(RF) {
      RS1 := RegFile_RS1
    }
    case (U) {
      ???
    }
  }
  match(RS2_SRC) {
    case(RF) {RS1 := RegFile_RS1}
    case(I) { RS1 := imm.i_sext}
    case(S) {}
    case(PC) {}
  }

    val src = new eu.Execute(executeAt-relaxedRs.toInt){
      def get(rs : RfRead) = relaxedRs match {
        case false => up(eu(IntRegFile, rs))
        case true  => down(eu(IntRegFile, rs))
      }
      val imm = new IMM(Decode.UOP)
      if(src1Keys.nonEmpty) SRC1 := SRC1_CTRL.muxListDc[SInt](src1Keys.map {
        case sk.SRC1.RF => src1ToEnum(sk.SRC1.RF) -> S(get(RS1))
        case sk.SRC1.U  => src1ToEnum(sk.SRC1.U ) -> S(imm.u).resize(Riscv.XLEN)
      })

      val pcExtended = PHYSICAL_WIDTH.get < VIRTUAL_WIDTH.get
      if(src2Keys.nonEmpty) SRC2 := SRC2_CTRL.muxListDc[SInt](src2Keys.map {
        case sk.SRC2.RF => src2ToEnum(sk.SRC2.RF) -> S(get(RS2))
        case sk.SRC2.I  => src2ToEnum(sk.SRC2.I ) -> imm.i_sext
        case sk.SRC2.S  => src2ToEnum(sk.SRC2.S ) -> imm.s_sext
        case sk.SRC2.PC => src2ToEnum(sk.SRC2.PC) -> pcExtended.mux(S(this(Global.PC)).resize(Riscv.XLEN), S(this(Global.PC).resize(Riscv.XLEN)))
      })


}

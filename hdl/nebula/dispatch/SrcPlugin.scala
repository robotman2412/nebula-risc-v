package nebula.dispatch


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._




case class SrcPlugin() extends Area {
  // if RF then RF should read
  // also maybe choose forwarded value


  // Maybe with EXU, tell SRC which OPS want which IMM. also acts as SEXT plugin


  val RS1 = Payload(Bits (32 bits))
  val RS2 = Payload(Bits (32 bits))

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
    case(I) {}
    case(S) {}
    case(PC) {}
  }



}

package nebula.cpu.execute

import spinal.core._
import spinal.lib._

object IntDiv extends AreaObject {
  val Ctrl = new SpinalEnum() {
    val DIV, DIVU, REM, REMU, DIVW, DIVUW, REMW, REMUW = newElement
  }
}

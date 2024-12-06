package nebula.execute

import spinal.core._




case class AGU() extends Area {
  val memLocation = RS1 + IMMED
  val RESULT = loadedResult
  val storeData = RS2
}

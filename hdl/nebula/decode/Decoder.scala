package nebula.decode

import spinal.core._
import spinal.lib._


object Decoder extends Area {
  
}

class Decoder() extends Area {
  
  def getUops : Iterable[MicroOp]
  def covers() = {
  }
}

package nebula.schedule

import spinal.core._
import spinal.lib._


class reserveLine() extends Bundle {

  val Op = ???
  val RS1Source, RS2Source, RS3Source = ???
  val RS1Val, RS2Val, RS3Val = ???
  val address = ???
  val busy = ???

}

class reservationStation() extends Area {


}

class robLine() extends Bundle {

  val pc = Bits(40 bits)
  val valid, busy, execution = Bool()
  val uop = ???
  val brmask = ???
  val renameState = ???
  

}


class ROB() extends Area {
  val instruction = ???
  val registerDestination = ???
  val value = ???


}


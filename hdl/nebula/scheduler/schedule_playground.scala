package nebula.scheduler


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._




class RAT(regfilesize : Int) extends Area {

  val ratsize = log2Up(regfilesize)
  val freeList = ???
  val RAT = Vec.fill(32)(UInt(ratsize bits))

}







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
  val valid, busy, exception = Bool()
  val uop = ???
  val brmask = ???
  val renameState = ???
  

}


class ROB() extends Area {
  val bankCount: Int = 2
  val instruction = ???
  val registerDestination = ???
  val value = ???


  val banks = for (banks <- 0 until bankCount) yield new Area {

  }

}

package nebula.scheduler


import spinal.core._
import spinal.lib._


case class regFileLine() extends Bundle {
  // which reservation station contains the needed data
  val dataSource = ???
  val data = Bits(64 bits)
}

class RegFile(issueWidth: Int) extends Area {

  val bankCount = issueWidth

  val banks = for (bank <- 0 until bankCount) yield new Area {

    val mem = Mem.fill(32)(regFileLine())
//    val write = mem.write()
//    readSync or Async
//    val read = mem.readSync


  }




}

package nebula.cache


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._


class RamFetchCmd() extends Bundle {
}
class RamFetchRsp() extends Bundle {
}
class L1FetchCmd() extends Bundle {
}
class L1FetchRsp() extends Bundle {
}




case class ICache(node : Node) extends Area {




  val ways = ???
  val bankCount = ???
  val waySize = ???
  val cacheSize = ???
  val bankSize = ???
  val nWays = ???


  val tagWidth = ???
  class Tag() extends Bundle {
    val valid = Bool()
    val error = Bool()
    val address = Bits(tagWidth bits)
  }

  val banks = for (id <- 0 until bankCount) yield new Area {
    val mem = ???

  }

  val read = new Area {


  }
  val refill = new Area {

  }
  val invalidate = new Area {

  }
  val writeback = new Area {

  }
  val plru = new Area {


  }



}


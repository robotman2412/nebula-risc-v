package nebula.test


import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode._

import spinal.core.sim._


class decoderTest() extends Component {


  val decode_node = Node()
  val test_signals_node = Node()
  val decoder = Decoder(decode_node, 0)
  
  val testNode = Node()

  val links = CtrlLink(decode_node, test_signals_node)
  
  Builder(links)

  
}

object decoderVerilog {
  def main(args: Array[String]) {
    SpinalVerilog(new decoderTest)
  }
}



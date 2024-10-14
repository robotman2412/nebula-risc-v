package nebula.test

import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.decode._

import spinal.core.sim._
import nebula.decode.Decoder.INSTRUCTION
import nebula.decode.Decoder.IS_INT


class decoderForTest() extends Component {
  val io = new Bundle {
    val instr = in port Bits(32 bits)
  }
  val test_signals_node, decode_node, recieve_signals  = CtrlLink()

  val decoder = Decoder(decode_node, 0)
  
  val testNode = new test_signals_node.Area {
    down(INSTRUCTION) := io.instr
  }
  
  val recieve = new recieve_signals.Area {
    val io = new Bundle {
      val is_int = out port Bool()
    }
    io.is_int:= False

    when(up.isFiring){
      io.is_int := IS_INT
    }
    // up(IS_INT) := False
    // println(IS_INT)
  }

  val n12 = StageLink(test_signals_node.down, decode_node.up)
  val n23 = StageLink(decode_node.down, recieve_signals.up)

  
  Builder(test_signals_node, decode_node,recieve_signals, n12, n23)
}

object decoder_test extends App {
  SimConfig.withWave.compile(new decoderForTest).doSim{ dut =>
    dut.clockDomain.forkStimulus(10)
    dut.io.instr #= BigInt("00000000000000000000000000110011", 2)
   
    sleep(1)
    dut.clockDomain.waitSampling(20)
    
    // val int = dut.test_signals_node(down(IS_INT))
    // print(int)
    println(dut.recieve.io.is_int.toBoolean)

  }
}

object decoderVerilog {
  def main(args: Array[String]) {
    SpinalVerilog(new decoderForTest)
  }
}

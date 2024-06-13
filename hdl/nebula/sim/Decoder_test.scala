package nebula.sim

import nebula._
import nebula.decode._
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import spinal.lib.sim._


case class TestDecoder() extends Component {
  val decoder = new Decoder()

}

object DecodeSim extends App {
  Config.sim.withWave.compile(TestDecoder()).doSim { dut =>

    dut.clockDomain.forkStimulus(period = 10)
    
  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #= BigInt("11111111111111111111111111111111",2)
  println(dut.decoder.io.result.toInt)    

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #= BigInt("01000000000000000000000000110011",2)
  // sleep(10)
  println(dut.decoder.io.result.toInt)    

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #=BigInt("00000000000000000100000000110011",2)
  println(dut.decoder.io.result.toInt)  

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #=BigInt("00000000000000000001000000110011",2)
  println(dut.decoder.io.result.toInt)  

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #=BigInt("00000000000000000010000000110011",2)
  println(dut.decoder.io.result.toInt) 

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #=BigInt("00000000000000000011000000110011",2)
  println(dut.decoder.io.result.toInt)  

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #=BigInt("00000000000000000100000000110011",2)
  println(dut.decoder.io.result.toInt)  

  dut.clockDomain.waitSampling()
  dut.decoder.io.instr #=BigInt("00000000000000000000000000010011",2)
  println(dut.decoder.io.result.toInt)    





  }
}


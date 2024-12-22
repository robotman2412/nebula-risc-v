package test

import spinal.core._
import spinal.core.sim._

import spinal.lib.sim._
import spinal.lib._
import spinal.lib.misc.pipeline._
import nebula.LsuL1
import nebula.decode.Decoder


case class frontendPipeline() extends Component {
  val pcNode, icacheNode, decodeNode = CtrlLink()
  // mainMemory
  
  val pc = LsuL1.PC(pcNode)
  val icache = LsuL1.ICache(icacheNode)
  val decoder = Decoder(decodeNode)
  pcNode.haltWhen(icache.haltPc)
  
  val pc2i$ = StageLink(pcNode.down, icacheNode.up)
  val i$2dec = StageLink(icacheNode.down, decodeNode.up)

  val mainMemory = new MainMemory(8192)
  
  // icache.ramBus <> mainMemory.bus
  icache.ramBus.ramFetchCmd >> mainMemory.bus.ramFetchCmd
  icache.ramBus.ramFetchRsp << mainMemory.bus.ramFetchRsp
  
  
  Builder(pcNode, icacheNode, decodeNode, pc2i$, i$2dec)
}

object frontendVerilog {
  def main(args: Array[String]) {
    SpinalVerilog(new frontendPipeline())
  }
}

import java.nio.file.Files
import java.nio.file.Paths

object ICacheSim {
  def main(args: Array[String])= {
    SimConfig.withWave.compile(new frontendPipeline).doSim { dut =>
      dut.clockDomain.forkStimulus(10)

      // load instructions into mainmemory
      // 
      // 

      val binary = Files.readAllBytes(Paths.get("/home/mahir/fun/CPU/nebula-risc-v/hdl/test/rv64bins/rv64ui-p-add.bin"))
      for (i <- binary.indices by 8) {
        val word = BigInt(1, binary.slice(i, i + 8).reverse)
        val addr = i / 8
        // println(word.toString(16))
        val hexString = word.toString(16) // Convert BigInt to a hexadecimal string
        val paddedHexString = hexString.reverse.padTo((hexString.length + 7) / 8 * 8, '0').reverse // Pad to a multiple of 8 hex characters (32 bits)
        // println(addr)
        // println(paddedHexString)
        dut.mainMemory.memory.setBigInt(addr, BigInt(paddedHexString, 16))
      }
      // Run simulation
      dut.clockDomain.waitSampling()
      // println(dut.pc.pclogic.pcReg.toBigInt)
      dut.clockDomain.waitSampling(1000)
      
      // println(dut.pc.pclogic.pcReg.toBigInt)
      // import nebula.LsuL1.PC._
      // println(dut.pc.pclogic(PCPLUS4).toBigInt)
      // println(dut.pc.pclogic(PCVal).toBigInt)
      
      // println(dut.mainMemory.memory.getBigInt(0).toString(16))
      // println(dut.mainMemory.memory.getBigInt(1).toString(16))
      // println(dut.mainMemory.memory.getBigInt(2).toString(16))
      // println(dut.mainMemory.memory.getBigInt(3).toString(16))
      // println(dut.mainMemory.memory.getBigInt(4).toString(16))

      // println(dut.mainMemory.resizedAddress.toInt)
      // for(i <- 0 until 100) {
      //   println(dut.icache.mem.getBigInt(i).toString(16))
      // }
      

      
    }
  }
}


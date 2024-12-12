package nebula.test

import spinal.core._
import spinal.lib._



class MainMemory(memSize: Int, wordWidth: Int) extends Component {
  val io = new Bundle {
    val cmd = slave Stream (new Bundle {
      val address = UInt(64 bits)
    })
    val rsp = master Stream (new Bundle {
      val data = Bits(32 bits)
    })
  }

  val memory = Mem(Bits(wordWidth bits), memSize / (wordWidth / 8)) init (
    (0 until memSize / (wordWidth / 8)).map(i => B(i, wordWidth bits))
  )

  // Handling memory read requests
  io.cmd.ready := io.rsp.ready
  io.rsp.valid := io.cmd.valid
  
  val resizedAddress = io.cmd.payload.address(log2Up(memSize / (wordWidth / 8)) - 1 downto 0)
  io.rsp.payload.data := memory.readAsync(resizedAddress)
}

class ICacheTestbench extends Component {
  val cache = new nebula.LsuL1.ICache() // Assuming 'node' is optional
  val mainMemory = new MainMemory(1024, 32) // 1 KB memory, 32-bit words

  // Connect main memory to cache's RAM bus
  // mainMemory.io.cmd <> cache.ramBus.cmd
  mainMemory.io.cmd.payload.address := cache.ramBus.cmd.payload.address
  mainMemory.io.cmd.valid := cache.ramBus.cmd.valid

  cache.ramBus.rsp.payload.data := mainMemory.io.rsp.payload.data
  cache.ramBus.rsp.valid := mainMemory.io.rsp.valid
  // cache.ramBus.rsp.payload.address := mainMemory.io.rsp.payload.address

  // Generate test stimulus
  val addressGen = Stream(UInt(64 bits))
  addressGen.valid := True
  addressGen.payload := RegNextWhen(addressGen.payload + 4, addressGen.fire) init 0x1000

  // Connect test stimulus to cache
  cache.l1bus.cmd := addressGen.translateWith {
    val cmd = cache.l1bus.cmd.payloadType()
    cmd.address := addressGen.payload
    cmd
  }.toFlow

  import spinal.core.sim._
  // Capture responses
  val hitCount = Reg(UInt(32 bits)) init 0 simPublic()
  val missCount = Reg(UInt(32 bits)) init 0 simPublic()


  when(cache.l1bus.rsp.valid) {
    when(cache.l1bus.rsp.payload.data === mainMemory.io.rsp.payload.data) {
      hitCount := (hitCount + 1) 
    }.otherwise {
      missCount := (missCount + 1)
    }
  }
}
import spinal.core._
import spinal.core.sim._
import nebula.LsuL1.ICache

object ICacheSim {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave.compile(new ICacheTestbench).doSim { dut =>
      dut.clockDomain.forkStimulus(10)

      // Run simulation
      for (i <- 0 until 100) {
        dut.clockDomain.waitSampling()
      }

      // Print hit/miss statistics
      println(s"Cache Hits: ${dut.hitCount.toBigInt}")
      println(s"Cache Misses: ${dut.missCount.toBigInt}")
    }
  }
}


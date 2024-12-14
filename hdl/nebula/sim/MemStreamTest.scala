package nebula.sim

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula._
import spinal.core._
import spinal.core.sim._
import spinal.lib._
import nebula.cpu.mem._
import nebula.cpu._
import nebula.cpu.fetch._
import spinal.lib.bus.amba3.ahblite._
import nebula.util._

case class MemStreamBench(cfg: NebulaCfg, width: Int) extends Component {
    val io = new Bundle {
        val jump = in     port Bool()
        val addr = in     port SInt(cfg.vaddrWidth bits)
        val dout = master port Stream(MemStreamPacket(cfg, width))
    }
    val reader = MemStreamReader(cfg, width, 0, true)
    val mem    = new AlignedAhb3Rom(
        AhbLite3Config(cfg.vaddrWidth, cfg.memWidth),
        "Hello, World".getBytes()
    )
    reader.io.mem.toAhbLite3 <> mem.io.ahb
    reader.io.jump           := io.jump
    reader.io.addr           := io.addr
    reader.io.dout           <> io.dout
}

object MemStreamTest extends App {
    Config.sim.compile(MemStreamBench(NebulaCfg(), 8)).doSim(this.getClass.getSimpleName) { dut =>
        // Fork a process to generate the reset and the clock on the dut
        dut.clockDomain.forkStimulus(period = 10)
        dut.io.dout.ready #= true
        
        // Let it run for a little while.
        dut.clockDomain.waitSampling(5)
        
        // Jump.
        dut.io.jump #= true
        dut.io.addr #= 2
        dut.clockDomain.waitSampling(1)
        dut.io.jump #= false
        
        // Run it linearly again.
        dut.clockDomain.waitSampling(10)
        
        // Jump erratically.
        dut.io.jump #= true
        dut.io.addr #= 7
        dut.clockDomain.waitSampling(1)
        dut.io.jump #= false
        dut.clockDomain.waitSampling(2)
        
        dut.io.jump #= true
        dut.io.addr #= 3
        dut.clockDomain.waitSampling(1)
        dut.io.jump #= false
        dut.clockDomain.waitSampling(1)
        
        dut.io.jump #= true
        dut.io.addr #= 7
        dut.clockDomain.waitSampling(1)
        dut.io.jump #= false
        
        // Run it 'till the end.
        dut.clockDomain.waitSampling(20)
    }
}
package nebula.sim

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula._
import spinal.core._
import spinal.core.sim._
import spinal.lib._

/** Dummy testbench that's just a wire from `din_a` to `dout_a`. */
case class TestBench() extends Component {
    val io = new Bundle {
        val din_a   = in  port Bool()
        val dout_a  = out port Bool()
    }
    io.dout_a := io.din_a
}

object Test extends App {
    Config.sim.compile(TestBench()).doSim(this.getClass.getSimpleName) { dut =>
        // Fork a process to generate the reset and the clock on the dut
        dut.clockDomain.forkStimulus(period = 10)

        // Send some simple stimulus.
        dut.io.din_a #= false
        dut.clockDomain.waitSampling()
        dut.io.din_a #= true
        dut.clockDomain.waitSampling()
        dut.io.din_a #= false
        dut.clockDomain.waitSampling()
        dut.io.din_a #= true
        dut.clockDomain.waitSampling()
    }
}
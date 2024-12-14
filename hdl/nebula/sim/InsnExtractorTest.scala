package nebula.sim

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import spinal.core._
import spinal.core.sim._
import spinal.lib._
import nebula._
import nebula.cpu.mem._
import nebula.cpu._
import nebula.cpu.fetch._
import spinal.lib.bus.amba3.ahblite._
import spinal.lib.misc.pipeline._
import nebula.util._

case class InsnExtractorBench(cfg: NebulaCfg) extends Component {
    val io = new Bundle {
        val dout = master port Stream(Vec.fill(cfg.fetchChunks)(Flow(FetchData(cfg))))
    }
    
    val mem = new AlignedAhb3Rom(
        AhbLite3Config(16, cfg.memWidth),
        Seq(
            0x00, 0x00,
            0x03, 0x01, 0x00, 0x00,
            0x03, 0x02, 0x00, 0x00,
            0x00, 0x03,
            0x03, 0x04, 0x00, 0x00,
            0x03, 0x05, 0x00, 0x00,
            0x00, 0x06,
            0x00, 0x07,
            0x00, 0x08,
            0x03, 0x09, 0x00, 0x00,
            0x03, 0x0a, 0x00, 0x00,
            0x03, 0x0b, 0x00, 0x00,
            0x03, 0x0c, 0x00, 0x00,
            0x00, 0x0d,
            0x03, 0x0e, 0x00, 0x00,
            0x03, 0x0f, 0x00, 0x00,
            0x03, 0x10, 0x00, 0x00,
            0x03, 0x11, 0x00, 0x00,
        )
    )
    
    val reader = MemStreamReader(cfg, cfg.memWidth, 0, true)
    reader.io.jump := False
    reader.io.addr.assignDontCare()
    reader.io.mem.toAhbLite3 <> mem.io.ahb
    
    val pipeline  = new StageCtrlPipeline()
    val readerNode = new pipeline.Ctrl(0) {
        import cfg.payload._
        
        haltWhen(!reader.io.dout.valid)
        reader.io.dout.ready := down.ready
    }
    val extractor = InsnExtractor(cfg,  pipeline.ctrl(1))
    pipeline.build()
}

object InsnExtractorTest extends App {
    private val cfg = NebulaCfg(
        isa = ISA"RV32IC",
        frontendWidth = 2,
    )
    Config.sim.compile(InsnExtractorBench(cfg)).doSim(this.getClass.getSimpleName) { dut =>
        // Fork a process to generate the reset and the clock on the dut
        dut.clockDomain.forkStimulus(period = 10)
        dut.io.dout.ready #= true
        
    }
}
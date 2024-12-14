package nebula.cpu.fetch

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula.cpu._
import spinal.core._
import spinal.lib._
import spinal.lib.misc.pipeline._



/** Fetched instruction fragment. */
case class FetchData(cfg: NebulaCfg) extends Bundle {
    /** Instruction data. */
    val data = Bits(32 bits)
    /** Associated program counter. */
    val pc   = SInt(cfg.vaddrWidth bits)
}

/** Extracts instructions from a fetch packet. */
case class InsnExtractor(cfg: NebulaCfg, node: CtrlLink) {
    import cfg.payload._
    
    val logic = if (cfg.isa.C) new node.Area {
        /* ==== WITH COMPRESSED INSTRUCTIONS ==== */
        /**
         * Whether the buffer contains valid data.
         * Never valid if it contains a 16-bit instruction.
         */
        val buf_valid   = RegInit(False)
        /** Buffered MSB from previous fetch packet. */
        val buf         = Reg(Bits(16 bits))
        /** Base address of previous fetch packet. */
        val buf_pc      = Reg(SInt(cfg.vaddrWidth bits))
        
        /** Halfwords of instruction data. */
        val hw_insn     = Vec.fill(cfg.fetchChunks)(Bits(16 bits))
        /** Which halfwords are valid. */
        val hw_valid    = Bits(cfg.fetchChunks bits)
        /** Which halfwords could be the start of a 32-bit instruction. */
        val hw_32bit    = Bits(cfg.fetchChunks bits)
        /** PC value per halfword. */
        val hw_pc       = Vec.fill(cfg.fetchChunks)(SInt(cfg.vaddrWidth bits))
        
        // Infer per-halfword information.
        hw_32bit(0) := hw_insn(0)(1 downto 0) === b"11" && !buf_valid
        for (i <- 1 until cfg.fetchChunks) {
            hw_valid(i)           := FETCH_PACKET(i).valid
            hw_32bit(i)           := hw_insn(i)(1 downto 0) === b"11"
        }
        for (i <- 0 until cfg.fetchChunks) {
            val r = log2Up(cfg.fetchChunks)
            hw_insn(i)            := FETCH_PACKET(i).payload
            hw_pc(i)              := PC
            hw_pc(i)(r downto 1)  := S(i, r bits)
            hw_pc(i)(0)           := False
        }
        
        // Special: First half-word.
        when (buf_valid) {
            // Consumed by misaligned instruction.
            UNPACKED_RAW_INSNS(0).payload.data(15 downto 0)  := buf
            UNPACKED_RAW_INSNS(0).payload.data(31 downto 16) := hw_insn(0)
            UNPACKED_RAW_INSNS(0).payload.pc                 := buf_pc
            UNPACKED_RAW_INSNS(0).valid                      := hw_valid(0)
        } elsewhen (hw_32bit(0)) {
            // 32-bit instruction.
            UNPACKED_RAW_INSNS(0).payload.data(15 downto 0)  := hw_insn(0)
            UNPACKED_RAW_INSNS(0).payload.data(31 downto 16) := hw_insn(1)
            UNPACKED_RAW_INSNS(0).payload.pc                 := hw_pc(0)
            UNPACKED_RAW_INSNS(0).valid                      := hw_valid(0) && hw_valid(1)
        } otherwise {
            // 16-bit instruction.
            UNPACKED_RAW_INSNS(0).payload.data(15 downto 0)  := hw_insn(0)
            UNPACKED_RAW_INSNS(0).payload.data(31 downto 16).assignDontCare
            UNPACKED_RAW_INSNS(0).payload.pc                 := hw_pc(0)
            UNPACKED_RAW_INSNS(0).valid                      := hw_valid(0)
        }
        
        // Remaining halfwords.
        for (i <- 1 until cfg.fetchChunks) {
            when(hw_valid(i-1) && hw_32bit(i-1)) {
                // Consumed by earlier instruction.
                UNPACKED_RAW_INSNS(i).payload.assignDontCare
                UNPACKED_RAW_INSNS(i).valid := False
            } elsewhen (hw_32bit(i)) {
                // 32-bit instruction.
                UNPACKED_RAW_INSNS(i).payload.data(15 downto 0)  := hw_insn(i)
                UNPACKED_RAW_INSNS(i).payload.data(31 downto 16) := hw_insn(i+1)
                UNPACKED_RAW_INSNS(0).payload.pc                 := hw_pc(i)
                UNPACKED_RAW_INSNS(i).valid                      := hw_valid(0)
            } otherwise {
                // 16-bit instruction.
                UNPACKED_RAW_INSNS(i).payload.data(15 downto 0)  := hw_insn(i)
                UNPACKED_RAW_INSNS(i).payload.data(31 downto 16).assignDontCare
                UNPACKED_RAW_INSNS(0).payload.pc                 := hw_pc(i)
                UNPACKED_RAW_INSNS(i).valid                      := hw_valid(0)
            }
        }
        
    } else new node.Area {
        /* ==== WITHOUT COMPRESSED INSTRUCTIONS ==== */
    }
}

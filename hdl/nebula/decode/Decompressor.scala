package nebula.decode

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula.cpu._
import spinal.core._
import scala.collection.mutable.MutableList



/**
 * Decompresses 16-bit instruction into 32-bit instructions.
 * If an illegal instruction exception would be raised,
 * returns the 16-bit instruction verbatim.
 */
case class Decompressor(cfg: NebulaCfg) extends Component {
    val io = new Bundle {
        /** Instruction to decompress. */
        val raw    = in  port Bits(16 bits)
        /** Decompressed instruction.  */
        val decomp = out port Bits(32 bits)
    }
    
    val verbatim = Bits(32 bits)
    verbatim(31 downto 16).assignDontCare()
    verbatim(15 downto  0) := io.raw
    
    // Build list of opcodes.
    var ops: MutableList[(Any, Bits)] = MutableList()
    ops += B"32'b0" -> verbatim
    ops ++ RVC.Zca(cfg, io.raw)
    if (cfg.isa.F && !cfg.isa.RV64) {
        ops ++= RVC.Zcf(cfg, io.raw)
    }
    ops += default -> verbatim
    
    // Instantiate decoder
    io.decomp := SpinalMap.list(io.raw, ops)
}

/** Compressed instruction format definitions. */
object RVC {
    /** Base compressed instructions. */
    def Zca(cfg: NebulaCfg, raw: Bits): Seq[(Any, Bits)] = Seq()
    /** Base compressed instructions added by RV64. */
    def RV64(cfg: NebulaCfg, raw: Bits): Seq[(Any, Bits)] = Seq()
    /** Additional common compressed instructions. */
    def Zcb(cfg: NebulaCfg, raw: Bits): Seq[(Any, Bits)] = Seq()
    /** RV32 single-precision floating-point compressed instructions. */
    def Zcf(cfg: NebulaCfg, raw: Bits): Seq[(Any, Bits)] = Seq()
    /** Double-precision floating-point compressed instructions. */
    def Zcd(cfg: NebulaCfg, raw: Bits): Seq[(Any, Bits)] = Seq()
}

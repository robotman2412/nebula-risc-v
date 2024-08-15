package nebula.decode

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import nebula.cpu._
import spinal.core._
import scala.collection.mutable.MutableList
import nebula.util.BCat



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
    // Aliases.
    val X0 = U"00000"
    val RA = U"00001"
    val SP = U"00010"
    val raw      = io.raw
    val illegal = Bits(32 bits)
    illegal(31 downto 16).assignDontCare()
    illegal(15 downto  0) := io.raw
    
    /** Low-order bits 3-bit register number. */
    val r3l = BCat(B"01", raw(4 downto 2)).asUInt
    /** High-order bits 3-bit register number. */
    val r3h = BCat(B"01", raw(9 downto 7)).asUInt
    /** 5-bit register number. */
    val r5  = raw(11 downto 7).asUInt
    
    
    /** Generate a don't care bits object. */
    def DontCare(len: BitCount) = {
        val tmp = Bits(len)
        tmp.assignDontCare()
        tmp
    }
    
    /** Generate an ALU instruction. */
    def OP_OP_IMM(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = BCat(imm.resize(12 bits), rs1, funct3, rd, B"0010011")
    /** Generate a load instruction. */
    def OP_LD(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = BCat(imm, rs1, funct3, rd, B"0000011")
    /** Generate a store instruction. */
    def OP_ST(funct3: Bits, rs1: UInt, rs2: UInt, imm: BitVector) = BCat(imm(11 downto 5), rs2, rs1, funct3, imm(4 downto 0), B"0100011")
    /** Generate a load instruction. */
    def OP_FLD(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = BCat(imm, rs1, funct3, rd, B"0000111")
    /** Generate a store instruction. */
    def OP_FST(funct3: Bits, rs1: UInt, rs2: UInt, imm: BitVector) = BCat(imm(11 downto 5), rs2, rs1, funct3, imm(4 downto 0), B"0100111")
    /** Generate a JAL instruction. */
    def OP_JAL(rd: UInt, imm: SInt) = BCat(imm(20), imm(10 downto 1), imm(11), imm(19 downto 12), rd, B"1101111")
    
    /** Memory offsets with multiplier 4. */
    val memOff4 = BCat(raw(5), raw(12 downto 10), raw(6), B"00").asSInt.resize(12)
    /** Memory offsets with multiplier 8. */
    val memOff8 = BCat(raw(6 downto 5), raw(12 downto 10), B"000").asSInt.resize(12)
    /** C.JAL and C.J jump offset. */
    val jaddr   = BCat(raw(12), raw(8), raw(10 downto 9), raw(6), raw(7), raw(2), raw(11), raw(5 downto 3), B"0").asSInt.resize(21)
    /** 11-bit IMM for C.ADDI4SPN. */
    val immspn4 = BCat(raw(10 downto 7), raw(12 downto 11), raw(5), raw(6), B"00").asSInt.resize(12)
    /** 6-bit IMM for C.ADDI16SP. */
    val immsp16 = BCat(raw(12), raw(4 downto 3), raw(5), raw(2), raw(6), B"0000").asSInt.resize(12)
    /** 6-bit IMM type (e.g. c.addi, c.srli). */
    val imm6    = BCat(raw(6 downto 2), raw(12)).asSInt.resize(12)
    /** 6-bit IMM type for c.srai. */
    val imm6sra = BCat(B"010000", raw(6 downto 2), raw(12))
    
    /** Base compressed instructions. */
    val Zca: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 0 ==== */
        M"00000000000---00" -> illegal,                                 // reserved
        M"000-----------00" -> OP_OP_IMM(B"000", r3l, SP, immspn4),     // c.addi4spn:  addi rd, sp, 4*imm
        M"010-----------00" -> OP_LD(B"010", r3l, r3h, memOff4),        // c.lw:        lw   rd', 4*imm(rs1')
        M"010-----------00" -> OP_ST(B"010", r3l, r3h, memOff4),        // c.sw:        sw   rd', 4*imm(rs1')
        
        /* ==== Quadrant 1 ==== */
        M"000-----------01" -> OP_OP_IMM(B"000", r5, r5, imm6),         // c.addi:      addi rd, rd, imm        Also c.nop
        M"010-----------01" -> OP_OP_IMM(B"000", r5, X0, imm6),         // c.li:        addi rd, x0, imm
        M"011-00010-----01" -> OP_OP_IMM(B"000", SP, SP, immsp16),      // c.addi16sp:  addi sp, sp, 16*imm
        M"0110-----0000001" -> illegal,                                 // reserved
        M"011-----------01" -> BCat(imm6.resize(20), r5, B"0110111"),   // c.lui:       lui  rd, imm
        M"100-10--------01" -> OP_OP_IMM(B"111", r3h, r3h, imm6),       // c.andi:      andi rd, rd, imm
        
        /* ==== Quadrant 2 ==== */
    )
    
    /** Base compressed instructions added by RV32. */
    val RV32: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 1 ==== */
        M"001-----------01" -> OP_JAL(RA, jaddr),                       // c.jal:       jal  ra, imm
        M"100000--------01" -> OP_OP_IMM(B"101", r3h, r3h, imm6),       // c.srli:      srli rd, rd, imm
        M"100000--------01" -> OP_OP_IMM(B"101", r3h, r3h, imm6sra),    // c.srai:      srai rd, rd, imm
    )
    
    /** Base compressed instructions added by RV64. */
    val RV64: Seq[(Any, Bits)] = Seq()
    
    /** RV32 single-precision floating-point compressed instructions. */
    val Zcf: Seq[(Any, Bits)] = Seq()
    
    /** Double-precision floating-point compressed instructions. */
    val Zcd: Seq[(Any, Bits)] = Seq()
    
    
    // Build list of opcodes.
    var ops: MutableList[(Any, Bits)] = MutableList()
    ops ++= Zca
    if (cfg.isa.RV64)
        ops ++= RV64
    else
        ops ++= RV32
    if (cfg.isa.F && !cfg.isa.RV64)
        ops ++= Zcf
    if (cfg.isa.D)
        ops ++= Zcd
    ops += default -> illegal
    
    // Instantiate decoder
    io.decomp := SpinalMap.list(io.raw, ops)
}

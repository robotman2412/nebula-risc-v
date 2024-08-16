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
    // Aliases.
    val X0      = U"00000"
    val RA      = U"00001"
    val SP      = U"00010"
    val raw     = io.raw
    val illegal = Cat(DontCare(16 bits), raw)
    
    /** Low-order bits 3-bit register number. */
    val r3l = Cat(B"01", raw(4 downto 2)).asUInt
    /** High-order bits 3-bit register number. */
    val r3h = Cat(B"01", raw(9 downto 7)).asUInt
    /** Low-order 5-bit register number. */
    val r5l  = raw(6 downto 2).asUInt
    /** High-order 5-bit register number. */
    val r5h  = raw(11 downto 7).asUInt
    
    
    /** Generate a don't care bits object. */
    def DontCare(len: BitCount) = {
        val tmp = Bits(len)
        tmp.assignDontCare()
        tmp
    }
    
    /** Generate an ALU instruction. */
    def OP_OP_IMM(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = Cat(imm.resize(12 bits), rs1, funct3, rd, B"0010011")
    /** Generate an ALU instruction. */
    def OP_OP(funct3: Bits, rd: UInt, rs1: UInt, rs2: UInt) = Cat(B"0000000", rs1, rs1, funct3, rd, B"0110011")
    /** Generate an ALU instruction. */
    def OP_OP_ALT(funct3: Bits, rd: UInt, rs1: UInt, rs2: UInt) = Cat(B"0000000", rs1, rs1, funct3, rd, B"0110011")
    /** Generate an ALU instruction. */
    def OP_OP32_IMM(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = Cat(imm.resize(12 bits), rs1, funct3, rd, B"0011011")
    /** Generate an ALU instruction. */
    def OP_OP32(funct3: Bits, rd: UInt, rs1: UInt, rs2: UInt) = Cat(B"0000000", rs1, rs1, funct3, rd, B"0111011")
    /** Generate an ALU instruction. */
    def OP_OP32_ALT(funct3: Bits, rd: UInt, rs1: UInt, rs2: UInt) = Cat(B"0000000", rs1, rs1, funct3, rd, B"0111011")
    /** Generate a load instruction. */
    def OP_LD(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = Cat(imm, rs1, funct3, rd, B"0000011")
    /** Generate a store instruction. */
    def OP_ST(funct3: Bits, rs1: UInt, rs2: UInt, imm: BitVector) = Cat(imm(11 downto 5), rs2, rs1, funct3, imm(4 downto 0), B"0100011")
    /** Generate a load instruction. */
    def OP_FLD(funct3: Bits, rd: UInt, rs1: UInt, imm: BitVector) = Cat(imm, rs1, funct3, rd, B"0000111")
    /** Generate a store instruction. */
    def OP_FST(funct3: Bits, rs1: UInt, rs2: UInt, imm: BitVector) = Cat(imm(11 downto 5), rs2, rs1, funct3, imm(4 downto 0), B"0100111")
    /** Generate a JAL instruction. */
    def OP_JAL(rd: UInt, imm: SInt) = Cat(imm(20), imm(10 downto 1), imm(11), imm(19 downto 12), rd, B"1101111")
    /** Generate a JALR instruction. */
    def OP_JALR(rd: UInt, rs1: UInt) = Cat(B"12'0", rs1, B"000", rd, B"1100111")
    /** Generate a BRANCH instruction. */
    def OP_BRANCH(funct3: Bits, rs1: UInt, rs2: UInt, imm: SInt) = Cat(imm(12), imm(10 downto 5), rs2, rs1, funct3, imm(4 downto 1), imm(11), B"1100011")
    
    /** Memory offsets with multiplier 4. */
    val memOff4 = Cat(raw(5), raw(12 downto 10), raw(6), B"00").asSInt.resize(12)
    /** Memory offsets with multiplier 8. */
    val memOff8 = Cat(raw(6 downto 5), raw(12 downto 10), B"000").asSInt.resize(12)
    /** Stack offsets with multiplier 4 stored mainly in low-order bits. */
    val spOff4l = Cat(raw(3 downto 2), raw(12), raw(6 downto 4), B"00").asSInt.resize(12)
    /** Stack offsets with multiplier 8 stored mainly in low-order bits. */
    val spOff8l = Cat(raw(4 downto 2), raw(15), raw(6 downto 3), B"000").asSInt.resize(12)
    /** Stack offsets with multiplier 4 stored high-order bits. */
    val spOff4h = Cat(raw(8 downto 7), raw(12 downto 9), B"00").asSInt.resize(12)
    /** Stack offsets with multiplier 8 stored high-order bits. */
    val spOff8h = Cat(raw(9 downto 7), raw(12 downto 10), B"00").asSInt.resize(12)
    /** C.JAL and C.J jump offset. */
    val jaddr   = Cat(raw(12), raw(8), raw(10 downto 9), raw(6), raw(7), raw(2), raw(11), raw(5 downto 3), B"0").asSInt.resize(21)
    /** C.BEQZ and C.BNEZ branch offset. */
    val baddr   = Cat(raw(12), raw(6 downto 5), raw(2), raw(11 downto 10), raw(4 downto 3), B"0").asSInt.resize(13)
    /** 11-bit IMM for C.ADDI4SPN. */
    val immspn4 = Cat(raw(10 downto 7), raw(12 downto 11), raw(5), raw(6), B"00").asSInt.resize(12)
    /** 6-bit IMM for C.ADDI16SP. */
    val immsp16 = Cat(raw(12), raw(4 downto 3), raw(5), raw(2), raw(6), B"0000").asSInt.resize(12)
    /** 6-bit IMM type (e.g. c.addi, c.srli). */
    val imm6    = Cat(raw(6 downto 2), raw(12)).asSInt.resize(12)
    /** 6-bit IMM type for c.srai. */
    val imm6sra = Cat(B"010000", raw(6 downto 2), raw(12))
    
    
    /** Base compressed instructions. */
    val Zca: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 0 ==== */
        M"00000000000---00" -> illegal,                                 // reserved
        M"000-----------00" -> OP_OP_IMM(B"000", r3l, SP, immspn4),     // c.addi4spn:  addi    rd', sp, 4*imm
        M"010-----------00" -> OP_LD(B"010", r3l, r3h, memOff4),        // c.lw:        lw      rd', 4*imm(rs1')
        M"110-----------00" -> OP_ST(B"010", r3l, r3h, memOff4),        // c.sw:        sw      rd', 4*imm(rs1')
        
        /* ==== Quadrant 1 ==== */
        M"000-----------01" -> OP_OP_IMM(B"000", r5h, r5h, imm6),       // c.addi:      addi    rd, rd, imm         Also implies c.nop
        M"010-----------01" -> OP_OP_IMM(B"000", r5h, X0, imm6),        // c.li:        addi    rd, x0, imm
        M"0110000100000001" -> illegal,                                 // reserved
        M"011-00010-----01" -> OP_OP_IMM(B"000", SP, SP, immsp16),      // c.addi16sp:  addi    sp, sp, 16*imm
        M"0110-----0000001" -> illegal,                                 // reserved
        M"011-----------01" -> Cat(imm6.resize(20), r5h, B"0110111"),   // c.lui:       lui     rd, imm
        M"100-10--------01" -> OP_OP_IMM(B"111", r3h, r3h, imm6),       // c.andi:      andi    rd', rd', imm
        M"100011---00---01" -> OP_OP_ALT(B"000", r3h, r3h, r3l),        // c.sub:       sub     rd', rd', rs2'
        M"100011---01---01" -> OP_OP(B"100", r3h, r3h, r3l),            // c.xor:       xor     rd', rd', rs2'
        M"100011---10---01" -> OP_OP(B"110", r3h, r3h, r3l),            // c.or:        or      rd', rd', rs2'
        M"100011---11---01" -> OP_OP(B"111", r3h, r3h, r3l),            // c.and:       and     rd', rd', rs2'
        M"101-----------01" -> OP_JAL(X0, jaddr),                       // c.j:         j       imm    
        M"110-----------01" -> OP_BRANCH(B"000", r3h, X0, baddr),       // c.beqz:      beq     rs1', x0, imm
        M"111-----------01" -> OP_BRANCH(B"001", r3h, X0, baddr),       // c.bnez:      bne     rs1', x0, imm
        
        /* ==== Quadrant 2 ==== */
        M"010-00000-----10" -> illegal,                                 // reserved
        M"010-----------10" -> OP_LD(B"010", r5h, SP, spOff4l),         // c.lwsp:      lw      rd, 4*imm(sp)
        M"1000000000000010" -> illegal,                                 // reserved
        M"1000-----0000010" -> OP_JALR(X0, r5h),                        // c.jr:        jr      rs1
        M"1000----------10" -> OP_OP_IMM(B"000", r5h, r5l, B"12'0"),    // c.mv:        mv      rd, rs1
        M"1001000000000010" -> B"000000000001_00000_000_00000_1110011", // c.ebreak:    ebreak
        M"1001-----0000010" -> OP_JALR(RA, r5h),                        // c.jalr:      jalr    ra, rs1
        M"1001----------10" -> OP_OP(B"000", r5h, r5h, r5l),            // c.add:       add     rd, rd, rs2
        M"110-----------10" -> OP_ST(B"010", SP, r5l, spOff4h),         // c.swsp:      sw      rs1, 4*imm(sp)
    )
    
    /** Base compressed instructions added by RV32. */
    val RV32: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 1 ==== */
        M"001-----------01" -> OP_JAL(RA, jaddr),                       // c.jal:       jal     ra, imm
        M"100000--------01" -> OP_OP_IMM(B"101", r3h, r3h, imm6),       // c.srli:      srli    rd', rd', imm
        M"100000--------01" -> OP_OP_IMM(B"101", r3h, r3h, imm6sra),    // c.srai:      srai    rd', rd', imm
        
        /* ==== Quadrant 2 ==== */
        M"0000----------10" -> OP_OP_IMM(B"101", r5h, r5h, imm6),       // c.slli:      slli    rd, rd, imm
        M"100011---00---01" -> OP_OP32_ALT(B"000", r3h, r3h, r3l),      // c.subw:      subw     rd', rd', rs2'
        M"100011---00---01" -> OP_OP32(B"000", r3h, r3h, r3l),          // c.addw:      addw     rd', rd', rs2'
    )
    
    /** Base compressed instructions added by RV64. */
    val RV64: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 0 ==== */
        M"011-----------00" -> OP_ST(B"011", r3l, r3h, memOff8),        // c.sd:        sd      rd', 8*imm(rs1')
        M"011-----------00" -> OP_LD(B"011", r3l, r3h, memOff8),        // c.ld:        ld      rd', 8*imm(rs1')
        
        /* ==== Quadrant 1 ==== */
        M"000-00000-----01" -> illegal,                                 // reserved
        M"000-----------01" -> OP_OP32_IMM(B"000", r5h, r5h, imm6),     // c.addiw:     addiw   rd, rd, imm
        M"100-00--------01" -> OP_OP_IMM(B"101", r3h, r3h, imm6),       // c.srli:      srli    rd', rd', imm
        M"100-00--------01" -> OP_OP_IMM(B"101", r3h, r3h, imm6sra),    // c.srai:      srai    rd', rd', imm
        
        /* ==== Quadrant 2 ==== */
        M"000-----------10" -> OP_OP_IMM(B"101", r5h, r5h, imm6),       // c.slli:      slli    rd, rd, imm
        M"011-00000-----10" -> illegal,                                 // reserved
        M"011-----------10" -> OP_LD(B"011", r5h, SP, spOff8l),         // c.ldsp:      ld      rd, 8*imm(sp)
        M"111-----------10" -> OP_ST(B"011", SP, r5l, spOff8h),         // c.sdsp:      sd      rs1, 8*imm(sp)
    )
    
    /** RV32 single-precision floating-point compressed instructions. */
    val Zcf: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 0 ==== */
        M"011-----------00" -> OP_LD(B"010", r3l, r3h, memOff4),        // c.flw:       flw     rd', 4*imm(rs1')
        M"111-----------00" -> OP_ST(B"010", r3l, r3h, memOff4),        // c.fsw:       fsw     rd', 4*imm(rs1')
        
        /* ==== Quadrant 2 ==== */
        M"011-00000-----10" -> illegal,                                 // reserved
        M"011-----------10" -> OP_LD(B"010", r5h, SP, spOff4l),         // c.flwsp:     flw     rd, 4*imm(sp)
        M"111-----------10" -> OP_ST(B"010", SP, r5l, spOff4h),         // c.fswsp:     fsw     rs1, 4*imm(sp)
    )
    
    /** Double-precision floating-point compressed instructions. */
    val Zcd: Seq[(Any, Bits)] = Seq(
        /* ==== Quadrant 0 ==== */
        M"001-----------00" -> OP_LD(B"011", r3l, r3h, memOff8),        // c.fld:       fld     rd', 8*imm(rs1')
        M"101-----------00" -> OP_ST(B"011", r3l, r3h, memOff8),        // c.fsd:       fsd     rd', 8*imm(rs1')
        
        /* ==== Quadrant 2 ==== */
        M"001-00000-----10" -> illegal,                                 // reserved
        M"001-----------10" -> OP_LD(B"011", r5h, SP, spOff8l),         // c.fldsp:     fld     rd, 8*imm(sp)
        M"101-----------10" -> OP_ST(B"011", SP, r5l, spOff8h),         // c.fsdsp:     fsd     rs1, 8*imm(sp)
    )
    
    
    // Build list of opcodes.
    var ops: MutableList[(Any, Bits)] = MutableList()
    ops += M"--------------11" -> DontCare(32 bits)
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

package nebula

// Copyright © 2024, Julian Scheffers, see LICENSE for info

import spinal.core._



object Riscv {
    // 32-bit opcodes
    val OP_LOAD             = M"00000"
    val OP_LOAD_FP          = M"00001"
    val OP_custom_0         = M"00010"
    val OP_MISC_MEM         = M"00011"
    val OP_OP_IMM           = M"00100"
    val OP_AUIPC            = M"00101"
    val OP_OP_IMM_32        = M"00110"
    val OP_STORE            = M"01000"
    val OP_STORE_FP         = M"01001"
    val OP_custom_1         = M"01010"
    val OP_AMO              = M"01011"
    val OP_OP               = M"01100"
    val OP_LUI              = M"01101"
    val OP_OP_32            = M"01110"
    val OP_MADD             = M"10000"
    val OP_MSUB             = M"10001"
    val OP_NMSUB            = M"10010"
    val OP_NMADD            = M"10011"
    val OP_OP_FP            = M"10100"
    val OP_custom_2         = M"10110"
    val OP_BRANCH           = M"11000"
    val OP_JALR             = M"11001"
    val OP_JAL              = M"11011"
    val OP_SYSTEM           = M"11100"
    val OP_custom_3         = M"11110"
    
    // 32-bit opcode groups
    val ALU_OPS             = M"0-1-0"
    val MEM_OPS             = M"0-00-"
    val UIMM_OPS            = M"0-101"
    val MADD_OPS            = M"100--"
    
    // 16-bit opcodes
    val OPC_ADDI4SPN        = M"00000"
    val OPC_FLD             = M"00001"
    val OPC_LW              = M"00010"
    val OPC_FLW_LD          = M"00011"
    val OPC_FSD             = M"00101"
    val OPC_SW              = M"00110"
    val OPC_FSW_SD          = M"00111"

    val OPC_ADDI            = M"01000"
    val OPC_JAL_ADDIW       = M"01001"
    val OPC_LI              = M"01010"
    val OPC_LUI_ADDI16SP    = M"01011"
    val OPC_ALU             = M"01100"
    val OPC_J               = M"01101"
    val OPC_BEQZ            = M"01110"
    val OPC_BNEZ            = M"01111"

    val OPC_SLLI            = M"10000"
    val OPC_FLDSP           = M"10001"
    val OPC_LWSP            = M"10010"
    val OPC_FLWSP_LDSP      = M"10011"
    val OPC_JR_MV_ADD       = M"10100"
    val OPC_FSDSP           = M"10101"
    val OPC_SWSP            = M"10110"
    val OPC_FSWSP_SDSP      = M"10111"

    // ALU FUNCT3 values.
    val ALU_ADD             = M"000"
    val ALU_SLL             = M"001"
    val ALU_SLT             = M"010"
    val ALU_SLTU            = M"011"
    val ALU_XOR             = M"100"
    val ALU_SRL             = M"101"
    val ALU_OR              = M"110"
    val ALU_AND             = M"111"
}

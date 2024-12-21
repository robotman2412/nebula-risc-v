// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : nebulaRVIO
// Git hash  : e19e64bb140d9f61dd9ab4bbd0d8d2224ed11bdf

`timescale 1ns/1ps

module nebulaRVIO (
  input  wire          clk,
  input  wire          reset
);
  localparam RDTYPE_RD_INT = 2'd0;
  localparam RDTYPE_RD_FP = 2'd1;
  localparam RDTYPE_RD_VEC = 2'd2;
  localparam RDTYPE_RD_NA = 2'd3;
  localparam YESNO_Y = 1'd0;
  localparam YESNO_N = 1'd1;
  localparam AluOp_add = 5'd0;
  localparam AluOp_sub = 5'd1;
  localparam AluOp_sll_1 = 5'd2;
  localparam AluOp_srl_1 = 5'd3;
  localparam AluOp_sra_1 = 5'd4;
  localparam AluOp_or_1 = 5'd5;
  localparam AluOp_xor_1 = 5'd6;
  localparam AluOp_slt = 5'd7;
  localparam AluOp_sltu = 5'd8;
  localparam AluOp_and_1 = 5'd9;
  localparam AluOp_na = 5'd10;
  localparam AluOp_lui = 5'd11;
  localparam AluOp_addw = 5'd12;
  localparam AluOp_sllw = 5'd13;
  localparam AluOp_sraw = 5'd14;
  localparam AluOp_srlw = 5'd15;
  localparam AluOp_subw = 5'd16;
  localparam AluOp_jal = 5'd17;
  localparam AluOp_jalr = 5'd18;
  localparam AluOp_beq = 5'd19;
  localparam AluOp_bne = 5'd20;
  localparam AluOp_bge = 5'd21;
  localparam AluOp_bgeu = 5'd22;
  localparam AluOp_blt = 5'd23;
  localparam AluOp_bltu = 5'd24;
  localparam Imm_Select_N_IMM = 3'd0;
  localparam Imm_Select_I_IMM = 3'd1;
  localparam Imm_Select_S_IMM = 3'd2;
  localparam Imm_Select_B_IMM = 3'd3;
  localparam Imm_Select_U_IMM = 3'd4;
  localparam Imm_Select_J_IMM = 3'd5;
  localparam RSTYPE_RS_INT = 3'd0;
  localparam RSTYPE_RS_FP = 3'd1;
  localparam RSTYPE_RS_VEC = 3'd2;
  localparam RSTYPE_IMMED = 3'd3;
  localparam RSTYPE_RS_NA = 3'd4;
  localparam ExecutionUnit_ALU = 3'd0;
  localparam ExecutionUnit_FPU = 3'd1;
  localparam ExecutionUnit_AGU = 3'd2;
  localparam ExecutionUnit_BR = 3'd3;
  localparam ExecutionUnit_NA = 3'd4;

  wire       [31:0]   fetcher_mem_spinal_port0;
  wire       [31:0]   fetcher_mem_spinal_port1;
  wire       [63:0]   intregFile_reggy_mem_spinal_port0;
  wire       [63:0]   intregFile_reggy_mem_spinal_port1;
  wire       [0:0]    _zz_decoder_trap_shouldHalt;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_1;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_2;
  wire       [3:0]    _zz__zz_d0_down_Decoder_ALUOP_6_3;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_4;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_5;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_6;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_7;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_8;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_9;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_10;
  wire       [5:0]    _zz__zz_d0_down_Decoder_ALUOP_6_11;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_12;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_13;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_14;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_15;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_16;
  wire       [2:0]    _zz__zz_d0_down_Decoder_ALUOP_6_17;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_18;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_19;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_20;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_21;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_22;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_23;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_24;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_25;
  wire       [6:0]    _zz__zz_d0_down_Decoder_ALUOP_6_26;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_27;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_28;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_29;
  wire       [3:0]    _zz__zz_d0_down_Decoder_ALUOP_6_30;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_31;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_32;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_33;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_34;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_35;
  wire       [1:0]    _zz__zz_d0_down_Decoder_ALUOP_6_36;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_37;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_38;
  wire       [8:0]    _zz__zz_d0_down_Decoder_ALUOP_6_39;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_40;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_41;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_42;
  wire       [5:0]    _zz__zz_d0_down_Decoder_ALUOP_6_43;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_44;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_45;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_46;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_47;
  wire       [31:0]   _zz__zz_d0_down_Decoder_ALUOP_6_48;
  wire       [3:0]    _zz__zz_d0_down_Decoder_ALUOP_6_49;
  wire                _zz__zz_d0_down_Decoder_ALUOP_6_50;
  wire       [0:0]    _zz__zz_d0_down_Decoder_ALUOP_6_51;
  wire       [1:0]    _zz__zz_d0_down_Decoder_ALUOP_6_52;
  wire                _zz_intregFile_reggy_mem_port;
  wire       [31:0]   _zz__zz_srcPlugin_immsel_imm_u_sext_pub;
  wire       [31:0]   _zz__zz_srcPlugin_immsel_sext;
  wire       [11:0]   _zz__zz_srcPlugin_immsel_sext_1;
  wire       [11:0]   _zz__zz_srcPlugin_immsel_sext_1_1;
  wire       [12:0]   _zz__zz_srcPlugin_immsel_sext_1_2;
  wire       [20:0]   _zz__zz_srcPlugin_immsel_sext_1_3;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_1;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_2;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_3;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_4;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_5;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_6;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_7;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_8;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_9;
  wire       [31:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_10;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_11;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_12;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_13;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_14;
  wire       [31:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_15;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_16;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_17;
  wire       [31:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_18;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_19;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_20;
  wire       [31:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_21;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_22;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_23;
  wire       [31:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_24;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_25;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_26;
  wire       [63:0]   _zz__zz_executePipeline_intalu_aluNodeStage_result_27;
  wire       [0:0]    _zz_executePipeline_intalu_aluNodeStage_result_1;
  wire       [63:0]   _zz_executePipeline_intalu_aluNodeStage_result_2;
  wire       [63:0]   _zz_executePipeline_intalu_aluNodeStage_result_3;
  wire       [0:0]    _zz_executePipeline_intalu_aluNodeStage_result_4;
  wire       [31:0]   _zz_E1_down_Execute_RESULT;
  wire                E1_up_isReady;
  wire                d0_up_isReady;
  wire                fetch_up_isReady;
  wire                fetch_up_isValid;
  wire                E1_down_isValid;
  wire                rfread0_down_isValid;
  wire                dis0_down_isValid;
  wire                d0_down_isValid;
  wire                d0_up_isValid;
  wire                fetch_down_isValid;
  reg        [31:0]   wbStage_up_Decoder_INSTRUCTION;
  reg        [63:0]   E1_up_SrcPlugin_RS2;
  reg        [63:0]   E1_up_SrcPlugin_RS1;
  reg        [4:0]    E1_up_Decoder_RD;
  wire       [1:0]    E1_down_Decoder_RDTYPE;
  reg        [31:0]   E1_up_Decoder_INSTRUCTION;
  wire       [31:0]   E1_down_Decoder_INSTRUCTION;
  reg                 rfread0_up_Dispatch_SENDTOBRANCH;
  wire                rfread0_down_Dispatch_SENDTOBRANCH;
  reg                 rfread0_up_Dispatch_SENDTOALU;
  wire                rfread0_down_Dispatch_SENDTOALU;
  reg        [4:0]    rfread0_up_Decoder_RS2;
  reg        [4:0]    rfread0_up_Decoder_RS1;
  reg        [4:0]    rfread0_up_Decoder_RD;
  reg        [0:0]    rfread0_up_Decoder_IS_W;
  wire       [0:0]    rfread0_down_Decoder_IS_W;
  reg        [4:0]    rfread0_up_Decoder_ALUOP;
  wire       [4:0]    rfread0_down_Decoder_ALUOP;
  wire       [1:0]    rfread0_down_Decoder_RDTYPE;
  reg        [31:0]   rfread0_up_Decoder_INSTRUCTION;
  reg        [4:0]    dis0_up_Decoder_RS2;
  wire       [4:0]    dis0_down_Decoder_RS2;
  reg        [4:0]    dis0_up_Decoder_RS1;
  wire       [4:0]    dis0_down_Decoder_RS1;
  reg        [4:0]    dis0_up_Decoder_RD;
  reg        [0:0]    dis0_up_Decoder_IS_W;
  wire       [0:0]    dis0_down_Decoder_IS_W;
  reg        [4:0]    dis0_up_Decoder_ALUOP;
  wire       [4:0]    dis0_down_Decoder_ALUOP;
  reg        [2:0]    dis0_up_Decoder_IMMSEL;
  wire       [2:0]    dis0_down_Decoder_IMMSEL;
  reg        [2:0]    dis0_up_Decoder_RS2TYPE;
  wire       [2:0]    dis0_down_Decoder_RS2TYPE;
  reg        [2:0]    dis0_up_Decoder_RS1TYPE;
  wire       [2:0]    dis0_down_Decoder_RS1TYPE;
  wire       [1:0]    dis0_down_Decoder_RDTYPE;
  reg        [31:0]   dis0_up_Decoder_INSTRUCTION;
  wire       [31:0]   dis0_down_Decoder_INSTRUCTION;
  wire                d0_down_isReady;
  wire                fetch_down_isReady;
  wire                wbStage_down_valid;
  reg                 wbStage_up_valid;
  wire                E1_down_valid;
  reg                 E1_up_valid;
  wire                rfread0_down_valid;
  reg                 rfread0_up_valid;
  wire                dis0_down_valid;
  reg                 dis0_up_valid;
  reg                 d0_down_valid;
  reg                 d0_up_valid;
  reg                 fetch_down_valid;
  reg                 fetch_up_ready;
  reg                 fetch_down_ready;
  reg                 d0_up_ready;
  reg        [63:0]   wbStage_up_Execute_RESULT;
  reg        [4:0]    wbStage_up_Decoder_RD;
  wire                wbStage_up_isValid;
  wire       [31:0]   wbStage_down_Decoder_INSTRUCTION;
  reg                 E1_up_Dispatch_SENDTOBRANCH;
  reg        [0:0]    E1_up_Decoder_IS_W;
  wire                E1_up_isFiring;
  reg        [63:0]   E1_down_Execute_RESULT;
  wire       [63:0]   E1_down_SrcPlugin_RS2;
  wire       [63:0]   E1_down_SrcPlugin_RS1;
  reg        [4:0]    E1_up_Decoder_ALUOP;
  wire                E1_up_isValid;
  reg                 E1_up_Dispatch_SENDTOALU;
  reg        [2:0]    rfread0_up_Decoder_RS2TYPE;
  reg        [2:0]    rfread0_up_Decoder_RS1TYPE;
  reg        [63:0]   rfread0_down_SrcPlugin_IMMED;
  reg        [63:0]   rfread0_down_SrcPlugin_RS2;
  reg        [63:0]   rfread0_down_SrcPlugin_RS1;
  reg        [2:0]    rfread0_up_Decoder_IMMSEL;
  wire                rfread0_up_isValid;
  wire       [31:0]   rfread0_down_Decoder_INSTRUCTION;
  reg                 _zz_d0_haltRequest_scheduler_l91;
  reg        [1:0]    wbStage_up_Decoder_RDTYPE;
  wire       [4:0]    wbStage_down_Decoder_RD;
  reg        [1:0]    E1_up_Decoder_RDTYPE;
  wire       [4:0]    E1_down_Decoder_RD;
  reg        [1:0]    rfread0_up_Decoder_RDTYPE;
  wire       [4:0]    rfread0_down_Decoder_RD;
  reg        [1:0]    dis0_up_Decoder_RDTYPE;
  wire       [4:0]    dis0_down_Decoder_RD;
  reg        [63:0]   rfread0_down_IntRegFile_RegFile_RS2;
  reg        [63:0]   rfread0_down_IntRegFile_RegFile_RS1;
  wire       [4:0]    rfread0_down_Decoder_RS2;
  wire       [4:0]    rfread0_down_Decoder_RS1;
  wire       [2:0]    rfread0_down_Decoder_RS2TYPE;
  wire       [2:0]    rfread0_down_Decoder_RS1TYPE;
  wire                dis0_up_isValid;
  reg        [2:0]    dis0_up_Decoder_EXECUTION_UNIT;
  reg                 dis0_down_Dispatch_SENDTOBRANCH;
  reg                 dis0_down_Dispatch_SENDTOALU;
  wire       [4:0]    d0_down_Decoder_RS2;
  wire       [4:0]    d0_down_Decoder_RS1;
  wire       [4:0]    d0_down_Decoder_RD;
  reg        [0:0]    d0_down_Decoder_IS_W;
  reg        [0:0]    d0_down_Decoder_IS_BR;
  reg        [4:0]    d0_down_Decoder_ALUOP;
  reg        [2:0]    d0_down_Decoder_IMMSEL;
  reg        [0:0]    d0_down_Decoder_FSR3EN;
  reg        [2:0]    d0_down_Decoder_RS2TYPE;
  reg        [2:0]    d0_down_Decoder_RS1TYPE;
  reg        [1:0]    d0_down_Decoder_RDTYPE;
  reg        [2:0]    d0_down_Decoder_EXECUTION_UNIT;
  reg        [0:0]    d0_down_Decoder_IS_FP;
  reg        [31:0]   d0_up_Decoder_INSTRUCTION;
  wire                d0_up_isFiring;
  reg        [0:0]    d0_down_Decoder_LEGAL;
  wire       [31:0]   d0_down_Decoder_INSTRUCTION;
  wire       [31:0]   fetch_down_Decoder_INSTRUCTION;
  wire       [5:0]    fetch_down_PC;
  wire                fetch_up_isFiring;
  wire                fetch_up_valid;
  wire       [5:0]    fetch_up_PC;
  wire       [63:0]   jumpTarget;
  wire                doJump;
  reg        [5:0]    fetcher_pcReg;
  wire                fetch_haltRequest_nebulainorder_l81;
  wire       [31:0]   fetcher_instrn;
  wire                decoder_trap_shouldHalt;
  wire       [0:0]    _zz_d0_down_Decoder_LEGAL;
  wire       [0:0]    _zz_d0_down_Decoder_LEGAL_1;
  wire       [0:0]    _zz_d0_down_Decoder_LEGAL_2;
  wire                _zz_d0_down_Decoder_FSR3EN;
  wire       [0:0]    _zz_d0_down_Decoder_IS_FP;
  wire       [0:0]    _zz_d0_down_Decoder_IS_FP_1;
  wire       [0:0]    _zz_d0_down_Decoder_IS_FP_2;
  wire                _zz_d0_down_Decoder_IS_W;
  wire       [2:0]    _zz_d0_down_Decoder_EXECUTION_UNIT;
  wire       [2:0]    _zz_d0_down_Decoder_EXECUTION_UNIT_1;
  wire       [2:0]    _zz_d0_down_Decoder_EXECUTION_UNIT_2;
  wire                _zz_d0_down_Decoder_IMMSEL;
  wire       [1:0]    _zz_d0_down_Decoder_RDTYPE;
  wire       [1:0]    _zz_d0_down_Decoder_RDTYPE_1;
  wire       [1:0]    _zz_d0_down_Decoder_RDTYPE_2;
  wire       [2:0]    _zz_d0_down_Decoder_RS1TYPE;
  wire       [2:0]    _zz_d0_down_Decoder_RS1TYPE_1;
  wire       [2:0]    _zz_d0_down_Decoder_RS1TYPE_2;
  wire                _zz_d0_down_Decoder_ALUOP;
  wire                _zz_d0_down_Decoder_IMMSEL_1;
  wire       [2:0]    _zz_d0_down_Decoder_RS2TYPE;
  wire       [2:0]    _zz_d0_down_Decoder_RS2TYPE_1;
  wire       [2:0]    _zz_d0_down_Decoder_RS2TYPE_2;
  wire       [0:0]    _zz_d0_down_Decoder_FSR3EN_1;
  wire       [0:0]    _zz_d0_down_Decoder_FSR3EN_2;
  wire       [0:0]    _zz_d0_down_Decoder_FSR3EN_3;
  wire                _zz_d0_down_Decoder_ALUOP_1;
  wire       [2:0]    _zz_d0_down_Decoder_IMMSEL_2;
  wire       [2:0]    _zz_d0_down_Decoder_IMMSEL_3;
  wire       [2:0]    _zz_d0_down_Decoder_IMMSEL_4;
  wire                _zz_d0_down_Decoder_ALUOP_2;
  wire                _zz_d0_down_Decoder_ALUOP_3;
  wire                _zz_d0_down_Decoder_ALUOP_4;
  wire       [4:0]    _zz_d0_down_Decoder_ALUOP_5;
  wire       [4:0]    _zz_d0_down_Decoder_ALUOP_6;
  wire       [4:0]    _zz_d0_down_Decoder_ALUOP_7;
  wire       [0:0]    _zz_d0_down_Decoder_IS_BR;
  wire       [0:0]    _zz_d0_down_Decoder_IS_BR_1;
  wire       [0:0]    _zz_d0_down_Decoder_IS_BR_2;
  wire       [0:0]    _zz_d0_down_Decoder_IS_W_1;
  wire       [0:0]    _zz_d0_down_Decoder_IS_W_2;
  wire       [0:0]    _zz_d0_down_Decoder_IS_W_3;
  wire                when_scheduler_l134;
  wire                when_scheduler_l137;
  wire       [4:0]    intregFile_io_RD_address;
  wire                intregFile_io_RD_Enable;
  wire       [63:0]   intregFile_io_RD_data;
  wire                intregFile_reggy_accessIntRfRS1;
  wire                intregFile_reggy_accessIntRfRS2;
  wire       [4:0]    _zz_intregFile_reggy_readRS1;
  wire       [63:0]   intregFile_reggy_readRS1;
  wire       [4:0]    _zz_intregFile_reggy_readRS2;
  wire       [63:0]   intregFile_reggy_readRS2;
  wire                hazardChecker_isRs1Haz_0;
  wire                hazardChecker_isRs1Haz_1;
  wire                hazardChecker_isRs1Haz_2;
  wire                hazardChecker_isRs1Haz_3;
  wire                _zz_d0_haltRequest_scheduler_l77;
  wire                d0_haltRequest_scheduler_l77;
  wire                hazardChecker_isRs2Haz_0;
  wire                hazardChecker_isRs2Haz_1;
  wire                hazardChecker_isRs2Haz_2;
  wire                hazardChecker_isRs2Haz_3;
  wire                when_scheduler_l90;
  wire                d0_haltRequest_scheduler_l91;
  reg        [63:0]   srcPlugin_immsel_sext;
  wire       [63:0]   srcPlugin_immsel_imm_u_sext_pub;
  wire       [63:0]   _zz_srcPlugin_immsel_imm_u_sext_pub;
  wire       [63:0]   _zz_srcPlugin_immsel_sext;
  reg        [63:0]   _zz_srcPlugin_immsel_sext_1;
  wire                srcPlugin_immsel_is3src;
  reg                 _zz_srcPlugin_immsel_is3src;
  reg        [63:0]   _zz_rfread0_down_SrcPlugin_RS1;
  wire                when_SrcPlugin_l79;
  reg        [63:0]   _zz_rfread0_down_SrcPlugin_RS2;
  reg        [63:0]   executePipeline_intalu_aluNodeStage_result;
  wire                when_IntAlu_l25;
  reg        [63:0]   _zz_executePipeline_intalu_aluNodeStage_result;
  wire                when_IntAlu_l46;
  wire                when_IntAlu_l51;
  wire                when_IntAlu_l58;
  reg                 executePipeline_jal_jumpLocation_valid;
  reg        [63:0]   executePipeline_jal_jumpLocation_payload_address;
  wire                executePipeline_jal_logic_validJump;
  wire                when_branch_l92;
  reg        [4:0]    wb_io_RD_address;
  reg                 wb_io_RD_Enable;
  reg        [63:0]   wb_io_RD_data;
  reg        [31:0]   wb_instrReg;
  wire                when_CtrlLink_l150;
  wire                when_CtrlLink_l150_1;
  wire                when_StageLink_l67;
  `ifndef SYNTHESIS
  reg [47:0] E1_down_Decoder_RDTYPE_string;
  reg [7:0] rfread0_up_Decoder_IS_W_string;
  reg [7:0] rfread0_down_Decoder_IS_W_string;
  reg [39:0] rfread0_up_Decoder_ALUOP_string;
  reg [39:0] rfread0_down_Decoder_ALUOP_string;
  reg [47:0] rfread0_down_Decoder_RDTYPE_string;
  reg [7:0] dis0_up_Decoder_IS_W_string;
  reg [7:0] dis0_down_Decoder_IS_W_string;
  reg [39:0] dis0_up_Decoder_ALUOP_string;
  reg [39:0] dis0_down_Decoder_ALUOP_string;
  reg [39:0] dis0_up_Decoder_IMMSEL_string;
  reg [39:0] dis0_down_Decoder_IMMSEL_string;
  reg [47:0] dis0_up_Decoder_RS2TYPE_string;
  reg [47:0] dis0_down_Decoder_RS2TYPE_string;
  reg [47:0] dis0_up_Decoder_RS1TYPE_string;
  reg [47:0] dis0_down_Decoder_RS1TYPE_string;
  reg [47:0] dis0_down_Decoder_RDTYPE_string;
  reg [7:0] E1_up_Decoder_IS_W_string;
  reg [39:0] E1_up_Decoder_ALUOP_string;
  reg [47:0] rfread0_up_Decoder_RS2TYPE_string;
  reg [47:0] rfread0_up_Decoder_RS1TYPE_string;
  reg [39:0] rfread0_up_Decoder_IMMSEL_string;
  reg [47:0] wbStage_up_Decoder_RDTYPE_string;
  reg [47:0] E1_up_Decoder_RDTYPE_string;
  reg [47:0] rfread0_up_Decoder_RDTYPE_string;
  reg [47:0] dis0_up_Decoder_RDTYPE_string;
  reg [47:0] rfread0_down_Decoder_RS2TYPE_string;
  reg [47:0] rfread0_down_Decoder_RS1TYPE_string;
  reg [23:0] dis0_up_Decoder_EXECUTION_UNIT_string;
  reg [7:0] d0_down_Decoder_IS_W_string;
  reg [7:0] d0_down_Decoder_IS_BR_string;
  reg [39:0] d0_down_Decoder_ALUOP_string;
  reg [39:0] d0_down_Decoder_IMMSEL_string;
  reg [7:0] d0_down_Decoder_FSR3EN_string;
  reg [47:0] d0_down_Decoder_RS2TYPE_string;
  reg [47:0] d0_down_Decoder_RS1TYPE_string;
  reg [47:0] d0_down_Decoder_RDTYPE_string;
  reg [23:0] d0_down_Decoder_EXECUTION_UNIT_string;
  reg [7:0] d0_down_Decoder_IS_FP_string;
  reg [7:0] d0_down_Decoder_LEGAL_string;
  reg [7:0] _zz_d0_down_Decoder_LEGAL_string;
  reg [7:0] _zz_d0_down_Decoder_LEGAL_1_string;
  reg [7:0] _zz_d0_down_Decoder_LEGAL_2_string;
  reg [7:0] _zz_d0_down_Decoder_IS_FP_string;
  reg [7:0] _zz_d0_down_Decoder_IS_FP_1_string;
  reg [7:0] _zz_d0_down_Decoder_IS_FP_2_string;
  reg [23:0] _zz_d0_down_Decoder_EXECUTION_UNIT_string;
  reg [23:0] _zz_d0_down_Decoder_EXECUTION_UNIT_1_string;
  reg [23:0] _zz_d0_down_Decoder_EXECUTION_UNIT_2_string;
  reg [47:0] _zz_d0_down_Decoder_RDTYPE_string;
  reg [47:0] _zz_d0_down_Decoder_RDTYPE_1_string;
  reg [47:0] _zz_d0_down_Decoder_RDTYPE_2_string;
  reg [47:0] _zz_d0_down_Decoder_RS1TYPE_string;
  reg [47:0] _zz_d0_down_Decoder_RS1TYPE_1_string;
  reg [47:0] _zz_d0_down_Decoder_RS1TYPE_2_string;
  reg [47:0] _zz_d0_down_Decoder_RS2TYPE_string;
  reg [47:0] _zz_d0_down_Decoder_RS2TYPE_1_string;
  reg [47:0] _zz_d0_down_Decoder_RS2TYPE_2_string;
  reg [7:0] _zz_d0_down_Decoder_FSR3EN_1_string;
  reg [7:0] _zz_d0_down_Decoder_FSR3EN_2_string;
  reg [7:0] _zz_d0_down_Decoder_FSR3EN_3_string;
  reg [39:0] _zz_d0_down_Decoder_IMMSEL_2_string;
  reg [39:0] _zz_d0_down_Decoder_IMMSEL_3_string;
  reg [39:0] _zz_d0_down_Decoder_IMMSEL_4_string;
  reg [39:0] _zz_d0_down_Decoder_ALUOP_5_string;
  reg [39:0] _zz_d0_down_Decoder_ALUOP_6_string;
  reg [39:0] _zz_d0_down_Decoder_ALUOP_7_string;
  reg [7:0] _zz_d0_down_Decoder_IS_BR_string;
  reg [7:0] _zz_d0_down_Decoder_IS_BR_1_string;
  reg [7:0] _zz_d0_down_Decoder_IS_BR_2_string;
  reg [7:0] _zz_d0_down_Decoder_IS_W_1_string;
  reg [7:0] _zz_d0_down_Decoder_IS_W_2_string;
  reg [7:0] _zz_d0_down_Decoder_IS_W_3_string;
  `endif

  reg [31:0] fetcher_mem [0:63];
  (* ram_style = "distributed" *) reg [63:0] intregFile_reggy_mem [0:31];

  assign _zz_decoder_trap_shouldHalt = (|((d0_down_Decoder_INSTRUCTION & 32'h0) == 32'h0));
  assign _zz__zz_srcPlugin_immsel_imm_u_sext_pub = {rfread0_down_Decoder_INSTRUCTION[31 : 12],12'h0};
  assign _zz__zz_srcPlugin_immsel_sext = {rfread0_down_Decoder_INSTRUCTION[31 : 12],12'h0};
  assign _zz__zz_srcPlugin_immsel_sext_1 = rfread0_down_Decoder_INSTRUCTION[31 : 20];
  assign _zz__zz_srcPlugin_immsel_sext_1_1 = {rfread0_down_Decoder_INSTRUCTION[31 : 25],rfread0_down_Decoder_INSTRUCTION[11 : 7]};
  assign _zz__zz_srcPlugin_immsel_sext_1_2 = {{{{rfread0_down_Decoder_INSTRUCTION[31],rfread0_down_Decoder_INSTRUCTION[7]},rfread0_down_Decoder_INSTRUCTION[30 : 25]},rfread0_down_Decoder_INSTRUCTION[11 : 8]},1'b0};
  assign _zz__zz_srcPlugin_immsel_sext_1_3 = {{{{rfread0_down_Decoder_INSTRUCTION[31],rfread0_down_Decoder_INSTRUCTION[19 : 12]},rfread0_down_Decoder_INSTRUCTION[20]},rfread0_down_Decoder_INSTRUCTION[30 : 21]},1'b0};
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result = ($signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_1) + $signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_2));
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_1 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_2 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_3 = (E1_down_SrcPlugin_RS1 <<< E1_down_SrcPlugin_RS2[6 : 0]);
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_4 = (E1_down_SrcPlugin_RS1 >>> E1_down_SrcPlugin_RS2[6 : 0]);
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_5 = (E1_down_SrcPlugin_RS1 >>> E1_down_SrcPlugin_RS2[6 : 0]);
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_6 = ($signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_7) - $signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_8));
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_7 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_8 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_10 = _zz__zz_executePipeline_intalu_aluNodeStage_result_11[31 : 0];
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_9 = {{32{_zz__zz_executePipeline_intalu_aluNodeStage_result_10[31]}}, _zz__zz_executePipeline_intalu_aluNodeStage_result_10};
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_11 = ($signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_12) + $signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_13));
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_12 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_13 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_15 = _zz__zz_executePipeline_intalu_aluNodeStage_result_16[31 : 0];
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_14 = {32'd0, _zz__zz_executePipeline_intalu_aluNodeStage_result_15};
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_16 = (E1_down_SrcPlugin_RS1 <<< E1_down_SrcPlugin_RS2[4 : 0]);
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_18 = _zz__zz_executePipeline_intalu_aluNodeStage_result_19[31 : 0];
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_17 = {32'd0, _zz__zz_executePipeline_intalu_aluNodeStage_result_18};
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_19 = (E1_down_SrcPlugin_RS1 >>> E1_down_SrcPlugin_RS2[4 : 0]);
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_21 = _zz__zz_executePipeline_intalu_aluNodeStage_result_22[31 : 0];
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_20 = {32'd0, _zz__zz_executePipeline_intalu_aluNodeStage_result_21};
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_22 = (E1_down_SrcPlugin_RS1 >>> E1_down_SrcPlugin_RS2[4 : 0]);
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_24 = _zz__zz_executePipeline_intalu_aluNodeStage_result_25[31 : 0];
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_23 = {{32{_zz__zz_executePipeline_intalu_aluNodeStage_result_24[31]}}, _zz__zz_executePipeline_intalu_aluNodeStage_result_24};
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_25 = ($signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_26) - $signed(_zz__zz_executePipeline_intalu_aluNodeStage_result_27));
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_26 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_executePipeline_intalu_aluNodeStage_result_27 = E1_down_SrcPlugin_RS2;
  assign _zz_executePipeline_intalu_aluNodeStage_result_1 = ($signed(_zz_executePipeline_intalu_aluNodeStage_result_2) < $signed(_zz_executePipeline_intalu_aluNodeStage_result_3));
  assign _zz_executePipeline_intalu_aluNodeStage_result_2 = E1_down_SrcPlugin_RS1;
  assign _zz_executePipeline_intalu_aluNodeStage_result_3 = E1_down_SrcPlugin_RS2;
  assign _zz_executePipeline_intalu_aluNodeStage_result_4 = (E1_down_SrcPlugin_RS1 < E1_down_SrcPlugin_RS2);
  assign _zz_E1_down_Execute_RESULT = executePipeline_intalu_aluNodeStage_result[31 : 0];
  assign _zz_intregFile_reggy_mem_port = (intregFile_io_RD_Enable && (! (intregFile_io_RD_address == 5'h0)));
  assign _zz__zz_d0_down_Decoder_ALUOP_6 = (d0_up_Decoder_INSTRUCTION & 32'h40004028);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_1 = 32'h40000028;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_2 = _zz_d0_down_Decoder_ALUOP;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_3 = {(_zz__zz_d0_down_Decoder_ALUOP_6_4 == _zz__zz_d0_down_Decoder_ALUOP_6_5),{_zz_d0_down_Decoder_ALUOP_2,{_zz__zz_d0_down_Decoder_ALUOP_6_6,_zz__zz_d0_down_Decoder_ALUOP_6_7}}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_10 = _zz_d0_down_Decoder_ALUOP_4;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_11 = {_zz_d0_down_Decoder_ALUOP_3,{_zz__zz_d0_down_Decoder_ALUOP_6_12,{_zz__zz_d0_down_Decoder_ALUOP_6_14,_zz__zz_d0_down_Decoder_ALUOP_6_17}}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_26 = {_zz_d0_down_Decoder_ALUOP,{_zz_d0_down_Decoder_ALUOP_2,{_zz__zz_d0_down_Decoder_ALUOP_6_27,_zz__zz_d0_down_Decoder_ALUOP_6_30}}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_39 = {_zz_d0_down_Decoder_ALUOP_1,{_zz_d0_down_Decoder_ALUOP,{_zz__zz_d0_down_Decoder_ALUOP_6_40,_zz__zz_d0_down_Decoder_ALUOP_6_43}}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_4 = (d0_up_Decoder_INSTRUCTION & 32'h00003040);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_5 = 32'h00003000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_6 = _zz_d0_down_Decoder_ALUOP_3;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_7 = (_zz__zz_d0_down_Decoder_ALUOP_6_8 == _zz__zz_d0_down_Decoder_ALUOP_6_9);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_12 = ((d0_up_Decoder_INSTRUCTION & _zz__zz_d0_down_Decoder_ALUOP_6_13) == 32'h00001000);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_14 = (_zz__zz_d0_down_Decoder_ALUOP_6_15 == _zz__zz_d0_down_Decoder_ALUOP_6_16);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_17 = {_zz__zz_d0_down_Decoder_ALUOP_6_18,{_zz__zz_d0_down_Decoder_ALUOP_6_20,_zz__zz_d0_down_Decoder_ALUOP_6_23}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_27 = (_zz__zz_d0_down_Decoder_ALUOP_6_28 == _zz__zz_d0_down_Decoder_ALUOP_6_29);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_30 = {_zz__zz_d0_down_Decoder_ALUOP_6_31,{_zz__zz_d0_down_Decoder_ALUOP_6_33,_zz__zz_d0_down_Decoder_ALUOP_6_36}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_40 = (_zz__zz_d0_down_Decoder_ALUOP_6_41 == _zz__zz_d0_down_Decoder_ALUOP_6_42);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_43 = {_zz__zz_d0_down_Decoder_ALUOP_6_44,{_zz__zz_d0_down_Decoder_ALUOP_6_46,_zz__zz_d0_down_Decoder_ALUOP_6_49}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_8 = (d0_up_Decoder_INSTRUCTION & 32'h00003018);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_9 = 32'h00002000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_13 = 32'h00001018;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_15 = (d0_up_Decoder_INSTRUCTION & 32'h40006004);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_16 = 32'h40004000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_18 = ((d0_up_Decoder_INSTRUCTION & _zz__zz_d0_down_Decoder_ALUOP_6_19) == 32'h00002000);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_20 = (_zz__zz_d0_down_Decoder_ALUOP_6_21 == _zz__zz_d0_down_Decoder_ALUOP_6_22);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_23 = (_zz__zz_d0_down_Decoder_ALUOP_6_24 == _zz__zz_d0_down_Decoder_ALUOP_6_25);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_28 = (d0_up_Decoder_INSTRUCTION & 32'h00003018);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_29 = 32'h00003000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_31 = ((d0_up_Decoder_INSTRUCTION & _zz__zz_d0_down_Decoder_ALUOP_6_32) == 32'h00002000);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_33 = (_zz__zz_d0_down_Decoder_ALUOP_6_34 == _zz__zz_d0_down_Decoder_ALUOP_6_35);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_36 = {_zz__zz_d0_down_Decoder_ALUOP_6_37,_zz__zz_d0_down_Decoder_ALUOP_6_38};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_41 = (d0_up_Decoder_INSTRUCTION & 32'h00006040);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_42 = 32'h00006000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_44 = ((d0_up_Decoder_INSTRUCTION & _zz__zz_d0_down_Decoder_ALUOP_6_45) == 32'h00001008);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_46 = (_zz__zz_d0_down_Decoder_ALUOP_6_47 == _zz__zz_d0_down_Decoder_ALUOP_6_48);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_49 = {_zz__zz_d0_down_Decoder_ALUOP_6_50,{_zz__zz_d0_down_Decoder_ALUOP_6_51,_zz__zz_d0_down_Decoder_ALUOP_6_52}};
  assign _zz__zz_d0_down_Decoder_ALUOP_6_19 = 32'h00003044;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_21 = (d0_up_Decoder_INSTRUCTION & 32'h00006018);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_22 = 32'h00004000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_24 = (d0_up_Decoder_INSTRUCTION & 32'h00005044);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_25 = 32'h00004000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_32 = 32'h00007040;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_34 = (d0_up_Decoder_INSTRUCTION & 32'h00007040);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_35 = 32'h00004000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_37 = ((d0_up_Decoder_INSTRUCTION & 32'h00003018) == 32'h0);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_38 = ((d0_up_Decoder_INSTRUCTION & 32'h40003048) == 32'h00001000);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_45 = 32'h40001008;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_47 = (d0_up_Decoder_INSTRUCTION & 32'h00006010);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_48 = 32'h00004000;
  assign _zz__zz_d0_down_Decoder_ALUOP_6_50 = ((d0_up_Decoder_INSTRUCTION & 32'h00003040) == 32'h00002000);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_51 = ((d0_up_Decoder_INSTRUCTION & 32'h40005040) == 32'h00005000);
  assign _zz__zz_d0_down_Decoder_ALUOP_6_52 = {((d0_up_Decoder_INSTRUCTION & 32'h00003014) == 32'h0),((d0_up_Decoder_INSTRUCTION & 32'h40004068) == 32'h40000020)};
  initial begin
    $readmemb("nebulaRVIO.v_toplevel_fetcher_mem.bin",fetcher_mem);
  end
  assign fetcher_mem_spinal_port0 = fetcher_mem[fetch_down_PC];
  assign fetcher_mem_spinal_port1 = fetcher_mem[fetch_down_PC];
  initial begin
    $readmemb("nebulaRVIO.v_toplevel_intregFile_reggy_mem.bin",intregFile_reggy_mem);
  end
  assign intregFile_reggy_mem_spinal_port0 = intregFile_reggy_mem[_zz_intregFile_reggy_readRS1];
  assign intregFile_reggy_mem_spinal_port1 = intregFile_reggy_mem[_zz_intregFile_reggy_readRS2];
  always @(posedge clk) begin
    if(_zz_intregFile_reggy_mem_port) begin
      intregFile_reggy_mem[intregFile_io_RD_address] <= intregFile_io_RD_data;
    end
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(E1_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : E1_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : E1_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : E1_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : E1_down_Decoder_RDTYPE_string = "RD_NA ";
      default : E1_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(rfread0_up_Decoder_IS_W)
      YESNO_Y : rfread0_up_Decoder_IS_W_string = "Y";
      YESNO_N : rfread0_up_Decoder_IS_W_string = "N";
      default : rfread0_up_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(rfread0_down_Decoder_IS_W)
      YESNO_Y : rfread0_down_Decoder_IS_W_string = "Y";
      YESNO_N : rfread0_down_Decoder_IS_W_string = "N";
      default : rfread0_down_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(rfread0_up_Decoder_ALUOP)
      AluOp_add : rfread0_up_Decoder_ALUOP_string = "add  ";
      AluOp_sub : rfread0_up_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : rfread0_up_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : rfread0_up_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : rfread0_up_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : rfread0_up_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : rfread0_up_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : rfread0_up_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : rfread0_up_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : rfread0_up_Decoder_ALUOP_string = "and_1";
      AluOp_na : rfread0_up_Decoder_ALUOP_string = "na   ";
      AluOp_lui : rfread0_up_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : rfread0_up_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : rfread0_up_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : rfread0_up_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : rfread0_up_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : rfread0_up_Decoder_ALUOP_string = "subw ";
      AluOp_jal : rfread0_up_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : rfread0_up_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : rfread0_up_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : rfread0_up_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : rfread0_up_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : rfread0_up_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : rfread0_up_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : rfread0_up_Decoder_ALUOP_string = "bltu ";
      default : rfread0_up_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(rfread0_down_Decoder_ALUOP)
      AluOp_add : rfread0_down_Decoder_ALUOP_string = "add  ";
      AluOp_sub : rfread0_down_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : rfread0_down_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : rfread0_down_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : rfread0_down_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : rfread0_down_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : rfread0_down_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : rfread0_down_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : rfread0_down_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : rfread0_down_Decoder_ALUOP_string = "and_1";
      AluOp_na : rfread0_down_Decoder_ALUOP_string = "na   ";
      AluOp_lui : rfread0_down_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : rfread0_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : rfread0_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : rfread0_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : rfread0_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : rfread0_down_Decoder_ALUOP_string = "subw ";
      AluOp_jal : rfread0_down_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : rfread0_down_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : rfread0_down_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : rfread0_down_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : rfread0_down_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : rfread0_down_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : rfread0_down_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : rfread0_down_Decoder_ALUOP_string = "bltu ";
      default : rfread0_down_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(rfread0_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : rfread0_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : rfread0_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : rfread0_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : rfread0_down_Decoder_RDTYPE_string = "RD_NA ";
      default : rfread0_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_IS_W)
      YESNO_Y : dis0_up_Decoder_IS_W_string = "Y";
      YESNO_N : dis0_up_Decoder_IS_W_string = "N";
      default : dis0_up_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_IS_W)
      YESNO_Y : dis0_down_Decoder_IS_W_string = "Y";
      YESNO_N : dis0_down_Decoder_IS_W_string = "N";
      default : dis0_down_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_ALUOP)
      AluOp_add : dis0_up_Decoder_ALUOP_string = "add  ";
      AluOp_sub : dis0_up_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : dis0_up_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : dis0_up_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : dis0_up_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : dis0_up_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : dis0_up_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : dis0_up_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : dis0_up_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : dis0_up_Decoder_ALUOP_string = "and_1";
      AluOp_na : dis0_up_Decoder_ALUOP_string = "na   ";
      AluOp_lui : dis0_up_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : dis0_up_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : dis0_up_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : dis0_up_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : dis0_up_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : dis0_up_Decoder_ALUOP_string = "subw ";
      AluOp_jal : dis0_up_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : dis0_up_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : dis0_up_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : dis0_up_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : dis0_up_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : dis0_up_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : dis0_up_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : dis0_up_Decoder_ALUOP_string = "bltu ";
      default : dis0_up_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_ALUOP)
      AluOp_add : dis0_down_Decoder_ALUOP_string = "add  ";
      AluOp_sub : dis0_down_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : dis0_down_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : dis0_down_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : dis0_down_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : dis0_down_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : dis0_down_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : dis0_down_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : dis0_down_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : dis0_down_Decoder_ALUOP_string = "and_1";
      AluOp_na : dis0_down_Decoder_ALUOP_string = "na   ";
      AluOp_lui : dis0_down_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : dis0_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : dis0_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : dis0_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : dis0_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : dis0_down_Decoder_ALUOP_string = "subw ";
      AluOp_jal : dis0_down_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : dis0_down_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : dis0_down_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : dis0_down_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : dis0_down_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : dis0_down_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : dis0_down_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : dis0_down_Decoder_ALUOP_string = "bltu ";
      default : dis0_down_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_IMMSEL)
      Imm_Select_N_IMM : dis0_up_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_I_IMM : dis0_up_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : dis0_up_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_B_IMM : dis0_up_Decoder_IMMSEL_string = "B_IMM";
      Imm_Select_U_IMM : dis0_up_Decoder_IMMSEL_string = "U_IMM";
      Imm_Select_J_IMM : dis0_up_Decoder_IMMSEL_string = "J_IMM";
      default : dis0_up_Decoder_IMMSEL_string = "?????";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_IMMSEL)
      Imm_Select_N_IMM : dis0_down_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_I_IMM : dis0_down_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : dis0_down_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_B_IMM : dis0_down_Decoder_IMMSEL_string = "B_IMM";
      Imm_Select_U_IMM : dis0_down_Decoder_IMMSEL_string = "U_IMM";
      Imm_Select_J_IMM : dis0_down_Decoder_IMMSEL_string = "J_IMM";
      default : dis0_down_Decoder_IMMSEL_string = "?????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_RS2TYPE)
      RSTYPE_RS_INT : dis0_up_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : dis0_up_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : dis0_up_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : dis0_up_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : dis0_up_Decoder_RS2TYPE_string = "RS_NA ";
      default : dis0_up_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_RS2TYPE)
      RSTYPE_RS_INT : dis0_down_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : dis0_down_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : dis0_down_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : dis0_down_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : dis0_down_Decoder_RS2TYPE_string = "RS_NA ";
      default : dis0_down_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_RS1TYPE)
      RSTYPE_RS_INT : dis0_up_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : dis0_up_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : dis0_up_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : dis0_up_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : dis0_up_Decoder_RS1TYPE_string = "RS_NA ";
      default : dis0_up_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_RS1TYPE)
      RSTYPE_RS_INT : dis0_down_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : dis0_down_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : dis0_down_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : dis0_down_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : dis0_down_Decoder_RS1TYPE_string = "RS_NA ";
      default : dis0_down_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : dis0_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : dis0_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : dis0_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : dis0_down_Decoder_RDTYPE_string = "RD_NA ";
      default : dis0_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(E1_up_Decoder_IS_W)
      YESNO_Y : E1_up_Decoder_IS_W_string = "Y";
      YESNO_N : E1_up_Decoder_IS_W_string = "N";
      default : E1_up_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(E1_up_Decoder_ALUOP)
      AluOp_add : E1_up_Decoder_ALUOP_string = "add  ";
      AluOp_sub : E1_up_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : E1_up_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : E1_up_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : E1_up_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : E1_up_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : E1_up_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : E1_up_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : E1_up_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : E1_up_Decoder_ALUOP_string = "and_1";
      AluOp_na : E1_up_Decoder_ALUOP_string = "na   ";
      AluOp_lui : E1_up_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : E1_up_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : E1_up_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : E1_up_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : E1_up_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : E1_up_Decoder_ALUOP_string = "subw ";
      AluOp_jal : E1_up_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : E1_up_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : E1_up_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : E1_up_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : E1_up_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : E1_up_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : E1_up_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : E1_up_Decoder_ALUOP_string = "bltu ";
      default : E1_up_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(rfread0_up_Decoder_RS2TYPE)
      RSTYPE_RS_INT : rfread0_up_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : rfread0_up_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : rfread0_up_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : rfread0_up_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : rfread0_up_Decoder_RS2TYPE_string = "RS_NA ";
      default : rfread0_up_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(rfread0_up_Decoder_RS1TYPE)
      RSTYPE_RS_INT : rfread0_up_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : rfread0_up_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : rfread0_up_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : rfread0_up_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : rfread0_up_Decoder_RS1TYPE_string = "RS_NA ";
      default : rfread0_up_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(rfread0_up_Decoder_IMMSEL)
      Imm_Select_N_IMM : rfread0_up_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_I_IMM : rfread0_up_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : rfread0_up_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_B_IMM : rfread0_up_Decoder_IMMSEL_string = "B_IMM";
      Imm_Select_U_IMM : rfread0_up_Decoder_IMMSEL_string = "U_IMM";
      Imm_Select_J_IMM : rfread0_up_Decoder_IMMSEL_string = "J_IMM";
      default : rfread0_up_Decoder_IMMSEL_string = "?????";
    endcase
  end
  always @(*) begin
    case(wbStage_up_Decoder_RDTYPE)
      RDTYPE_RD_INT : wbStage_up_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : wbStage_up_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : wbStage_up_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : wbStage_up_Decoder_RDTYPE_string = "RD_NA ";
      default : wbStage_up_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(E1_up_Decoder_RDTYPE)
      RDTYPE_RD_INT : E1_up_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : E1_up_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : E1_up_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : E1_up_Decoder_RDTYPE_string = "RD_NA ";
      default : E1_up_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(rfread0_up_Decoder_RDTYPE)
      RDTYPE_RD_INT : rfread0_up_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : rfread0_up_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : rfread0_up_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : rfread0_up_Decoder_RDTYPE_string = "RD_NA ";
      default : rfread0_up_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_RDTYPE)
      RDTYPE_RD_INT : dis0_up_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : dis0_up_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : dis0_up_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : dis0_up_Decoder_RDTYPE_string = "RD_NA ";
      default : dis0_up_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(rfread0_down_Decoder_RS2TYPE)
      RSTYPE_RS_INT : rfread0_down_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : rfread0_down_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : rfread0_down_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : rfread0_down_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : rfread0_down_Decoder_RS2TYPE_string = "RS_NA ";
      default : rfread0_down_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(rfread0_down_Decoder_RS1TYPE)
      RSTYPE_RS_INT : rfread0_down_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : rfread0_down_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : rfread0_down_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : rfread0_down_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : rfread0_down_Decoder_RS1TYPE_string = "RS_NA ";
      default : rfread0_down_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_EXECUTION_UNIT)
      ExecutionUnit_ALU : dis0_up_Decoder_EXECUTION_UNIT_string = "ALU";
      ExecutionUnit_FPU : dis0_up_Decoder_EXECUTION_UNIT_string = "FPU";
      ExecutionUnit_AGU : dis0_up_Decoder_EXECUTION_UNIT_string = "AGU";
      ExecutionUnit_BR : dis0_up_Decoder_EXECUTION_UNIT_string = "BR ";
      ExecutionUnit_NA : dis0_up_Decoder_EXECUTION_UNIT_string = "NA ";
      default : dis0_up_Decoder_EXECUTION_UNIT_string = "???";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_IS_W)
      YESNO_Y : d0_down_Decoder_IS_W_string = "Y";
      YESNO_N : d0_down_Decoder_IS_W_string = "N";
      default : d0_down_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_IS_BR)
      YESNO_Y : d0_down_Decoder_IS_BR_string = "Y";
      YESNO_N : d0_down_Decoder_IS_BR_string = "N";
      default : d0_down_Decoder_IS_BR_string = "?";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_ALUOP)
      AluOp_add : d0_down_Decoder_ALUOP_string = "add  ";
      AluOp_sub : d0_down_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : d0_down_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : d0_down_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : d0_down_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : d0_down_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : d0_down_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : d0_down_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : d0_down_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : d0_down_Decoder_ALUOP_string = "and_1";
      AluOp_na : d0_down_Decoder_ALUOP_string = "na   ";
      AluOp_lui : d0_down_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : d0_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : d0_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : d0_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : d0_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : d0_down_Decoder_ALUOP_string = "subw ";
      AluOp_jal : d0_down_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : d0_down_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : d0_down_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : d0_down_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : d0_down_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : d0_down_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : d0_down_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : d0_down_Decoder_ALUOP_string = "bltu ";
      default : d0_down_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_IMMSEL)
      Imm_Select_N_IMM : d0_down_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_I_IMM : d0_down_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : d0_down_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_B_IMM : d0_down_Decoder_IMMSEL_string = "B_IMM";
      Imm_Select_U_IMM : d0_down_Decoder_IMMSEL_string = "U_IMM";
      Imm_Select_J_IMM : d0_down_Decoder_IMMSEL_string = "J_IMM";
      default : d0_down_Decoder_IMMSEL_string = "?????";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_FSR3EN)
      YESNO_Y : d0_down_Decoder_FSR3EN_string = "Y";
      YESNO_N : d0_down_Decoder_FSR3EN_string = "N";
      default : d0_down_Decoder_FSR3EN_string = "?";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_RS2TYPE)
      RSTYPE_RS_INT : d0_down_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : d0_down_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : d0_down_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : d0_down_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : d0_down_Decoder_RS2TYPE_string = "RS_NA ";
      default : d0_down_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_RS1TYPE)
      RSTYPE_RS_INT : d0_down_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : d0_down_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : d0_down_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : d0_down_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : d0_down_Decoder_RS1TYPE_string = "RS_NA ";
      default : d0_down_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : d0_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : d0_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : d0_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : d0_down_Decoder_RDTYPE_string = "RD_NA ";
      default : d0_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_EXECUTION_UNIT)
      ExecutionUnit_ALU : d0_down_Decoder_EXECUTION_UNIT_string = "ALU";
      ExecutionUnit_FPU : d0_down_Decoder_EXECUTION_UNIT_string = "FPU";
      ExecutionUnit_AGU : d0_down_Decoder_EXECUTION_UNIT_string = "AGU";
      ExecutionUnit_BR : d0_down_Decoder_EXECUTION_UNIT_string = "BR ";
      ExecutionUnit_NA : d0_down_Decoder_EXECUTION_UNIT_string = "NA ";
      default : d0_down_Decoder_EXECUTION_UNIT_string = "???";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_IS_FP)
      YESNO_Y : d0_down_Decoder_IS_FP_string = "Y";
      YESNO_N : d0_down_Decoder_IS_FP_string = "N";
      default : d0_down_Decoder_IS_FP_string = "?";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_LEGAL)
      YESNO_Y : d0_down_Decoder_LEGAL_string = "Y";
      YESNO_N : d0_down_Decoder_LEGAL_string = "N";
      default : d0_down_Decoder_LEGAL_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_LEGAL)
      YESNO_Y : _zz_d0_down_Decoder_LEGAL_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_LEGAL_string = "N";
      default : _zz_d0_down_Decoder_LEGAL_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_LEGAL_1)
      YESNO_Y : _zz_d0_down_Decoder_LEGAL_1_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_LEGAL_1_string = "N";
      default : _zz_d0_down_Decoder_LEGAL_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_LEGAL_2)
      YESNO_Y : _zz_d0_down_Decoder_LEGAL_2_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_LEGAL_2_string = "N";
      default : _zz_d0_down_Decoder_LEGAL_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_FP)
      YESNO_Y : _zz_d0_down_Decoder_IS_FP_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_FP_string = "N";
      default : _zz_d0_down_Decoder_IS_FP_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_FP_1)
      YESNO_Y : _zz_d0_down_Decoder_IS_FP_1_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_FP_1_string = "N";
      default : _zz_d0_down_Decoder_IS_FP_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_FP_2)
      YESNO_Y : _zz_d0_down_Decoder_IS_FP_2_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_FP_2_string = "N";
      default : _zz_d0_down_Decoder_IS_FP_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_EXECUTION_UNIT)
      ExecutionUnit_ALU : _zz_d0_down_Decoder_EXECUTION_UNIT_string = "ALU";
      ExecutionUnit_FPU : _zz_d0_down_Decoder_EXECUTION_UNIT_string = "FPU";
      ExecutionUnit_AGU : _zz_d0_down_Decoder_EXECUTION_UNIT_string = "AGU";
      ExecutionUnit_BR : _zz_d0_down_Decoder_EXECUTION_UNIT_string = "BR ";
      ExecutionUnit_NA : _zz_d0_down_Decoder_EXECUTION_UNIT_string = "NA ";
      default : _zz_d0_down_Decoder_EXECUTION_UNIT_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_EXECUTION_UNIT_1)
      ExecutionUnit_ALU : _zz_d0_down_Decoder_EXECUTION_UNIT_1_string = "ALU";
      ExecutionUnit_FPU : _zz_d0_down_Decoder_EXECUTION_UNIT_1_string = "FPU";
      ExecutionUnit_AGU : _zz_d0_down_Decoder_EXECUTION_UNIT_1_string = "AGU";
      ExecutionUnit_BR : _zz_d0_down_Decoder_EXECUTION_UNIT_1_string = "BR ";
      ExecutionUnit_NA : _zz_d0_down_Decoder_EXECUTION_UNIT_1_string = "NA ";
      default : _zz_d0_down_Decoder_EXECUTION_UNIT_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_EXECUTION_UNIT_2)
      ExecutionUnit_ALU : _zz_d0_down_Decoder_EXECUTION_UNIT_2_string = "ALU";
      ExecutionUnit_FPU : _zz_d0_down_Decoder_EXECUTION_UNIT_2_string = "FPU";
      ExecutionUnit_AGU : _zz_d0_down_Decoder_EXECUTION_UNIT_2_string = "AGU";
      ExecutionUnit_BR : _zz_d0_down_Decoder_EXECUTION_UNIT_2_string = "BR ";
      ExecutionUnit_NA : _zz_d0_down_Decoder_EXECUTION_UNIT_2_string = "NA ";
      default : _zz_d0_down_Decoder_EXECUTION_UNIT_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : _zz_d0_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : _zz_d0_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_d0_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_d0_down_Decoder_RDTYPE_string = "RD_NA ";
      default : _zz_d0_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RDTYPE_1)
      RDTYPE_RD_INT : _zz_d0_down_Decoder_RDTYPE_1_string = "RD_INT";
      RDTYPE_RD_FP : _zz_d0_down_Decoder_RDTYPE_1_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_d0_down_Decoder_RDTYPE_1_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_d0_down_Decoder_RDTYPE_1_string = "RD_NA ";
      default : _zz_d0_down_Decoder_RDTYPE_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RDTYPE_2)
      RDTYPE_RD_INT : _zz_d0_down_Decoder_RDTYPE_2_string = "RD_INT";
      RDTYPE_RD_FP : _zz_d0_down_Decoder_RDTYPE_2_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_d0_down_Decoder_RDTYPE_2_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_d0_down_Decoder_RDTYPE_2_string = "RD_NA ";
      default : _zz_d0_down_Decoder_RDTYPE_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RS1TYPE)
      RSTYPE_RS_INT : _zz_d0_down_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : _zz_d0_down_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_d0_down_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : _zz_d0_down_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : _zz_d0_down_Decoder_RS1TYPE_string = "RS_NA ";
      default : _zz_d0_down_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RS1TYPE_1)
      RSTYPE_RS_INT : _zz_d0_down_Decoder_RS1TYPE_1_string = "RS_INT";
      RSTYPE_RS_FP : _zz_d0_down_Decoder_RS1TYPE_1_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_d0_down_Decoder_RS1TYPE_1_string = "RS_VEC";
      RSTYPE_IMMED : _zz_d0_down_Decoder_RS1TYPE_1_string = "IMMED ";
      RSTYPE_RS_NA : _zz_d0_down_Decoder_RS1TYPE_1_string = "RS_NA ";
      default : _zz_d0_down_Decoder_RS1TYPE_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RS1TYPE_2)
      RSTYPE_RS_INT : _zz_d0_down_Decoder_RS1TYPE_2_string = "RS_INT";
      RSTYPE_RS_FP : _zz_d0_down_Decoder_RS1TYPE_2_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_d0_down_Decoder_RS1TYPE_2_string = "RS_VEC";
      RSTYPE_IMMED : _zz_d0_down_Decoder_RS1TYPE_2_string = "IMMED ";
      RSTYPE_RS_NA : _zz_d0_down_Decoder_RS1TYPE_2_string = "RS_NA ";
      default : _zz_d0_down_Decoder_RS1TYPE_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RS2TYPE)
      RSTYPE_RS_INT : _zz_d0_down_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : _zz_d0_down_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_d0_down_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : _zz_d0_down_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : _zz_d0_down_Decoder_RS2TYPE_string = "RS_NA ";
      default : _zz_d0_down_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RS2TYPE_1)
      RSTYPE_RS_INT : _zz_d0_down_Decoder_RS2TYPE_1_string = "RS_INT";
      RSTYPE_RS_FP : _zz_d0_down_Decoder_RS2TYPE_1_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_d0_down_Decoder_RS2TYPE_1_string = "RS_VEC";
      RSTYPE_IMMED : _zz_d0_down_Decoder_RS2TYPE_1_string = "IMMED ";
      RSTYPE_RS_NA : _zz_d0_down_Decoder_RS2TYPE_1_string = "RS_NA ";
      default : _zz_d0_down_Decoder_RS2TYPE_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_RS2TYPE_2)
      RSTYPE_RS_INT : _zz_d0_down_Decoder_RS2TYPE_2_string = "RS_INT";
      RSTYPE_RS_FP : _zz_d0_down_Decoder_RS2TYPE_2_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_d0_down_Decoder_RS2TYPE_2_string = "RS_VEC";
      RSTYPE_IMMED : _zz_d0_down_Decoder_RS2TYPE_2_string = "IMMED ";
      RSTYPE_RS_NA : _zz_d0_down_Decoder_RS2TYPE_2_string = "RS_NA ";
      default : _zz_d0_down_Decoder_RS2TYPE_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_FSR3EN_1)
      YESNO_Y : _zz_d0_down_Decoder_FSR3EN_1_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_FSR3EN_1_string = "N";
      default : _zz_d0_down_Decoder_FSR3EN_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_FSR3EN_2)
      YESNO_Y : _zz_d0_down_Decoder_FSR3EN_2_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_FSR3EN_2_string = "N";
      default : _zz_d0_down_Decoder_FSR3EN_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_FSR3EN_3)
      YESNO_Y : _zz_d0_down_Decoder_FSR3EN_3_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_FSR3EN_3_string = "N";
      default : _zz_d0_down_Decoder_FSR3EN_3_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IMMSEL_2)
      Imm_Select_N_IMM : _zz_d0_down_Decoder_IMMSEL_2_string = "N_IMM";
      Imm_Select_I_IMM : _zz_d0_down_Decoder_IMMSEL_2_string = "I_IMM";
      Imm_Select_S_IMM : _zz_d0_down_Decoder_IMMSEL_2_string = "S_IMM";
      Imm_Select_B_IMM : _zz_d0_down_Decoder_IMMSEL_2_string = "B_IMM";
      Imm_Select_U_IMM : _zz_d0_down_Decoder_IMMSEL_2_string = "U_IMM";
      Imm_Select_J_IMM : _zz_d0_down_Decoder_IMMSEL_2_string = "J_IMM";
      default : _zz_d0_down_Decoder_IMMSEL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IMMSEL_3)
      Imm_Select_N_IMM : _zz_d0_down_Decoder_IMMSEL_3_string = "N_IMM";
      Imm_Select_I_IMM : _zz_d0_down_Decoder_IMMSEL_3_string = "I_IMM";
      Imm_Select_S_IMM : _zz_d0_down_Decoder_IMMSEL_3_string = "S_IMM";
      Imm_Select_B_IMM : _zz_d0_down_Decoder_IMMSEL_3_string = "B_IMM";
      Imm_Select_U_IMM : _zz_d0_down_Decoder_IMMSEL_3_string = "U_IMM";
      Imm_Select_J_IMM : _zz_d0_down_Decoder_IMMSEL_3_string = "J_IMM";
      default : _zz_d0_down_Decoder_IMMSEL_3_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IMMSEL_4)
      Imm_Select_N_IMM : _zz_d0_down_Decoder_IMMSEL_4_string = "N_IMM";
      Imm_Select_I_IMM : _zz_d0_down_Decoder_IMMSEL_4_string = "I_IMM";
      Imm_Select_S_IMM : _zz_d0_down_Decoder_IMMSEL_4_string = "S_IMM";
      Imm_Select_B_IMM : _zz_d0_down_Decoder_IMMSEL_4_string = "B_IMM";
      Imm_Select_U_IMM : _zz_d0_down_Decoder_IMMSEL_4_string = "U_IMM";
      Imm_Select_J_IMM : _zz_d0_down_Decoder_IMMSEL_4_string = "J_IMM";
      default : _zz_d0_down_Decoder_IMMSEL_4_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_ALUOP_5)
      AluOp_add : _zz_d0_down_Decoder_ALUOP_5_string = "add  ";
      AluOp_sub : _zz_d0_down_Decoder_ALUOP_5_string = "sub  ";
      AluOp_sll_1 : _zz_d0_down_Decoder_ALUOP_5_string = "sll_1";
      AluOp_srl_1 : _zz_d0_down_Decoder_ALUOP_5_string = "srl_1";
      AluOp_sra_1 : _zz_d0_down_Decoder_ALUOP_5_string = "sra_1";
      AluOp_or_1 : _zz_d0_down_Decoder_ALUOP_5_string = "or_1 ";
      AluOp_xor_1 : _zz_d0_down_Decoder_ALUOP_5_string = "xor_1";
      AluOp_slt : _zz_d0_down_Decoder_ALUOP_5_string = "slt  ";
      AluOp_sltu : _zz_d0_down_Decoder_ALUOP_5_string = "sltu ";
      AluOp_and_1 : _zz_d0_down_Decoder_ALUOP_5_string = "and_1";
      AluOp_na : _zz_d0_down_Decoder_ALUOP_5_string = "na   ";
      AluOp_lui : _zz_d0_down_Decoder_ALUOP_5_string = "lui  ";
      AluOp_addw : _zz_d0_down_Decoder_ALUOP_5_string = "addw ";
      AluOp_sllw : _zz_d0_down_Decoder_ALUOP_5_string = "sllw ";
      AluOp_sraw : _zz_d0_down_Decoder_ALUOP_5_string = "sraw ";
      AluOp_srlw : _zz_d0_down_Decoder_ALUOP_5_string = "srlw ";
      AluOp_subw : _zz_d0_down_Decoder_ALUOP_5_string = "subw ";
      AluOp_jal : _zz_d0_down_Decoder_ALUOP_5_string = "jal  ";
      AluOp_jalr : _zz_d0_down_Decoder_ALUOP_5_string = "jalr ";
      AluOp_beq : _zz_d0_down_Decoder_ALUOP_5_string = "beq  ";
      AluOp_bne : _zz_d0_down_Decoder_ALUOP_5_string = "bne  ";
      AluOp_bge : _zz_d0_down_Decoder_ALUOP_5_string = "bge  ";
      AluOp_bgeu : _zz_d0_down_Decoder_ALUOP_5_string = "bgeu ";
      AluOp_blt : _zz_d0_down_Decoder_ALUOP_5_string = "blt  ";
      AluOp_bltu : _zz_d0_down_Decoder_ALUOP_5_string = "bltu ";
      default : _zz_d0_down_Decoder_ALUOP_5_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_ALUOP_6)
      AluOp_add : _zz_d0_down_Decoder_ALUOP_6_string = "add  ";
      AluOp_sub : _zz_d0_down_Decoder_ALUOP_6_string = "sub  ";
      AluOp_sll_1 : _zz_d0_down_Decoder_ALUOP_6_string = "sll_1";
      AluOp_srl_1 : _zz_d0_down_Decoder_ALUOP_6_string = "srl_1";
      AluOp_sra_1 : _zz_d0_down_Decoder_ALUOP_6_string = "sra_1";
      AluOp_or_1 : _zz_d0_down_Decoder_ALUOP_6_string = "or_1 ";
      AluOp_xor_1 : _zz_d0_down_Decoder_ALUOP_6_string = "xor_1";
      AluOp_slt : _zz_d0_down_Decoder_ALUOP_6_string = "slt  ";
      AluOp_sltu : _zz_d0_down_Decoder_ALUOP_6_string = "sltu ";
      AluOp_and_1 : _zz_d0_down_Decoder_ALUOP_6_string = "and_1";
      AluOp_na : _zz_d0_down_Decoder_ALUOP_6_string = "na   ";
      AluOp_lui : _zz_d0_down_Decoder_ALUOP_6_string = "lui  ";
      AluOp_addw : _zz_d0_down_Decoder_ALUOP_6_string = "addw ";
      AluOp_sllw : _zz_d0_down_Decoder_ALUOP_6_string = "sllw ";
      AluOp_sraw : _zz_d0_down_Decoder_ALUOP_6_string = "sraw ";
      AluOp_srlw : _zz_d0_down_Decoder_ALUOP_6_string = "srlw ";
      AluOp_subw : _zz_d0_down_Decoder_ALUOP_6_string = "subw ";
      AluOp_jal : _zz_d0_down_Decoder_ALUOP_6_string = "jal  ";
      AluOp_jalr : _zz_d0_down_Decoder_ALUOP_6_string = "jalr ";
      AluOp_beq : _zz_d0_down_Decoder_ALUOP_6_string = "beq  ";
      AluOp_bne : _zz_d0_down_Decoder_ALUOP_6_string = "bne  ";
      AluOp_bge : _zz_d0_down_Decoder_ALUOP_6_string = "bge  ";
      AluOp_bgeu : _zz_d0_down_Decoder_ALUOP_6_string = "bgeu ";
      AluOp_blt : _zz_d0_down_Decoder_ALUOP_6_string = "blt  ";
      AluOp_bltu : _zz_d0_down_Decoder_ALUOP_6_string = "bltu ";
      default : _zz_d0_down_Decoder_ALUOP_6_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_ALUOP_7)
      AluOp_add : _zz_d0_down_Decoder_ALUOP_7_string = "add  ";
      AluOp_sub : _zz_d0_down_Decoder_ALUOP_7_string = "sub  ";
      AluOp_sll_1 : _zz_d0_down_Decoder_ALUOP_7_string = "sll_1";
      AluOp_srl_1 : _zz_d0_down_Decoder_ALUOP_7_string = "srl_1";
      AluOp_sra_1 : _zz_d0_down_Decoder_ALUOP_7_string = "sra_1";
      AluOp_or_1 : _zz_d0_down_Decoder_ALUOP_7_string = "or_1 ";
      AluOp_xor_1 : _zz_d0_down_Decoder_ALUOP_7_string = "xor_1";
      AluOp_slt : _zz_d0_down_Decoder_ALUOP_7_string = "slt  ";
      AluOp_sltu : _zz_d0_down_Decoder_ALUOP_7_string = "sltu ";
      AluOp_and_1 : _zz_d0_down_Decoder_ALUOP_7_string = "and_1";
      AluOp_na : _zz_d0_down_Decoder_ALUOP_7_string = "na   ";
      AluOp_lui : _zz_d0_down_Decoder_ALUOP_7_string = "lui  ";
      AluOp_addw : _zz_d0_down_Decoder_ALUOP_7_string = "addw ";
      AluOp_sllw : _zz_d0_down_Decoder_ALUOP_7_string = "sllw ";
      AluOp_sraw : _zz_d0_down_Decoder_ALUOP_7_string = "sraw ";
      AluOp_srlw : _zz_d0_down_Decoder_ALUOP_7_string = "srlw ";
      AluOp_subw : _zz_d0_down_Decoder_ALUOP_7_string = "subw ";
      AluOp_jal : _zz_d0_down_Decoder_ALUOP_7_string = "jal  ";
      AluOp_jalr : _zz_d0_down_Decoder_ALUOP_7_string = "jalr ";
      AluOp_beq : _zz_d0_down_Decoder_ALUOP_7_string = "beq  ";
      AluOp_bne : _zz_d0_down_Decoder_ALUOP_7_string = "bne  ";
      AluOp_bge : _zz_d0_down_Decoder_ALUOP_7_string = "bge  ";
      AluOp_bgeu : _zz_d0_down_Decoder_ALUOP_7_string = "bgeu ";
      AluOp_blt : _zz_d0_down_Decoder_ALUOP_7_string = "blt  ";
      AluOp_bltu : _zz_d0_down_Decoder_ALUOP_7_string = "bltu ";
      default : _zz_d0_down_Decoder_ALUOP_7_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_BR)
      YESNO_Y : _zz_d0_down_Decoder_IS_BR_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_BR_string = "N";
      default : _zz_d0_down_Decoder_IS_BR_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_BR_1)
      YESNO_Y : _zz_d0_down_Decoder_IS_BR_1_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_BR_1_string = "N";
      default : _zz_d0_down_Decoder_IS_BR_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_BR_2)
      YESNO_Y : _zz_d0_down_Decoder_IS_BR_2_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_BR_2_string = "N";
      default : _zz_d0_down_Decoder_IS_BR_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_W_1)
      YESNO_Y : _zz_d0_down_Decoder_IS_W_1_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_W_1_string = "N";
      default : _zz_d0_down_Decoder_IS_W_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_W_2)
      YESNO_Y : _zz_d0_down_Decoder_IS_W_2_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_W_2_string = "N";
      default : _zz_d0_down_Decoder_IS_W_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_d0_down_Decoder_IS_W_3)
      YESNO_Y : _zz_d0_down_Decoder_IS_W_3_string = "Y";
      YESNO_N : _zz_d0_down_Decoder_IS_W_3_string = "N";
      default : _zz_d0_down_Decoder_IS_W_3_string = "?";
    endcase
  end
  `endif

  always @(*) begin
    _zz_d0_haltRequest_scheduler_l91 = 1'b0;
    if(when_scheduler_l90) begin
      _zz_d0_haltRequest_scheduler_l91 = 1'b1;
    end
  end

  assign fetch_up_PC = fetcher_pcReg;
  assign fetch_up_valid = 1'b1;
  assign fetch_haltRequest_nebulainorder_l81 = (fetch_down_PC == 6'h0f);
  assign fetcher_instrn = fetcher_mem_spinal_port0;
  assign fetch_down_Decoder_INSTRUCTION = fetcher_mem_spinal_port1;
  assign decoder_trap_shouldHalt = _zz_decoder_trap_shouldHalt[0];
  always @(*) begin
    d0_down_Decoder_LEGAL = (1'bx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_LEGAL = _zz_d0_down_Decoder_LEGAL_2;
    end
  end

  assign _zz_d0_down_Decoder_LEGAL_1 = 1'b0;
  assign _zz_d0_down_Decoder_LEGAL = _zz_d0_down_Decoder_LEGAL_1;
  assign _zz_d0_down_Decoder_LEGAL_2 = _zz_d0_down_Decoder_LEGAL;
  always @(*) begin
    d0_down_Decoder_IS_FP = (1'bx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_IS_FP = _zz_d0_down_Decoder_IS_FP_2;
    end
  end

  assign _zz_d0_down_Decoder_FSR3EN = ((d0_up_Decoder_INSTRUCTION & 32'h0) == 32'h0);
  assign _zz_d0_down_Decoder_IS_FP_1 = (|_zz_d0_down_Decoder_FSR3EN);
  assign _zz_d0_down_Decoder_IS_FP = _zz_d0_down_Decoder_IS_FP_1;
  assign _zz_d0_down_Decoder_IS_FP_2 = _zz_d0_down_Decoder_IS_FP;
  always @(*) begin
    d0_down_Decoder_EXECUTION_UNIT = (3'bxxx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_EXECUTION_UNIT = _zz_d0_down_Decoder_EXECUTION_UNIT_2;
    end
  end

  assign _zz_d0_down_Decoder_IS_W = ((d0_up_Decoder_INSTRUCTION & 32'h00000010) == 32'h0);
  assign _zz_d0_down_Decoder_EXECUTION_UNIT_1 = {1'b0,{(|_zz_d0_down_Decoder_IS_W),(|_zz_d0_down_Decoder_IS_W)}};
  assign _zz_d0_down_Decoder_EXECUTION_UNIT = _zz_d0_down_Decoder_EXECUTION_UNIT_1;
  assign _zz_d0_down_Decoder_EXECUTION_UNIT_2 = _zz_d0_down_Decoder_EXECUTION_UNIT;
  always @(*) begin
    d0_down_Decoder_RDTYPE = (2'bxx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_RDTYPE = _zz_d0_down_Decoder_RDTYPE_2;
    end
  end

  assign _zz_d0_down_Decoder_IMMSEL = ((d0_up_Decoder_INSTRUCTION & 32'h00000014) == 32'h0);
  assign _zz_d0_down_Decoder_RDTYPE_1 = {(|_zz_d0_down_Decoder_IMMSEL),(|_zz_d0_down_Decoder_IMMSEL)};
  assign _zz_d0_down_Decoder_RDTYPE = _zz_d0_down_Decoder_RDTYPE_1;
  assign _zz_d0_down_Decoder_RDTYPE_2 = _zz_d0_down_Decoder_RDTYPE;
  always @(*) begin
    d0_down_Decoder_RS1TYPE = (3'bxxx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_RS1TYPE = _zz_d0_down_Decoder_RS1TYPE_2;
    end
  end

  assign _zz_d0_down_Decoder_RS1TYPE_1 = {(|{((d0_up_Decoder_INSTRUCTION & 32'h00000004) == 32'h00000004),_zz_d0_down_Decoder_IS_W}),{1'b0,1'b0}};
  assign _zz_d0_down_Decoder_RS1TYPE = _zz_d0_down_Decoder_RS1TYPE_1;
  assign _zz_d0_down_Decoder_RS1TYPE_2 = _zz_d0_down_Decoder_RS1TYPE;
  always @(*) begin
    d0_down_Decoder_RS2TYPE = (3'bxxx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_RS2TYPE = _zz_d0_down_Decoder_RS2TYPE_2;
    end
  end

  assign _zz_d0_down_Decoder_ALUOP = ((d0_up_Decoder_INSTRUCTION & 32'h00000044) == 32'h00000004);
  assign _zz_d0_down_Decoder_IMMSEL_1 = ((d0_up_Decoder_INSTRUCTION & 32'h00000020) == 32'h0);
  assign _zz_d0_down_Decoder_RS2TYPE_1 = {(|_zz_d0_down_Decoder_IS_W),{(|{_zz_d0_down_Decoder_IMMSEL_1,_zz_d0_down_Decoder_ALUOP}),(|{_zz_d0_down_Decoder_IMMSEL_1,_zz_d0_down_Decoder_ALUOP})}};
  assign _zz_d0_down_Decoder_RS2TYPE = _zz_d0_down_Decoder_RS2TYPE_1;
  assign _zz_d0_down_Decoder_RS2TYPE_2 = _zz_d0_down_Decoder_RS2TYPE;
  always @(*) begin
    d0_down_Decoder_FSR3EN = (1'bx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_FSR3EN = _zz_d0_down_Decoder_FSR3EN_3;
    end
  end

  assign _zz_d0_down_Decoder_FSR3EN_2 = (|_zz_d0_down_Decoder_FSR3EN);
  assign _zz_d0_down_Decoder_FSR3EN_1 = _zz_d0_down_Decoder_FSR3EN_2;
  assign _zz_d0_down_Decoder_FSR3EN_3 = _zz_d0_down_Decoder_FSR3EN_1;
  always @(*) begin
    d0_down_Decoder_IMMSEL = (3'bxxx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_IMMSEL = _zz_d0_down_Decoder_IMMSEL_4;
    end
  end

  assign _zz_d0_down_Decoder_ALUOP_1 = ((d0_up_Decoder_INSTRUCTION & 32'h00000018) == 32'h00000008);
  assign _zz_d0_down_Decoder_IMMSEL_3 = {(|{_zz_d0_down_Decoder_ALUOP_1,_zz_d0_down_Decoder_ALUOP}),{(|_zz_d0_down_Decoder_IMMSEL),(|{_zz_d0_down_Decoder_IS_W,_zz_d0_down_Decoder_IMMSEL_1})}};
  assign _zz_d0_down_Decoder_IMMSEL_2 = _zz_d0_down_Decoder_IMMSEL_3;
  assign _zz_d0_down_Decoder_IMMSEL_4 = _zz_d0_down_Decoder_IMMSEL_2;
  always @(*) begin
    d0_down_Decoder_ALUOP = (5'bxxxxx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_ALUOP = _zz_d0_down_Decoder_ALUOP_7;
    end
  end

  assign _zz_d0_down_Decoder_ALUOP_2 = ((d0_up_Decoder_INSTRUCTION & 32'h00004048) == 32'h00004008);
  assign _zz_d0_down_Decoder_ALUOP_3 = ((d0_up_Decoder_INSTRUCTION & 32'h40000048) == 32'h00000008);
  assign _zz_d0_down_Decoder_ALUOP_4 = ((d0_up_Decoder_INSTRUCTION & 32'h00000028) == 32'h00000008);
  assign _zz_d0_down_Decoder_ALUOP_6 = {(|{_zz_d0_down_Decoder_IS_W,(_zz__zz_d0_down_Decoder_ALUOP_6 == _zz__zz_d0_down_Decoder_ALUOP_6_1)}),{(|{_zz_d0_down_Decoder_ALUOP_4,{_zz__zz_d0_down_Decoder_ALUOP_6_2,_zz__zz_d0_down_Decoder_ALUOP_6_3}}),{(|{_zz__zz_d0_down_Decoder_ALUOP_6_10,_zz__zz_d0_down_Decoder_ALUOP_6_11}),{(|_zz__zz_d0_down_Decoder_ALUOP_6_26),(|_zz__zz_d0_down_Decoder_ALUOP_6_39)}}}};
  assign _zz_d0_down_Decoder_ALUOP_5 = _zz_d0_down_Decoder_ALUOP_6;
  assign _zz_d0_down_Decoder_ALUOP_7 = _zz_d0_down_Decoder_ALUOP_5;
  always @(*) begin
    d0_down_Decoder_IS_BR = (1'bx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_IS_BR = _zz_d0_down_Decoder_IS_BR_2;
    end
  end

  assign _zz_d0_down_Decoder_IS_BR_1 = (|{((d0_up_Decoder_INSTRUCTION & 32'h00000008) == 32'h00000008),{((d0_up_Decoder_INSTRUCTION & 32'h00000040) == 32'h0),((d0_up_Decoder_INSTRUCTION & 32'h00005000) == 32'h0)}});
  assign _zz_d0_down_Decoder_IS_BR = _zz_d0_down_Decoder_IS_BR_1;
  assign _zz_d0_down_Decoder_IS_BR_2 = _zz_d0_down_Decoder_IS_BR;
  always @(*) begin
    d0_down_Decoder_IS_W = (1'bx);
    if(d0_up_isFiring) begin
      d0_down_Decoder_IS_W = _zz_d0_down_Decoder_IS_W_3;
    end
  end

  assign _zz_d0_down_Decoder_IS_W_2 = (|{((d0_up_Decoder_INSTRUCTION & 32'h00000008) == 32'h0),_zz_d0_down_Decoder_IS_W});
  assign _zz_d0_down_Decoder_IS_W_1 = _zz_d0_down_Decoder_IS_W_2;
  assign _zz_d0_down_Decoder_IS_W_3 = _zz_d0_down_Decoder_IS_W_1;
  assign d0_down_Decoder_RD = d0_up_Decoder_INSTRUCTION[11 : 7];
  assign d0_down_Decoder_RS1 = d0_up_Decoder_INSTRUCTION[19 : 15];
  assign d0_down_Decoder_RS2 = d0_up_Decoder_INSTRUCTION[24 : 20];
  always @(*) begin
    dis0_down_Dispatch_SENDTOALU = 1'b0;
    if(when_scheduler_l134) begin
      dis0_down_Dispatch_SENDTOALU = 1'b1;
    end
  end

  always @(*) begin
    dis0_down_Dispatch_SENDTOBRANCH = 1'b0;
    if(when_scheduler_l137) begin
      dis0_down_Dispatch_SENDTOBRANCH = 1'b1;
    end
  end

  assign when_scheduler_l134 = ((dis0_up_Decoder_EXECUTION_UNIT == ExecutionUnit_ALU) && dis0_up_isValid);
  assign when_scheduler_l137 = ((dis0_up_Decoder_EXECUTION_UNIT == ExecutionUnit_BR) && dis0_up_isValid);
  assign intregFile_reggy_accessIntRfRS1 = (rfread0_down_Decoder_RS1TYPE == RSTYPE_RS_INT);
  assign intregFile_reggy_accessIntRfRS2 = (rfread0_down_Decoder_RS2TYPE == RSTYPE_RS_INT);
  assign _zz_intregFile_reggy_readRS1 = rfread0_down_Decoder_RS1;
  assign intregFile_reggy_readRS1 = intregFile_reggy_mem_spinal_port0;
  assign _zz_intregFile_reggy_readRS2 = rfread0_down_Decoder_RS2;
  assign intregFile_reggy_readRS2 = intregFile_reggy_mem_spinal_port1;
  always @(*) begin
    rfread0_down_IntRegFile_RegFile_RS1 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(intregFile_reggy_accessIntRfRS1) begin
      rfread0_down_IntRegFile_RegFile_RS1 = intregFile_reggy_readRS1;
    end
  end

  always @(*) begin
    rfread0_down_IntRegFile_RegFile_RS2 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(intregFile_reggy_accessIntRfRS2) begin
      rfread0_down_IntRegFile_RegFile_RS2 = intregFile_reggy_readRS2;
    end
  end

  assign hazardChecker_isRs1Haz_0 = (((d0_down_Decoder_RS1 != 5'h0) && (d0_down_Decoder_RS1 == dis0_down_Decoder_RD)) && (dis0_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs1Haz_1 = (((d0_down_Decoder_RS1 != 5'h0) && (d0_down_Decoder_RS1 == rfread0_down_Decoder_RD)) && (rfread0_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs1Haz_2 = (((d0_down_Decoder_RS1 != 5'h0) && (d0_down_Decoder_RS1 == E1_down_Decoder_RD)) && (E1_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs1Haz_3 = (((d0_down_Decoder_RS1 != 5'h0) && (d0_down_Decoder_RS1 == wbStage_down_Decoder_RD)) && (wbStage_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign _zz_d0_haltRequest_scheduler_l77 = (((hazardChecker_isRs1Haz_0 || hazardChecker_isRs1Haz_1) || hazardChecker_isRs1Haz_2) || hazardChecker_isRs1Haz_3);
  assign d0_haltRequest_scheduler_l77 = _zz_d0_haltRequest_scheduler_l77;
  assign hazardChecker_isRs2Haz_0 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == dis0_down_Decoder_RD)) && (dis0_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs2Haz_1 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == rfread0_down_Decoder_RD)) && (rfread0_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs2Haz_2 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == E1_down_Decoder_RD)) && (E1_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs2Haz_3 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == wbStage_down_Decoder_RD)) && (wbStage_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign when_scheduler_l90 = (((hazardChecker_isRs2Haz_0 || hazardChecker_isRs2Haz_1) || hazardChecker_isRs2Haz_2) || hazardChecker_isRs2Haz_3);
  assign d0_haltRequest_scheduler_l91 = _zz_d0_haltRequest_scheduler_l91;
  always @(*) begin
    srcPlugin_immsel_sext = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      srcPlugin_immsel_sext = _zz_srcPlugin_immsel_sext_1;
    end
  end

  assign _zz_srcPlugin_immsel_imm_u_sext_pub = {{32{_zz__zz_srcPlugin_immsel_imm_u_sext_pub[31]}}, _zz__zz_srcPlugin_immsel_imm_u_sext_pub};
  assign srcPlugin_immsel_imm_u_sext_pub = _zz_srcPlugin_immsel_imm_u_sext_pub;
  assign _zz_srcPlugin_immsel_sext = {{32{_zz__zz_srcPlugin_immsel_sext[31]}}, _zz__zz_srcPlugin_immsel_sext};
  always @(*) begin
    _zz_srcPlugin_immsel_sext_1 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(rfread0_up_Decoder_IMMSEL)
      Imm_Select_I_IMM : begin
        _zz_srcPlugin_immsel_sext_1 = {{52{_zz__zz_srcPlugin_immsel_sext_1[11]}}, _zz__zz_srcPlugin_immsel_sext_1};
      end
      Imm_Select_S_IMM : begin
        _zz_srcPlugin_immsel_sext_1 = {{52{_zz__zz_srcPlugin_immsel_sext_1_1[11]}}, _zz__zz_srcPlugin_immsel_sext_1_1};
      end
      Imm_Select_B_IMM : begin
        _zz_srcPlugin_immsel_sext_1 = {{51{_zz__zz_srcPlugin_immsel_sext_1_2[12]}}, _zz__zz_srcPlugin_immsel_sext_1_2};
      end
      Imm_Select_U_IMM : begin
        _zz_srcPlugin_immsel_sext_1 = _zz_srcPlugin_immsel_sext;
      end
      Imm_Select_J_IMM : begin
        _zz_srcPlugin_immsel_sext_1 = {{43{_zz__zz_srcPlugin_immsel_sext_1_3[20]}}, _zz__zz_srcPlugin_immsel_sext_1_3};
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    case(rfread0_up_Decoder_IMMSEL)
      Imm_Select_B_IMM : begin
        _zz_srcPlugin_immsel_is3src = 1'b1;
      end
      Imm_Select_S_IMM : begin
        _zz_srcPlugin_immsel_is3src = 1'b1;
      end
      default : begin
        _zz_srcPlugin_immsel_is3src = 1'b0;
      end
    endcase
  end

  assign srcPlugin_immsel_is3src = _zz_srcPlugin_immsel_is3src;
  always @(*) begin
    rfread0_down_SrcPlugin_RS1 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      rfread0_down_SrcPlugin_RS1 = _zz_rfread0_down_SrcPlugin_RS1;
    end
  end

  always @(*) begin
    rfread0_down_SrcPlugin_RS2 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      if(when_SrcPlugin_l79) begin
        rfread0_down_SrcPlugin_RS2 = _zz_rfread0_down_SrcPlugin_RS2;
      end
      if(srcPlugin_immsel_is3src) begin
        rfread0_down_SrcPlugin_RS2 = rfread0_down_IntRegFile_RegFile_RS2;
      end
    end
  end

  always @(*) begin
    rfread0_down_SrcPlugin_IMMED = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      rfread0_down_SrcPlugin_IMMED = srcPlugin_immsel_sext;
    end
  end

  always @(*) begin
    _zz_rfread0_down_SrcPlugin_RS1 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(rfread0_up_Decoder_RS1TYPE)
      RSTYPE_RS_INT : begin
        _zz_rfread0_down_SrcPlugin_RS1 = rfread0_down_IntRegFile_RegFile_RS1;
      end
      default : begin
      end
    endcase
  end

  assign when_SrcPlugin_l79 = (! srcPlugin_immsel_is3src);
  always @(*) begin
    _zz_rfread0_down_SrcPlugin_RS2 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(rfread0_up_Decoder_RS2TYPE)
      RSTYPE_RS_INT : begin
        _zz_rfread0_down_SrcPlugin_RS2 = rfread0_down_IntRegFile_RegFile_RS2;
      end
      RSTYPE_IMMED : begin
        _zz_rfread0_down_SrcPlugin_RS2 = srcPlugin_immsel_sext;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    executePipeline_intalu_aluNodeStage_result = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_IntAlu_l25) begin
      executePipeline_intalu_aluNodeStage_result = _zz_executePipeline_intalu_aluNodeStage_result;
    end
    if(when_IntAlu_l46) begin
      executePipeline_intalu_aluNodeStage_result = {63'd0, _zz_executePipeline_intalu_aluNodeStage_result_1};
    end
    if(when_IntAlu_l51) begin
      executePipeline_intalu_aluNodeStage_result = {63'd0, _zz_executePipeline_intalu_aluNodeStage_result_4};
    end
  end

  assign when_IntAlu_l25 = ((E1_up_Dispatch_SENDTOALU == 1'b1) && E1_up_isValid);
  always @(*) begin
    _zz_executePipeline_intalu_aluNodeStage_result = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(E1_up_Decoder_ALUOP)
      AluOp_xor_1 : begin
        _zz_executePipeline_intalu_aluNodeStage_result = (E1_down_SrcPlugin_RS1 ^ E1_down_SrcPlugin_RS2);
      end
      AluOp_or_1 : begin
        _zz_executePipeline_intalu_aluNodeStage_result = (E1_down_SrcPlugin_RS1 | E1_down_SrcPlugin_RS2);
      end
      AluOp_and_1 : begin
        _zz_executePipeline_intalu_aluNodeStage_result = (E1_down_SrcPlugin_RS1 & E1_down_SrcPlugin_RS2);
      end
      AluOp_add : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result;
      end
      AluOp_sll_1 : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_3;
      end
      AluOp_srl_1 : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_4;
      end
      AluOp_sra_1 : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_5;
      end
      AluOp_sub : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_6;
      end
      AluOp_addw : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_9;
      end
      AluOp_sllw : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_14;
      end
      AluOp_sraw : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_17;
      end
      AluOp_srlw : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_20;
      end
      AluOp_subw : begin
        _zz_executePipeline_intalu_aluNodeStage_result = _zz__zz_executePipeline_intalu_aluNodeStage_result_23;
      end
      AluOp_lui : begin
        _zz_executePipeline_intalu_aluNodeStage_result = E1_down_SrcPlugin_RS2;
      end
      default : begin
      end
    endcase
  end

  assign when_IntAlu_l46 = (E1_up_Decoder_ALUOP == AluOp_slt);
  assign when_IntAlu_l51 = (E1_up_Decoder_ALUOP == AluOp_sltu);
  always @(*) begin
    E1_down_Execute_RESULT = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(E1_up_isFiring) begin
      if(when_IntAlu_l58) begin
        E1_down_Execute_RESULT = {32'd0, _zz_E1_down_Execute_RESULT};
      end else begin
        E1_down_Execute_RESULT = executePipeline_intalu_aluNodeStage_result;
      end
    end
  end

  assign when_IntAlu_l58 = (E1_up_Decoder_IS_W == YESNO_Y);
  always @(*) begin
    executePipeline_jal_jumpLocation_payload_address = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_branch_l92) begin
      executePipeline_jal_jumpLocation_payload_address = E1_down_SrcPlugin_RS2;
    end
  end

  always @(*) begin
    executePipeline_jal_jumpLocation_valid = 1'b0;
    if(when_branch_l92) begin
      executePipeline_jal_jumpLocation_valid = 1'b1;
    end
  end

  assign when_branch_l92 = ((E1_up_Dispatch_SENDTOBRANCH == 1'b1) && E1_up_isValid);
  assign intregFile_io_RD_Enable = wb_io_RD_Enable;
  assign intregFile_io_RD_address = wb_io_RD_address;
  assign intregFile_io_RD_data = wb_io_RD_data;
  always @(*) begin
    wb_io_RD_Enable = 1'b0;
    if(wbStage_up_isValid) begin
      wb_io_RD_Enable = (wbStage_up_Decoder_RDTYPE == RDTYPE_RD_INT);
    end
  end

  always @(*) begin
    wb_io_RD_address = 5'bxxxxx;
    if(wbStage_up_isValid) begin
      wb_io_RD_address = wbStage_up_Decoder_RD;
    end
  end

  always @(*) begin
    wb_io_RD_data = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(wbStage_up_isValid) begin
      wb_io_RD_data = wbStage_up_Execute_RESULT;
    end
  end

  always @(*) begin
    fetch_down_valid = fetch_up_valid;
    if(when_CtrlLink_l150) begin
      fetch_down_valid = 1'b0;
    end
  end

  always @(*) begin
    fetch_up_ready = fetch_down_isReady;
    if(when_CtrlLink_l150) begin
      fetch_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l150 = (|fetch_haltRequest_nebulainorder_l81);
  assign fetch_down_PC = fetch_up_PC;
  always @(*) begin
    d0_down_valid = d0_up_valid;
    if(when_CtrlLink_l150_1) begin
      d0_down_valid = 1'b0;
    end
  end

  always @(*) begin
    d0_up_ready = d0_down_isReady;
    if(when_CtrlLink_l150_1) begin
      d0_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l150_1 = (|{d0_haltRequest_scheduler_l91,d0_haltRequest_scheduler_l77});
  assign d0_down_Decoder_INSTRUCTION = d0_up_Decoder_INSTRUCTION;
  assign dis0_down_valid = dis0_up_valid;
  assign dis0_down_Decoder_INSTRUCTION = dis0_up_Decoder_INSTRUCTION;
  assign dis0_down_Decoder_RDTYPE = dis0_up_Decoder_RDTYPE;
  assign dis0_down_Decoder_RS1TYPE = dis0_up_Decoder_RS1TYPE;
  assign dis0_down_Decoder_RS2TYPE = dis0_up_Decoder_RS2TYPE;
  assign dis0_down_Decoder_IMMSEL = dis0_up_Decoder_IMMSEL;
  assign dis0_down_Decoder_ALUOP = dis0_up_Decoder_ALUOP;
  assign dis0_down_Decoder_IS_W = dis0_up_Decoder_IS_W;
  assign dis0_down_Decoder_RD = dis0_up_Decoder_RD;
  assign dis0_down_Decoder_RS1 = dis0_up_Decoder_RS1;
  assign dis0_down_Decoder_RS2 = dis0_up_Decoder_RS2;
  assign rfread0_down_valid = rfread0_up_valid;
  assign rfread0_down_Decoder_INSTRUCTION = rfread0_up_Decoder_INSTRUCTION;
  assign rfread0_down_Decoder_RDTYPE = rfread0_up_Decoder_RDTYPE;
  assign rfread0_down_Decoder_RS1TYPE = rfread0_up_Decoder_RS1TYPE;
  assign rfread0_down_Decoder_RS2TYPE = rfread0_up_Decoder_RS2TYPE;
  assign rfread0_down_Decoder_ALUOP = rfread0_up_Decoder_ALUOP;
  assign rfread0_down_Decoder_IS_W = rfread0_up_Decoder_IS_W;
  assign rfread0_down_Decoder_RD = rfread0_up_Decoder_RD;
  assign rfread0_down_Decoder_RS1 = rfread0_up_Decoder_RS1;
  assign rfread0_down_Decoder_RS2 = rfread0_up_Decoder_RS2;
  assign rfread0_down_Dispatch_SENDTOALU = rfread0_up_Dispatch_SENDTOALU;
  assign rfread0_down_Dispatch_SENDTOBRANCH = rfread0_up_Dispatch_SENDTOBRANCH;
  assign E1_down_valid = E1_up_valid;
  assign E1_down_Decoder_INSTRUCTION = E1_up_Decoder_INSTRUCTION;
  assign E1_down_Decoder_RDTYPE = E1_up_Decoder_RDTYPE;
  assign E1_down_Decoder_RD = E1_up_Decoder_RD;
  assign E1_down_SrcPlugin_RS1 = E1_up_SrcPlugin_RS1;
  assign E1_down_SrcPlugin_RS2 = E1_up_SrcPlugin_RS2;
  assign wbStage_down_valid = wbStage_up_valid;
  assign wbStage_down_Decoder_INSTRUCTION = wbStage_up_Decoder_INSTRUCTION;
  assign wbStage_down_Decoder_RD = wbStage_up_Decoder_RD;
  always @(*) begin
    fetch_down_ready = d0_up_ready;
    if(when_StageLink_l67) begin
      fetch_down_ready = 1'b1;
    end
  end

  assign when_StageLink_l67 = (! d0_up_isValid);
  assign fetch_up_isFiring = (fetch_up_isValid && fetch_up_isReady);
  assign fetch_up_isValid = fetch_up_valid;
  assign fetch_up_isReady = fetch_up_ready;
  assign fetch_down_isValid = fetch_down_valid;
  assign fetch_down_isReady = fetch_down_ready;
  assign d0_up_isFiring = (d0_up_isValid && d0_up_isReady);
  assign d0_up_isValid = d0_up_valid;
  assign d0_up_isReady = d0_up_ready;
  assign d0_down_isValid = d0_down_valid;
  assign d0_down_isReady = 1'b1;
  assign dis0_up_isValid = dis0_up_valid;
  assign dis0_down_isValid = dis0_down_valid;
  assign rfread0_up_isValid = rfread0_up_valid;
  assign rfread0_down_isValid = rfread0_down_valid;
  assign E1_up_isFiring = (E1_up_isValid && E1_up_isReady);
  assign E1_up_isValid = E1_up_valid;
  assign E1_up_isReady = 1'b1;
  assign E1_down_isValid = E1_down_valid;
  assign wbStage_up_isValid = wbStage_up_valid;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      fetcher_pcReg <= 6'h0;
      d0_up_valid <= 1'b0;
      dis0_up_valid <= 1'b0;
      rfread0_up_valid <= 1'b0;
      E1_up_valid <= 1'b0;
      wbStage_up_valid <= 1'b0;
    end else begin
      if(fetch_up_isFiring) begin
        fetcher_pcReg <= (fetch_down_PC + 6'h01);
      end
      if(fetch_down_isReady) begin
        d0_up_valid <= fetch_down_isValid;
      end
      dis0_up_valid <= d0_down_isValid;
      rfread0_up_valid <= dis0_down_isValid;
      E1_up_valid <= rfread0_down_isValid;
      wbStage_up_valid <= E1_down_isValid;
    end
  end

  always @(posedge clk) begin
    wb_instrReg <= wbStage_down_Decoder_INSTRUCTION;
    if(fetch_down_isReady) begin
      d0_up_Decoder_INSTRUCTION <= fetch_down_Decoder_INSTRUCTION;
    end
    dis0_up_Decoder_INSTRUCTION <= d0_down_Decoder_INSTRUCTION;
    dis0_up_Decoder_EXECUTION_UNIT <= d0_down_Decoder_EXECUTION_UNIT;
    dis0_up_Decoder_RDTYPE <= d0_down_Decoder_RDTYPE;
    dis0_up_Decoder_RS1TYPE <= d0_down_Decoder_RS1TYPE;
    dis0_up_Decoder_RS2TYPE <= d0_down_Decoder_RS2TYPE;
    dis0_up_Decoder_IMMSEL <= d0_down_Decoder_IMMSEL;
    dis0_up_Decoder_ALUOP <= d0_down_Decoder_ALUOP;
    dis0_up_Decoder_IS_W <= d0_down_Decoder_IS_W;
    dis0_up_Decoder_RD <= d0_down_Decoder_RD;
    dis0_up_Decoder_RS1 <= d0_down_Decoder_RS1;
    dis0_up_Decoder_RS2 <= d0_down_Decoder_RS2;
    rfread0_up_Decoder_INSTRUCTION <= dis0_down_Decoder_INSTRUCTION;
    rfread0_up_Decoder_RDTYPE <= dis0_down_Decoder_RDTYPE;
    rfread0_up_Decoder_RS1TYPE <= dis0_down_Decoder_RS1TYPE;
    rfread0_up_Decoder_RS2TYPE <= dis0_down_Decoder_RS2TYPE;
    rfread0_up_Decoder_IMMSEL <= dis0_down_Decoder_IMMSEL;
    rfread0_up_Decoder_ALUOP <= dis0_down_Decoder_ALUOP;
    rfread0_up_Decoder_IS_W <= dis0_down_Decoder_IS_W;
    rfread0_up_Decoder_RD <= dis0_down_Decoder_RD;
    rfread0_up_Decoder_RS1 <= dis0_down_Decoder_RS1;
    rfread0_up_Decoder_RS2 <= dis0_down_Decoder_RS2;
    rfread0_up_Dispatch_SENDTOALU <= dis0_down_Dispatch_SENDTOALU;
    rfread0_up_Dispatch_SENDTOBRANCH <= dis0_down_Dispatch_SENDTOBRANCH;
    E1_up_Decoder_INSTRUCTION <= rfread0_down_Decoder_INSTRUCTION;
    E1_up_Decoder_RDTYPE <= rfread0_down_Decoder_RDTYPE;
    E1_up_Decoder_ALUOP <= rfread0_down_Decoder_ALUOP;
    E1_up_Decoder_IS_W <= rfread0_down_Decoder_IS_W;
    E1_up_Decoder_RD <= rfread0_down_Decoder_RD;
    E1_up_Dispatch_SENDTOALU <= rfread0_down_Dispatch_SENDTOALU;
    E1_up_Dispatch_SENDTOBRANCH <= rfread0_down_Dispatch_SENDTOBRANCH;
    E1_up_SrcPlugin_RS1 <= rfread0_down_SrcPlugin_RS1;
    E1_up_SrcPlugin_RS2 <= rfread0_down_SrcPlugin_RS2;
    wbStage_up_Decoder_INSTRUCTION <= E1_down_Decoder_INSTRUCTION;
    wbStage_up_Decoder_RDTYPE <= E1_down_Decoder_RDTYPE;
    wbStage_up_Decoder_RD <= E1_down_Decoder_RD;
    wbStage_up_Execute_RESULT <= E1_down_Execute_RESULT;
  end


endmodule

// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : nebulaRVIO
// Git hash  : f05e0f2741d36ea7da19ff48a864a2a841844368

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
  localparam AluOp_add = 4'd0;
  localparam AluOp_sub = 4'd1;
  localparam AluOp_sll_1 = 4'd2;
  localparam AluOp_srl_1 = 4'd3;
  localparam AluOp_sra_1 = 4'd4;
  localparam AluOp_or_1 = 4'd5;
  localparam AluOp_xor_1 = 4'd6;
  localparam AluOp_slt = 4'd7;
  localparam AluOp_sltu = 4'd8;
  localparam AluOp_and_1 = 4'd9;
  localparam AluOp_addw = 4'd10;
  localparam AluOp_sllw = 4'd11;
  localparam AluOp_sraw = 4'd12;
  localparam AluOp_srlw = 4'd13;
  localparam AluOp_subw = 4'd14;
  localparam Imm_Select_I_IMM = 2'd0;
  localparam Imm_Select_S_IMM = 2'd1;
  localparam Imm_Select_N_IMM = 2'd2;
  localparam Imm_Select_B_IMM = 2'd3;
  localparam RSTYPE_RS_INT = 3'd0;
  localparam RSTYPE_RS_FP = 3'd1;
  localparam RSTYPE_RS_VEC = 3'd2;
  localparam RSTYPE_IMMED = 3'd3;
  localparam RSTYPE_RS_NA = 3'd4;
  localparam ExecutionUnit_ALU = 2'd0;
  localparam ExecutionUnit_FPU = 2'd1;
  localparam ExecutionUnit_AGU = 2'd2;

  wire       [31:0]   fetcher_mem_spinal_port0;
  wire       [31:0]   fetcher_mem_spinal_port1;
  wire       [63:0]   intregFile_reggy_mem_spinal_port0;
  wire       [63:0]   intregFile_reggy_mem_spinal_port1;
  wire       [0:0]    _zz_decoder_trap_shouldHalt_1;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_1;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_2;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_3;
  wire                _zz__zz_decoder_ctrlSigs_aluop_2_4;
  wire       [0:0]    _zz__zz_decoder_ctrlSigs_aluop_2_5;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_6;
  wire       [2:0]    _zz__zz_decoder_ctrlSigs_aluop_2_7;
  wire                _zz__zz_decoder_ctrlSigs_aluop_2_8;
  wire                _zz__zz_decoder_ctrlSigs_aluop_2_9;
  wire       [0:0]    _zz__zz_decoder_ctrlSigs_aluop_2_10;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_11;
  wire       [3:0]    _zz__zz_decoder_ctrlSigs_aluop_2_12;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_13;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_14;
  wire                _zz__zz_decoder_ctrlSigs_aluop_2_15;
  wire       [0:0]    _zz__zz_decoder_ctrlSigs_aluop_2_16;
  wire       [0:0]    _zz__zz_decoder_ctrlSigs_aluop_2_17;
  wire       [0:0]    _zz__zz_decoder_ctrlSigs_aluop_2_18;
  wire       [4:0]    _zz__zz_decoder_ctrlSigs_aluop_2_19;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_20;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_21;
  wire       [0:0]    _zz__zz_decoder_ctrlSigs_aluop_2_22;
  wire       [1:0]    _zz__zz_decoder_ctrlSigs_aluop_2_23;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_24;
  wire       [31:0]   _zz__zz_decoder_ctrlSigs_aluop_2_25;
  wire                _zz_intregFile_reggy_mem_port;
  wire       [11:0]   _zz__zz_srcPlugin_immsel_sext;
  wire       [11:0]   _zz__zz_srcPlugin_immsel_sext_1;
  wire       [12:0]   _zz__zz_srcPlugin_immsel_sext_2;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_1;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_2;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_3;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_4;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_5;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_6;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_7;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_8;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_9;
  wire       [31:0]   _zz__zz_intalu_aluNodeStage_logic_result_10;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_11;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_12;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_13;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_14;
  wire       [31:0]   _zz__zz_intalu_aluNodeStage_logic_result_15;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_16;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_17;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_18;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_19;
  wire       [31:0]   _zz__zz_intalu_aluNodeStage_logic_result_20;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_21;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_22;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_23;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_24;
  wire       [31:0]   _zz__zz_intalu_aluNodeStage_logic_result_25;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_26;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_27;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_28;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_29;
  wire       [31:0]   _zz__zz_intalu_aluNodeStage_logic_result_30;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_31;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_32;
  wire       [63:0]   _zz__zz_intalu_aluNodeStage_logic_result_33;
  wire       [0:0]    _zz_intalu_aluNodeStage_logic_result_1;
  wire       [63:0]   _zz_intalu_aluNodeStage_logic_result_2;
  wire       [63:0]   _zz_intalu_aluNodeStage_logic_result_3;
  wire       [63:0]   _zz_intalu_aluNodeStage_logic_result_4;
  wire       [0:0]    _zz_intalu_aluNodeStage_logic_result_5;
  wire       [63:0]   _zz_intalu_aluNodeStage_logic_result_6;
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
  reg        [4:0]    E1_up_Decoder_RD;
  wire       [1:0]    E1_down_Decoder_RDTYPE;
  reg                 rfread0_up_Dispatch_SENDTOALU;
  wire                rfread0_down_Dispatch_SENDTOALU;
  reg        [4:0]    rfread0_up_Decoder_RS2;
  reg        [4:0]    rfread0_up_Decoder_RS1;
  reg        [4:0]    rfread0_up_Decoder_RD;
  reg        [0:0]    rfread0_up_Decoder_IS_W;
  wire       [0:0]    rfread0_down_Decoder_IS_W;
  reg        [3:0]    rfread0_up_Decoder_ALUOP;
  wire       [3:0]    rfread0_down_Decoder_ALUOP;
  wire       [1:0]    rfread0_down_Decoder_RDTYPE;
  reg        [31:0]   rfread0_up_Decoder_INSTRUCTION;
  reg        [4:0]    dis0_up_Decoder_RS2;
  wire       [4:0]    dis0_down_Decoder_RS2;
  reg        [4:0]    dis0_up_Decoder_RS1;
  wire       [4:0]    dis0_down_Decoder_RS1;
  reg        [4:0]    dis0_up_Decoder_RD;
  reg        [0:0]    dis0_up_Decoder_IS_W;
  wire       [0:0]    dis0_down_Decoder_IS_W;
  reg        [3:0]    dis0_up_Decoder_ALUOP;
  wire       [3:0]    dis0_down_Decoder_ALUOP;
  reg        [1:0]    dis0_up_Decoder_IMMSEL;
  wire       [1:0]    dis0_down_Decoder_IMMSEL;
  reg        [2:0]    dis0_up_Decoder_RS2TYPE;
  wire       [2:0]    dis0_down_Decoder_RS2TYPE;
  reg        [2:0]    dis0_up_Decoder_RS1TYPE;
  wire       [2:0]    dis0_down_Decoder_RS1TYPE;
  wire       [1:0]    dis0_down_Decoder_RDTYPE;
  reg        [31:0]   dis0_up_Decoder_INSTRUCTION;
  wire       [31:0]   dis0_down_Decoder_INSTRUCTION;
  wire       [31:0]   d0_down_Decoder_INSTRUCTION;
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
  reg        [0:0]    E1_up_Decoder_IS_W;
  wire                E1_up_isFiring;
  reg        [63:0]   E1_down_Execute_RESULT;
  reg        [63:0]   E1_up_SrcPlugin_RS2;
  reg        [63:0]   E1_up_SrcPlugin_RS1;
  reg        [3:0]    E1_up_Decoder_ALUOP;
  wire                E1_up_isValid;
  reg                 E1_up_Dispatch_SENDTOALU;
  wire       [63:0]   E1_down_SrcPlugin_RS2;
  wire       [63:0]   E1_down_SrcPlugin_RS1;
  wire                E1_down_intalu_BR_EQ;
  reg        [2:0]    rfread0_up_Decoder_RS2TYPE;
  reg        [2:0]    rfread0_up_Decoder_RS1TYPE;
  reg        [63:0]   rfread0_down_SrcPlugin_RS2;
  reg        [63:0]   rfread0_down_SrcPlugin_RS1;
  reg        [1:0]    rfread0_up_Decoder_IMMSEL;
  wire                rfread0_up_isValid;
  wire       [31:0]   rfread0_down_Decoder_INSTRUCTION;
  reg                 _zz_d0_haltRequest_scheduler_l87;
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
  reg        [1:0]    dis0_up_Decoder_EXECUTION_UNIT;
  reg                 dis0_down_Dispatch_SENDTOALU;
  wire       [4:0]    d0_down_Decoder_RS2;
  wire       [4:0]    d0_down_Decoder_RS1;
  wire       [4:0]    d0_down_Decoder_RD;
  wire       [0:0]    d0_down_Decoder_IS_W;
  wire       [0:0]    d0_down_Decoder_IS_BR;
  wire       [3:0]    d0_down_Decoder_ALUOP;
  wire       [1:0]    d0_down_Decoder_IMMSEL;
  wire       [0:0]    d0_down_Decoder_FSR3EN;
  wire       [2:0]    d0_down_Decoder_RS2TYPE;
  wire       [2:0]    d0_down_Decoder_RS1TYPE;
  wire       [1:0]    d0_down_Decoder_RDTYPE;
  wire       [1:0]    d0_down_Decoder_EXECUTION_UNIT;
  wire       [0:0]    d0_down_Decoder_IS_FP;
  wire                d0_up_isFiring;
  reg        [31:0]   d0_up_Decoder_INSTRUCTION;
  wire       [31:0]   fetch_down_Decoder_INSTRUCTION;
  wire       [7:0]    fetch_down_PC;
  wire                fetch_up_isFiring;
  wire                fetch_up_valid;
  wire       [7:0]    fetch_up_PC;
  reg        [7:0]    fetcher_pcReg;
  reg        [63:0]   fetcher_fail_test_reg;
  reg        [63:0]   fetcher_pass_test_reg;
  wire                fetch_haltRequest_nebulainorder_l78;
  wire       [31:0]   fetcher_instrn;
  reg        [0:0]    decoder_ctrlSigs_is_fp;
  reg        [1:0]    decoder_ctrlSigs_execution_unit;
  reg        [1:0]    decoder_ctrlSigs_rdtype;
  reg        [2:0]    decoder_ctrlSigs_rs1type;
  reg        [2:0]    decoder_ctrlSigs_rs2type;
  reg        [0:0]    decoder_ctrlSigs_fsr3en;
  reg        [1:0]    decoder_ctrlSigs_immSel;
  reg        [3:0]    decoder_ctrlSigs_aluop;
  reg        [0:0]    decoder_ctrlSigs_is_br;
  reg        [0:0]    decoder_ctrlSigs_is_w;
  wire                decoder_trap_shouldHalt;
  wire                _zz_decoder_trap_shouldHalt;
  wire                d0_haltRequest_Decode_l119;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_fp;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_fp_1;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_fp_2;
  wire       [1:0]    _zz_decoder_ctrlSigs_execution_unit;
  wire       [1:0]    _zz_decoder_ctrlSigs_execution_unit_1;
  wire       [1:0]    _zz_decoder_ctrlSigs_execution_unit_2;
  wire                _zz_decoder_ctrlSigs_rdtype;
  wire       [1:0]    _zz_decoder_ctrlSigs_rdtype_1;
  wire       [1:0]    _zz_decoder_ctrlSigs_rdtype_2;
  wire       [1:0]    _zz_decoder_ctrlSigs_rdtype_3;
  wire       [2:0]    _zz_decoder_ctrlSigs_rs1type;
  wire       [2:0]    _zz_decoder_ctrlSigs_rs1type_1;
  wire       [2:0]    _zz_decoder_ctrlSigs_rs1type_2;
  wire                _zz_decoder_ctrlSigs_rs2type;
  wire       [2:0]    _zz_decoder_ctrlSigs_rs2type_1;
  wire       [2:0]    _zz_decoder_ctrlSigs_rs2type_2;
  wire       [2:0]    _zz_decoder_ctrlSigs_rs2type_3;
  wire       [0:0]    _zz_decoder_ctrlSigs_fsr3en;
  wire       [0:0]    _zz_decoder_ctrlSigs_fsr3en_1;
  wire       [0:0]    _zz_decoder_ctrlSigs_fsr3en_2;
  wire       [1:0]    _zz_decoder_ctrlSigs_immSel;
  wire       [1:0]    _zz_decoder_ctrlSigs_immSel_1;
  wire       [1:0]    _zz_decoder_ctrlSigs_immSel_2;
  wire                _zz_decoder_ctrlSigs_aluop;
  wire       [3:0]    _zz_decoder_ctrlSigs_aluop_1;
  wire       [3:0]    _zz_decoder_ctrlSigs_aluop_2;
  wire       [3:0]    _zz_decoder_ctrlSigs_aluop_3;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_br;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_br_1;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_br_2;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_w;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_w_1;
  wire       [0:0]    _zz_decoder_ctrlSigs_is_w_2;
  wire                when_scheduler_l128;
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
  wire                _zz_d0_haltRequest_scheduler_l73;
  wire                d0_haltRequest_scheduler_l73;
  wire                hazardChecker_isRs2Haz_0;
  wire                hazardChecker_isRs2Haz_1;
  wire                hazardChecker_isRs2Haz_2;
  wire                hazardChecker_isRs2Haz_3;
  wire                when_scheduler_l86;
  wire                d0_haltRequest_scheduler_l87;
  reg        [63:0]   srcPlugin_immsel_sext;
  reg        [63:0]   _zz_srcPlugin_immsel_sext;
  reg        [63:0]   _zz_rfread0_down_SrcPlugin_RS1;
  reg        [63:0]   _zz_rfread0_down_SrcPlugin_RS2;
  reg        [63:0]   intalu_aluNodeStage_logic_result;
  wire                when_IntAlu_l26;
  reg        [63:0]   _zz_intalu_aluNodeStage_logic_result;
  wire                when_IntAlu_l45;
  wire                when_IntAlu_l50;
  wire                when_IntAlu_l57;
  reg        [4:0]    wb_io_RD_address;
  reg                 wb_io_RD_Enable;
  reg        [63:0]   wb_io_RD_data;
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
  reg [7:0] decoder_ctrlSigs_is_fp_string;
  reg [23:0] decoder_ctrlSigs_execution_unit_string;
  reg [47:0] decoder_ctrlSigs_rdtype_string;
  reg [47:0] decoder_ctrlSigs_rs1type_string;
  reg [47:0] decoder_ctrlSigs_rs2type_string;
  reg [7:0] decoder_ctrlSigs_fsr3en_string;
  reg [39:0] decoder_ctrlSigs_immSel_string;
  reg [39:0] decoder_ctrlSigs_aluop_string;
  reg [7:0] decoder_ctrlSigs_is_br_string;
  reg [7:0] decoder_ctrlSigs_is_w_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_fp_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_fp_1_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_fp_2_string;
  reg [23:0] _zz_decoder_ctrlSigs_execution_unit_string;
  reg [23:0] _zz_decoder_ctrlSigs_execution_unit_1_string;
  reg [23:0] _zz_decoder_ctrlSigs_execution_unit_2_string;
  reg [47:0] _zz_decoder_ctrlSigs_rdtype_1_string;
  reg [47:0] _zz_decoder_ctrlSigs_rdtype_2_string;
  reg [47:0] _zz_decoder_ctrlSigs_rdtype_3_string;
  reg [47:0] _zz_decoder_ctrlSigs_rs1type_string;
  reg [47:0] _zz_decoder_ctrlSigs_rs1type_1_string;
  reg [47:0] _zz_decoder_ctrlSigs_rs1type_2_string;
  reg [47:0] _zz_decoder_ctrlSigs_rs2type_1_string;
  reg [47:0] _zz_decoder_ctrlSigs_rs2type_2_string;
  reg [47:0] _zz_decoder_ctrlSigs_rs2type_3_string;
  reg [7:0] _zz_decoder_ctrlSigs_fsr3en_string;
  reg [7:0] _zz_decoder_ctrlSigs_fsr3en_1_string;
  reg [7:0] _zz_decoder_ctrlSigs_fsr3en_2_string;
  reg [39:0] _zz_decoder_ctrlSigs_immSel_string;
  reg [39:0] _zz_decoder_ctrlSigs_immSel_1_string;
  reg [39:0] _zz_decoder_ctrlSigs_immSel_2_string;
  reg [39:0] _zz_decoder_ctrlSigs_aluop_1_string;
  reg [39:0] _zz_decoder_ctrlSigs_aluop_2_string;
  reg [39:0] _zz_decoder_ctrlSigs_aluop_3_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_br_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_br_1_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_br_2_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_w_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_w_1_string;
  reg [7:0] _zz_decoder_ctrlSigs_is_w_2_string;
  `endif

  reg [31:0] fetcher_mem [0:255];
  (* ram_style = "distributed" *) reg [63:0] intregFile_reggy_mem [0:31];

  assign _zz_decoder_trap_shouldHalt_1 = (|_zz_decoder_trap_shouldHalt);
  assign _zz__zz_srcPlugin_immsel_sext = rfread0_down_Decoder_INSTRUCTION[31 : 20];
  assign _zz__zz_srcPlugin_immsel_sext_1 = {rfread0_down_Decoder_INSTRUCTION[31 : 25],rfread0_down_Decoder_INSTRUCTION[11 : 7]};
  assign _zz__zz_srcPlugin_immsel_sext_2 = {{{{rfread0_down_Decoder_INSTRUCTION[31],rfread0_down_Decoder_INSTRUCTION[7]},rfread0_down_Decoder_INSTRUCTION[30 : 25]},rfread0_down_Decoder_INSTRUCTION[11 : 8]},1'b0};
  assign _zz__zz_intalu_aluNodeStage_logic_result = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_1) + $signed(_zz__zz_intalu_aluNodeStage_logic_result_2));
  assign _zz__zz_intalu_aluNodeStage_logic_result_1 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_2 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_intalu_aluNodeStage_logic_result_3 = (E1_down_SrcPlugin_RS1 <<< E1_down_SrcPlugin_RS2[4 : 0]);
  assign _zz__zz_intalu_aluNodeStage_logic_result_4 = (E1_down_SrcPlugin_RS1 >>> E1_down_SrcPlugin_RS2[4 : 0]);
  assign _zz__zz_intalu_aluNodeStage_logic_result_5 = (E1_down_SrcPlugin_RS1 >>> E1_down_SrcPlugin_RS2[4 : 0]);
  assign _zz__zz_intalu_aluNodeStage_logic_result_6 = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_7) - $signed(_zz__zz_intalu_aluNodeStage_logic_result_8));
  assign _zz__zz_intalu_aluNodeStage_logic_result_7 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_8 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_intalu_aluNodeStage_logic_result_10 = _zz__zz_intalu_aluNodeStage_logic_result_11[31 : 0];
  assign _zz__zz_intalu_aluNodeStage_logic_result_9 = {{32{_zz__zz_intalu_aluNodeStage_logic_result_10[31]}}, _zz__zz_intalu_aluNodeStage_logic_result_10};
  assign _zz__zz_intalu_aluNodeStage_logic_result_11 = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_12) + $signed(_zz__zz_intalu_aluNodeStage_logic_result_13));
  assign _zz__zz_intalu_aluNodeStage_logic_result_12 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_13 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_intalu_aluNodeStage_logic_result_15 = _zz__zz_intalu_aluNodeStage_logic_result_16[31 : 0];
  assign _zz__zz_intalu_aluNodeStage_logic_result_14 = {{32{_zz__zz_intalu_aluNodeStage_logic_result_15[31]}}, _zz__zz_intalu_aluNodeStage_logic_result_15};
  assign _zz__zz_intalu_aluNodeStage_logic_result_16 = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_17) + $signed(_zz__zz_intalu_aluNodeStage_logic_result_18));
  assign _zz__zz_intalu_aluNodeStage_logic_result_17 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_18 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_intalu_aluNodeStage_logic_result_20 = _zz__zz_intalu_aluNodeStage_logic_result_21[31 : 0];
  assign _zz__zz_intalu_aluNodeStage_logic_result_19 = {{32{_zz__zz_intalu_aluNodeStage_logic_result_20[31]}}, _zz__zz_intalu_aluNodeStage_logic_result_20};
  assign _zz__zz_intalu_aluNodeStage_logic_result_21 = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_22) + $signed(_zz__zz_intalu_aluNodeStage_logic_result_23));
  assign _zz__zz_intalu_aluNodeStage_logic_result_22 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_23 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_intalu_aluNodeStage_logic_result_25 = _zz__zz_intalu_aluNodeStage_logic_result_26[31 : 0];
  assign _zz__zz_intalu_aluNodeStage_logic_result_24 = {{32{_zz__zz_intalu_aluNodeStage_logic_result_25[31]}}, _zz__zz_intalu_aluNodeStage_logic_result_25};
  assign _zz__zz_intalu_aluNodeStage_logic_result_26 = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_27) + $signed(_zz__zz_intalu_aluNodeStage_logic_result_28));
  assign _zz__zz_intalu_aluNodeStage_logic_result_27 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_28 = E1_down_SrcPlugin_RS2;
  assign _zz__zz_intalu_aluNodeStage_logic_result_30 = _zz__zz_intalu_aluNodeStage_logic_result_31[31 : 0];
  assign _zz__zz_intalu_aluNodeStage_logic_result_29 = {{32{_zz__zz_intalu_aluNodeStage_logic_result_30[31]}}, _zz__zz_intalu_aluNodeStage_logic_result_30};
  assign _zz__zz_intalu_aluNodeStage_logic_result_31 = ($signed(_zz__zz_intalu_aluNodeStage_logic_result_32) - $signed(_zz__zz_intalu_aluNodeStage_logic_result_33));
  assign _zz__zz_intalu_aluNodeStage_logic_result_32 = E1_down_SrcPlugin_RS1;
  assign _zz__zz_intalu_aluNodeStage_logic_result_33 = E1_down_SrcPlugin_RS2;
  assign _zz_intalu_aluNodeStage_logic_result_1 = (_zz_intalu_aluNodeStage_logic_result_2[63] ? 1'b1 : 1'b0);
  assign _zz_intalu_aluNodeStage_logic_result_2 = ($signed(_zz_intalu_aluNodeStage_logic_result_3) - $signed(_zz_intalu_aluNodeStage_logic_result_4));
  assign _zz_intalu_aluNodeStage_logic_result_3 = E1_down_SrcPlugin_RS1;
  assign _zz_intalu_aluNodeStage_logic_result_4 = E1_down_SrcPlugin_RS2;
  assign _zz_intalu_aluNodeStage_logic_result_5 = (_zz_intalu_aluNodeStage_logic_result_6[63] ? 1'b1 : 1'b0);
  assign _zz_intalu_aluNodeStage_logic_result_6 = (E1_down_SrcPlugin_RS1 - E1_down_SrcPlugin_RS2);
  assign _zz_E1_down_Execute_RESULT = intalu_aluNodeStage_logic_result[31 : 0];
  assign _zz_intregFile_reggy_mem_port = (intregFile_io_RD_Enable && (! (intregFile_io_RD_address == 5'h0)));
  assign _zz__zz_decoder_ctrlSigs_aluop_2 = (d0_up_Decoder_INSTRUCTION & 32'h00000008);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_1 = 32'h00000008;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_2 = (d0_up_Decoder_INSTRUCTION & 32'h00003000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_3 = 32'h00003000;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_4 = ((d0_up_Decoder_INSTRUCTION & 32'h00004008) == 32'h00004008);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_5 = ((d0_up_Decoder_INSTRUCTION & _zz__zz_decoder_ctrlSigs_aluop_2_6) == 32'h00004000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_7 = {_zz_decoder_ctrlSigs_aluop,{_zz__zz_decoder_ctrlSigs_aluop_2_8,_zz__zz_decoder_ctrlSigs_aluop_2_9}};
  assign _zz__zz_decoder_ctrlSigs_aluop_2_10 = ((d0_up_Decoder_INSTRUCTION & _zz__zz_decoder_ctrlSigs_aluop_2_11) == 32'h00000008);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_12 = {(_zz__zz_decoder_ctrlSigs_aluop_2_13 == _zz__zz_decoder_ctrlSigs_aluop_2_14),{_zz__zz_decoder_ctrlSigs_aluop_2_15,{_zz__zz_decoder_ctrlSigs_aluop_2_16,_zz__zz_decoder_ctrlSigs_aluop_2_17}}};
  assign _zz__zz_decoder_ctrlSigs_aluop_2_18 = _zz_decoder_ctrlSigs_rdtype;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_19 = {(_zz__zz_decoder_ctrlSigs_aluop_2_20 == _zz__zz_decoder_ctrlSigs_aluop_2_21),{_zz_decoder_ctrlSigs_aluop,{_zz__zz_decoder_ctrlSigs_aluop_2_22,_zz__zz_decoder_ctrlSigs_aluop_2_23}}};
  assign _zz__zz_decoder_ctrlSigs_aluop_2_6 = 32'h00005000;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_8 = ((d0_up_Decoder_INSTRUCTION & 32'h40000028) == 32'h40000028);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_9 = ((d0_up_Decoder_INSTRUCTION & 32'h40006000) == 32'h40004000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_11 = 32'h00004008;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_13 = (d0_up_Decoder_INSTRUCTION & 32'h00007000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_14 = 32'h00004000;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_15 = ((d0_up_Decoder_INSTRUCTION & 32'h00007000) == 32'h00002000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_16 = ((d0_up_Decoder_INSTRUCTION & 32'h00007040) == 32'h00001000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_17 = ((d0_up_Decoder_INSTRUCTION & 32'h40006008) == 32'h00004000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_20 = (d0_up_Decoder_INSTRUCTION & 32'h00006000);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_21 = 32'h00006000;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_22 = ((d0_up_Decoder_INSTRUCTION & 32'h40001008) == 32'h00001008);
  assign _zz__zz_decoder_ctrlSigs_aluop_2_23 = {((d0_up_Decoder_INSTRUCTION & _zz__zz_decoder_ctrlSigs_aluop_2_24) == 32'h00005000),((d0_up_Decoder_INSTRUCTION & _zz__zz_decoder_ctrlSigs_aluop_2_25) == 32'h40000020)};
  assign _zz__zz_decoder_ctrlSigs_aluop_2_24 = 32'h40005000;
  assign _zz__zz_decoder_ctrlSigs_aluop_2_25 = 32'h40004028;
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
      AluOp_addw : rfread0_up_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : rfread0_up_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : rfread0_up_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : rfread0_up_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : rfread0_up_Decoder_ALUOP_string = "subw ";
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
      AluOp_addw : rfread0_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : rfread0_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : rfread0_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : rfread0_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : rfread0_down_Decoder_ALUOP_string = "subw ";
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
      AluOp_addw : dis0_up_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : dis0_up_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : dis0_up_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : dis0_up_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : dis0_up_Decoder_ALUOP_string = "subw ";
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
      AluOp_addw : dis0_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : dis0_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : dis0_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : dis0_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : dis0_down_Decoder_ALUOP_string = "subw ";
      default : dis0_down_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(dis0_up_Decoder_IMMSEL)
      Imm_Select_I_IMM : dis0_up_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : dis0_up_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_N_IMM : dis0_up_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_B_IMM : dis0_up_Decoder_IMMSEL_string = "B_IMM";
      default : dis0_up_Decoder_IMMSEL_string = "?????";
    endcase
  end
  always @(*) begin
    case(dis0_down_Decoder_IMMSEL)
      Imm_Select_I_IMM : dis0_down_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : dis0_down_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_N_IMM : dis0_down_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_B_IMM : dis0_down_Decoder_IMMSEL_string = "B_IMM";
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
      AluOp_addw : E1_up_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : E1_up_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : E1_up_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : E1_up_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : E1_up_Decoder_ALUOP_string = "subw ";
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
      Imm_Select_I_IMM : rfread0_up_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : rfread0_up_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_N_IMM : rfread0_up_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_B_IMM : rfread0_up_Decoder_IMMSEL_string = "B_IMM";
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
      AluOp_addw : d0_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : d0_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : d0_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : d0_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : d0_down_Decoder_ALUOP_string = "subw ";
      default : d0_down_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(d0_down_Decoder_IMMSEL)
      Imm_Select_I_IMM : d0_down_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : d0_down_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_N_IMM : d0_down_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_B_IMM : d0_down_Decoder_IMMSEL_string = "B_IMM";
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
    case(decoder_ctrlSigs_is_fp)
      YESNO_Y : decoder_ctrlSigs_is_fp_string = "Y";
      YESNO_N : decoder_ctrlSigs_is_fp_string = "N";
      default : decoder_ctrlSigs_is_fp_string = "?";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_execution_unit)
      ExecutionUnit_ALU : decoder_ctrlSigs_execution_unit_string = "ALU";
      ExecutionUnit_FPU : decoder_ctrlSigs_execution_unit_string = "FPU";
      ExecutionUnit_AGU : decoder_ctrlSigs_execution_unit_string = "AGU";
      default : decoder_ctrlSigs_execution_unit_string = "???";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_rdtype)
      RDTYPE_RD_INT : decoder_ctrlSigs_rdtype_string = "RD_INT";
      RDTYPE_RD_FP : decoder_ctrlSigs_rdtype_string = "RD_FP ";
      RDTYPE_RD_VEC : decoder_ctrlSigs_rdtype_string = "RD_VEC";
      RDTYPE_RD_NA : decoder_ctrlSigs_rdtype_string = "RD_NA ";
      default : decoder_ctrlSigs_rdtype_string = "??????";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_rs1type)
      RSTYPE_RS_INT : decoder_ctrlSigs_rs1type_string = "RS_INT";
      RSTYPE_RS_FP : decoder_ctrlSigs_rs1type_string = "RS_FP ";
      RSTYPE_RS_VEC : decoder_ctrlSigs_rs1type_string = "RS_VEC";
      RSTYPE_IMMED : decoder_ctrlSigs_rs1type_string = "IMMED ";
      RSTYPE_RS_NA : decoder_ctrlSigs_rs1type_string = "RS_NA ";
      default : decoder_ctrlSigs_rs1type_string = "??????";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_rs2type)
      RSTYPE_RS_INT : decoder_ctrlSigs_rs2type_string = "RS_INT";
      RSTYPE_RS_FP : decoder_ctrlSigs_rs2type_string = "RS_FP ";
      RSTYPE_RS_VEC : decoder_ctrlSigs_rs2type_string = "RS_VEC";
      RSTYPE_IMMED : decoder_ctrlSigs_rs2type_string = "IMMED ";
      RSTYPE_RS_NA : decoder_ctrlSigs_rs2type_string = "RS_NA ";
      default : decoder_ctrlSigs_rs2type_string = "??????";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_fsr3en)
      YESNO_Y : decoder_ctrlSigs_fsr3en_string = "Y";
      YESNO_N : decoder_ctrlSigs_fsr3en_string = "N";
      default : decoder_ctrlSigs_fsr3en_string = "?";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_immSel)
      Imm_Select_I_IMM : decoder_ctrlSigs_immSel_string = "I_IMM";
      Imm_Select_S_IMM : decoder_ctrlSigs_immSel_string = "S_IMM";
      Imm_Select_N_IMM : decoder_ctrlSigs_immSel_string = "N_IMM";
      Imm_Select_B_IMM : decoder_ctrlSigs_immSel_string = "B_IMM";
      default : decoder_ctrlSigs_immSel_string = "?????";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_aluop)
      AluOp_add : decoder_ctrlSigs_aluop_string = "add  ";
      AluOp_sub : decoder_ctrlSigs_aluop_string = "sub  ";
      AluOp_sll_1 : decoder_ctrlSigs_aluop_string = "sll_1";
      AluOp_srl_1 : decoder_ctrlSigs_aluop_string = "srl_1";
      AluOp_sra_1 : decoder_ctrlSigs_aluop_string = "sra_1";
      AluOp_or_1 : decoder_ctrlSigs_aluop_string = "or_1 ";
      AluOp_xor_1 : decoder_ctrlSigs_aluop_string = "xor_1";
      AluOp_slt : decoder_ctrlSigs_aluop_string = "slt  ";
      AluOp_sltu : decoder_ctrlSigs_aluop_string = "sltu ";
      AluOp_and_1 : decoder_ctrlSigs_aluop_string = "and_1";
      AluOp_addw : decoder_ctrlSigs_aluop_string = "addw ";
      AluOp_sllw : decoder_ctrlSigs_aluop_string = "sllw ";
      AluOp_sraw : decoder_ctrlSigs_aluop_string = "sraw ";
      AluOp_srlw : decoder_ctrlSigs_aluop_string = "srlw ";
      AluOp_subw : decoder_ctrlSigs_aluop_string = "subw ";
      default : decoder_ctrlSigs_aluop_string = "?????";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_is_br)
      YESNO_Y : decoder_ctrlSigs_is_br_string = "Y";
      YESNO_N : decoder_ctrlSigs_is_br_string = "N";
      default : decoder_ctrlSigs_is_br_string = "?";
    endcase
  end
  always @(*) begin
    case(decoder_ctrlSigs_is_w)
      YESNO_Y : decoder_ctrlSigs_is_w_string = "Y";
      YESNO_N : decoder_ctrlSigs_is_w_string = "N";
      default : decoder_ctrlSigs_is_w_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_fp)
      YESNO_Y : _zz_decoder_ctrlSigs_is_fp_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_fp_string = "N";
      default : _zz_decoder_ctrlSigs_is_fp_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_fp_1)
      YESNO_Y : _zz_decoder_ctrlSigs_is_fp_1_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_fp_1_string = "N";
      default : _zz_decoder_ctrlSigs_is_fp_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_fp_2)
      YESNO_Y : _zz_decoder_ctrlSigs_is_fp_2_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_fp_2_string = "N";
      default : _zz_decoder_ctrlSigs_is_fp_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_execution_unit)
      ExecutionUnit_ALU : _zz_decoder_ctrlSigs_execution_unit_string = "ALU";
      ExecutionUnit_FPU : _zz_decoder_ctrlSigs_execution_unit_string = "FPU";
      ExecutionUnit_AGU : _zz_decoder_ctrlSigs_execution_unit_string = "AGU";
      default : _zz_decoder_ctrlSigs_execution_unit_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_execution_unit_1)
      ExecutionUnit_ALU : _zz_decoder_ctrlSigs_execution_unit_1_string = "ALU";
      ExecutionUnit_FPU : _zz_decoder_ctrlSigs_execution_unit_1_string = "FPU";
      ExecutionUnit_AGU : _zz_decoder_ctrlSigs_execution_unit_1_string = "AGU";
      default : _zz_decoder_ctrlSigs_execution_unit_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_execution_unit_2)
      ExecutionUnit_ALU : _zz_decoder_ctrlSigs_execution_unit_2_string = "ALU";
      ExecutionUnit_FPU : _zz_decoder_ctrlSigs_execution_unit_2_string = "FPU";
      ExecutionUnit_AGU : _zz_decoder_ctrlSigs_execution_unit_2_string = "AGU";
      default : _zz_decoder_ctrlSigs_execution_unit_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rdtype_1)
      RDTYPE_RD_INT : _zz_decoder_ctrlSigs_rdtype_1_string = "RD_INT";
      RDTYPE_RD_FP : _zz_decoder_ctrlSigs_rdtype_1_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_decoder_ctrlSigs_rdtype_1_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_decoder_ctrlSigs_rdtype_1_string = "RD_NA ";
      default : _zz_decoder_ctrlSigs_rdtype_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rdtype_2)
      RDTYPE_RD_INT : _zz_decoder_ctrlSigs_rdtype_2_string = "RD_INT";
      RDTYPE_RD_FP : _zz_decoder_ctrlSigs_rdtype_2_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_decoder_ctrlSigs_rdtype_2_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_decoder_ctrlSigs_rdtype_2_string = "RD_NA ";
      default : _zz_decoder_ctrlSigs_rdtype_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rdtype_3)
      RDTYPE_RD_INT : _zz_decoder_ctrlSigs_rdtype_3_string = "RD_INT";
      RDTYPE_RD_FP : _zz_decoder_ctrlSigs_rdtype_3_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_decoder_ctrlSigs_rdtype_3_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_decoder_ctrlSigs_rdtype_3_string = "RD_NA ";
      default : _zz_decoder_ctrlSigs_rdtype_3_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rs1type)
      RSTYPE_RS_INT : _zz_decoder_ctrlSigs_rs1type_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decoder_ctrlSigs_rs1type_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decoder_ctrlSigs_rs1type_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decoder_ctrlSigs_rs1type_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decoder_ctrlSigs_rs1type_string = "RS_NA ";
      default : _zz_decoder_ctrlSigs_rs1type_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rs1type_1)
      RSTYPE_RS_INT : _zz_decoder_ctrlSigs_rs1type_1_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decoder_ctrlSigs_rs1type_1_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decoder_ctrlSigs_rs1type_1_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decoder_ctrlSigs_rs1type_1_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decoder_ctrlSigs_rs1type_1_string = "RS_NA ";
      default : _zz_decoder_ctrlSigs_rs1type_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rs1type_2)
      RSTYPE_RS_INT : _zz_decoder_ctrlSigs_rs1type_2_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decoder_ctrlSigs_rs1type_2_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decoder_ctrlSigs_rs1type_2_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decoder_ctrlSigs_rs1type_2_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decoder_ctrlSigs_rs1type_2_string = "RS_NA ";
      default : _zz_decoder_ctrlSigs_rs1type_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rs2type_1)
      RSTYPE_RS_INT : _zz_decoder_ctrlSigs_rs2type_1_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decoder_ctrlSigs_rs2type_1_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decoder_ctrlSigs_rs2type_1_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decoder_ctrlSigs_rs2type_1_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decoder_ctrlSigs_rs2type_1_string = "RS_NA ";
      default : _zz_decoder_ctrlSigs_rs2type_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rs2type_2)
      RSTYPE_RS_INT : _zz_decoder_ctrlSigs_rs2type_2_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decoder_ctrlSigs_rs2type_2_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decoder_ctrlSigs_rs2type_2_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decoder_ctrlSigs_rs2type_2_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decoder_ctrlSigs_rs2type_2_string = "RS_NA ";
      default : _zz_decoder_ctrlSigs_rs2type_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_rs2type_3)
      RSTYPE_RS_INT : _zz_decoder_ctrlSigs_rs2type_3_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decoder_ctrlSigs_rs2type_3_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decoder_ctrlSigs_rs2type_3_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decoder_ctrlSigs_rs2type_3_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decoder_ctrlSigs_rs2type_3_string = "RS_NA ";
      default : _zz_decoder_ctrlSigs_rs2type_3_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_fsr3en)
      YESNO_Y : _zz_decoder_ctrlSigs_fsr3en_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_fsr3en_string = "N";
      default : _zz_decoder_ctrlSigs_fsr3en_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_fsr3en_1)
      YESNO_Y : _zz_decoder_ctrlSigs_fsr3en_1_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_fsr3en_1_string = "N";
      default : _zz_decoder_ctrlSigs_fsr3en_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_fsr3en_2)
      YESNO_Y : _zz_decoder_ctrlSigs_fsr3en_2_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_fsr3en_2_string = "N";
      default : _zz_decoder_ctrlSigs_fsr3en_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_immSel)
      Imm_Select_I_IMM : _zz_decoder_ctrlSigs_immSel_string = "I_IMM";
      Imm_Select_S_IMM : _zz_decoder_ctrlSigs_immSel_string = "S_IMM";
      Imm_Select_N_IMM : _zz_decoder_ctrlSigs_immSel_string = "N_IMM";
      Imm_Select_B_IMM : _zz_decoder_ctrlSigs_immSel_string = "B_IMM";
      default : _zz_decoder_ctrlSigs_immSel_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_immSel_1)
      Imm_Select_I_IMM : _zz_decoder_ctrlSigs_immSel_1_string = "I_IMM";
      Imm_Select_S_IMM : _zz_decoder_ctrlSigs_immSel_1_string = "S_IMM";
      Imm_Select_N_IMM : _zz_decoder_ctrlSigs_immSel_1_string = "N_IMM";
      Imm_Select_B_IMM : _zz_decoder_ctrlSigs_immSel_1_string = "B_IMM";
      default : _zz_decoder_ctrlSigs_immSel_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_immSel_2)
      Imm_Select_I_IMM : _zz_decoder_ctrlSigs_immSel_2_string = "I_IMM";
      Imm_Select_S_IMM : _zz_decoder_ctrlSigs_immSel_2_string = "S_IMM";
      Imm_Select_N_IMM : _zz_decoder_ctrlSigs_immSel_2_string = "N_IMM";
      Imm_Select_B_IMM : _zz_decoder_ctrlSigs_immSel_2_string = "B_IMM";
      default : _zz_decoder_ctrlSigs_immSel_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_aluop_1)
      AluOp_add : _zz_decoder_ctrlSigs_aluop_1_string = "add  ";
      AluOp_sub : _zz_decoder_ctrlSigs_aluop_1_string = "sub  ";
      AluOp_sll_1 : _zz_decoder_ctrlSigs_aluop_1_string = "sll_1";
      AluOp_srl_1 : _zz_decoder_ctrlSigs_aluop_1_string = "srl_1";
      AluOp_sra_1 : _zz_decoder_ctrlSigs_aluop_1_string = "sra_1";
      AluOp_or_1 : _zz_decoder_ctrlSigs_aluop_1_string = "or_1 ";
      AluOp_xor_1 : _zz_decoder_ctrlSigs_aluop_1_string = "xor_1";
      AluOp_slt : _zz_decoder_ctrlSigs_aluop_1_string = "slt  ";
      AluOp_sltu : _zz_decoder_ctrlSigs_aluop_1_string = "sltu ";
      AluOp_and_1 : _zz_decoder_ctrlSigs_aluop_1_string = "and_1";
      AluOp_addw : _zz_decoder_ctrlSigs_aluop_1_string = "addw ";
      AluOp_sllw : _zz_decoder_ctrlSigs_aluop_1_string = "sllw ";
      AluOp_sraw : _zz_decoder_ctrlSigs_aluop_1_string = "sraw ";
      AluOp_srlw : _zz_decoder_ctrlSigs_aluop_1_string = "srlw ";
      AluOp_subw : _zz_decoder_ctrlSigs_aluop_1_string = "subw ";
      default : _zz_decoder_ctrlSigs_aluop_1_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_aluop_2)
      AluOp_add : _zz_decoder_ctrlSigs_aluop_2_string = "add  ";
      AluOp_sub : _zz_decoder_ctrlSigs_aluop_2_string = "sub  ";
      AluOp_sll_1 : _zz_decoder_ctrlSigs_aluop_2_string = "sll_1";
      AluOp_srl_1 : _zz_decoder_ctrlSigs_aluop_2_string = "srl_1";
      AluOp_sra_1 : _zz_decoder_ctrlSigs_aluop_2_string = "sra_1";
      AluOp_or_1 : _zz_decoder_ctrlSigs_aluop_2_string = "or_1 ";
      AluOp_xor_1 : _zz_decoder_ctrlSigs_aluop_2_string = "xor_1";
      AluOp_slt : _zz_decoder_ctrlSigs_aluop_2_string = "slt  ";
      AluOp_sltu : _zz_decoder_ctrlSigs_aluop_2_string = "sltu ";
      AluOp_and_1 : _zz_decoder_ctrlSigs_aluop_2_string = "and_1";
      AluOp_addw : _zz_decoder_ctrlSigs_aluop_2_string = "addw ";
      AluOp_sllw : _zz_decoder_ctrlSigs_aluop_2_string = "sllw ";
      AluOp_sraw : _zz_decoder_ctrlSigs_aluop_2_string = "sraw ";
      AluOp_srlw : _zz_decoder_ctrlSigs_aluop_2_string = "srlw ";
      AluOp_subw : _zz_decoder_ctrlSigs_aluop_2_string = "subw ";
      default : _zz_decoder_ctrlSigs_aluop_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_aluop_3)
      AluOp_add : _zz_decoder_ctrlSigs_aluop_3_string = "add  ";
      AluOp_sub : _zz_decoder_ctrlSigs_aluop_3_string = "sub  ";
      AluOp_sll_1 : _zz_decoder_ctrlSigs_aluop_3_string = "sll_1";
      AluOp_srl_1 : _zz_decoder_ctrlSigs_aluop_3_string = "srl_1";
      AluOp_sra_1 : _zz_decoder_ctrlSigs_aluop_3_string = "sra_1";
      AluOp_or_1 : _zz_decoder_ctrlSigs_aluop_3_string = "or_1 ";
      AluOp_xor_1 : _zz_decoder_ctrlSigs_aluop_3_string = "xor_1";
      AluOp_slt : _zz_decoder_ctrlSigs_aluop_3_string = "slt  ";
      AluOp_sltu : _zz_decoder_ctrlSigs_aluop_3_string = "sltu ";
      AluOp_and_1 : _zz_decoder_ctrlSigs_aluop_3_string = "and_1";
      AluOp_addw : _zz_decoder_ctrlSigs_aluop_3_string = "addw ";
      AluOp_sllw : _zz_decoder_ctrlSigs_aluop_3_string = "sllw ";
      AluOp_sraw : _zz_decoder_ctrlSigs_aluop_3_string = "sraw ";
      AluOp_srlw : _zz_decoder_ctrlSigs_aluop_3_string = "srlw ";
      AluOp_subw : _zz_decoder_ctrlSigs_aluop_3_string = "subw ";
      default : _zz_decoder_ctrlSigs_aluop_3_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_br)
      YESNO_Y : _zz_decoder_ctrlSigs_is_br_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_br_string = "N";
      default : _zz_decoder_ctrlSigs_is_br_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_br_1)
      YESNO_Y : _zz_decoder_ctrlSigs_is_br_1_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_br_1_string = "N";
      default : _zz_decoder_ctrlSigs_is_br_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_br_2)
      YESNO_Y : _zz_decoder_ctrlSigs_is_br_2_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_br_2_string = "N";
      default : _zz_decoder_ctrlSigs_is_br_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_w)
      YESNO_Y : _zz_decoder_ctrlSigs_is_w_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_w_string = "N";
      default : _zz_decoder_ctrlSigs_is_w_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_w_1)
      YESNO_Y : _zz_decoder_ctrlSigs_is_w_1_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_w_1_string = "N";
      default : _zz_decoder_ctrlSigs_is_w_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decoder_ctrlSigs_is_w_2)
      YESNO_Y : _zz_decoder_ctrlSigs_is_w_2_string = "Y";
      YESNO_N : _zz_decoder_ctrlSigs_is_w_2_string = "N";
      default : _zz_decoder_ctrlSigs_is_w_2_string = "?";
    endcase
  end
  `endif

  always @(*) begin
    _zz_d0_haltRequest_scheduler_l87 = 1'b0;
    if(when_scheduler_l86) begin
      _zz_d0_haltRequest_scheduler_l87 = 1'b1;
    end
  end

  assign fetch_up_PC = fetcher_pcReg;
  assign fetch_up_valid = 1'b1;
  assign fetch_haltRequest_nebulainorder_l78 = (fetch_down_PC == 8'hff);
  assign fetcher_instrn = fetcher_mem_spinal_port0;
  assign fetch_down_Decoder_INSTRUCTION = fetcher_mem_spinal_port1;
  assign _zz_decoder_trap_shouldHalt = ((d0_up_Decoder_INSTRUCTION & 32'h0) == 32'h0);
  assign decoder_trap_shouldHalt = (! _zz_decoder_trap_shouldHalt_1[0]);
  assign d0_haltRequest_Decode_l119 = decoder_trap_shouldHalt;
  always @(*) begin
    decoder_ctrlSigs_is_fp = (1'bx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_is_fp = _zz_decoder_ctrlSigs_is_fp_2;
    end
  end

  assign _zz_decoder_ctrlSigs_is_fp_1 = (|_zz_decoder_trap_shouldHalt);
  assign _zz_decoder_ctrlSigs_is_fp = _zz_decoder_ctrlSigs_is_fp_1;
  assign _zz_decoder_ctrlSigs_is_fp_2 = _zz_decoder_ctrlSigs_is_fp;
  always @(*) begin
    decoder_ctrlSigs_execution_unit = (2'bxx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_execution_unit = _zz_decoder_ctrlSigs_execution_unit_2;
    end
  end

  assign _zz_decoder_ctrlSigs_execution_unit_1 = {1'b0,1'b0};
  assign _zz_decoder_ctrlSigs_execution_unit = _zz_decoder_ctrlSigs_execution_unit_1;
  assign _zz_decoder_ctrlSigs_execution_unit_2 = _zz_decoder_ctrlSigs_execution_unit;
  always @(*) begin
    decoder_ctrlSigs_rdtype = (2'bxx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_rdtype = _zz_decoder_ctrlSigs_rdtype_3;
    end
  end

  assign _zz_decoder_ctrlSigs_rdtype = ((d0_up_Decoder_INSTRUCTION & 32'h00000010) == 32'h0);
  assign _zz_decoder_ctrlSigs_rdtype_2 = {(|_zz_decoder_ctrlSigs_rdtype),(|_zz_decoder_ctrlSigs_rdtype)};
  assign _zz_decoder_ctrlSigs_rdtype_1 = _zz_decoder_ctrlSigs_rdtype_2;
  assign _zz_decoder_ctrlSigs_rdtype_3 = _zz_decoder_ctrlSigs_rdtype_1;
  always @(*) begin
    decoder_ctrlSigs_rs1type = (3'bxxx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_rs1type = _zz_decoder_ctrlSigs_rs1type_2;
    end
  end

  assign _zz_decoder_ctrlSigs_rs1type_1 = {1'b0,{1'b0,1'b0}};
  assign _zz_decoder_ctrlSigs_rs1type = _zz_decoder_ctrlSigs_rs1type_1;
  assign _zz_decoder_ctrlSigs_rs1type_2 = _zz_decoder_ctrlSigs_rs1type;
  always @(*) begin
    decoder_ctrlSigs_rs2type = (3'bxxx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_rs2type = _zz_decoder_ctrlSigs_rs2type_3;
    end
  end

  assign _zz_decoder_ctrlSigs_rs2type = ((d0_up_Decoder_INSTRUCTION & 32'h00000020) == 32'h0);
  assign _zz_decoder_ctrlSigs_rs2type_2 = {1'b0,{(|_zz_decoder_ctrlSigs_rs2type),(|_zz_decoder_ctrlSigs_rs2type)}};
  assign _zz_decoder_ctrlSigs_rs2type_1 = _zz_decoder_ctrlSigs_rs2type_2;
  assign _zz_decoder_ctrlSigs_rs2type_3 = _zz_decoder_ctrlSigs_rs2type_1;
  always @(*) begin
    decoder_ctrlSigs_fsr3en = (1'bx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_fsr3en = _zz_decoder_ctrlSigs_fsr3en_2;
    end
  end

  assign _zz_decoder_ctrlSigs_fsr3en_1 = (|_zz_decoder_trap_shouldHalt);
  assign _zz_decoder_ctrlSigs_fsr3en = _zz_decoder_ctrlSigs_fsr3en_1;
  assign _zz_decoder_ctrlSigs_fsr3en_2 = _zz_decoder_ctrlSigs_fsr3en;
  always @(*) begin
    decoder_ctrlSigs_immSel = (2'bxx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_immSel = _zz_decoder_ctrlSigs_immSel_2;
    end
  end

  assign _zz_decoder_ctrlSigs_immSel_1 = {(|((d0_up_Decoder_INSTRUCTION & 32'h00000020) == 32'h00000020)),(|_zz_decoder_ctrlSigs_rdtype)};
  assign _zz_decoder_ctrlSigs_immSel = _zz_decoder_ctrlSigs_immSel_1;
  assign _zz_decoder_ctrlSigs_immSel_2 = _zz_decoder_ctrlSigs_immSel;
  always @(*) begin
    decoder_ctrlSigs_aluop = (4'bxxxx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_aluop = _zz_decoder_ctrlSigs_aluop_3;
    end
  end

  assign _zz_decoder_ctrlSigs_aluop = ((d0_up_Decoder_INSTRUCTION & 32'h00003000) == 32'h00002000);
  assign _zz_decoder_ctrlSigs_aluop_2 = {(|{(_zz__zz_decoder_ctrlSigs_aluop_2 == _zz__zz_decoder_ctrlSigs_aluop_2_1),(_zz__zz_decoder_ctrlSigs_aluop_2_2 == _zz__zz_decoder_ctrlSigs_aluop_2_3)}),{(|{_zz__zz_decoder_ctrlSigs_aluop_2_4,{_zz__zz_decoder_ctrlSigs_aluop_2_5,_zz__zz_decoder_ctrlSigs_aluop_2_7}}),{(|{_zz__zz_decoder_ctrlSigs_aluop_2_10,_zz__zz_decoder_ctrlSigs_aluop_2_12}),(|{_zz__zz_decoder_ctrlSigs_aluop_2_18,_zz__zz_decoder_ctrlSigs_aluop_2_19})}}};
  assign _zz_decoder_ctrlSigs_aluop_1 = _zz_decoder_ctrlSigs_aluop_2;
  assign _zz_decoder_ctrlSigs_aluop_3 = _zz_decoder_ctrlSigs_aluop_1;
  always @(*) begin
    decoder_ctrlSigs_is_br = (1'bx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_is_br = _zz_decoder_ctrlSigs_is_br_2;
    end
  end

  assign _zz_decoder_ctrlSigs_is_br_1 = (|((d0_up_Decoder_INSTRUCTION & 32'h00000040) == 32'h0));
  assign _zz_decoder_ctrlSigs_is_br = _zz_decoder_ctrlSigs_is_br_1;
  assign _zz_decoder_ctrlSigs_is_br_2 = _zz_decoder_ctrlSigs_is_br;
  always @(*) begin
    decoder_ctrlSigs_is_w = (1'bx);
    if(d0_up_isFiring) begin
      decoder_ctrlSigs_is_w = _zz_decoder_ctrlSigs_is_w_2;
    end
  end

  assign _zz_decoder_ctrlSigs_is_w_1 = (|((d0_up_Decoder_INSTRUCTION & 32'h00000008) == 32'h0));
  assign _zz_decoder_ctrlSigs_is_w = _zz_decoder_ctrlSigs_is_w_1;
  assign _zz_decoder_ctrlSigs_is_w_2 = _zz_decoder_ctrlSigs_is_w;
  assign d0_down_Decoder_IS_FP = decoder_ctrlSigs_is_fp;
  assign d0_down_Decoder_EXECUTION_UNIT = decoder_ctrlSigs_execution_unit;
  assign d0_down_Decoder_RDTYPE = decoder_ctrlSigs_rdtype;
  assign d0_down_Decoder_RS1TYPE = decoder_ctrlSigs_rs1type;
  assign d0_down_Decoder_RS2TYPE = decoder_ctrlSigs_rs2type;
  assign d0_down_Decoder_FSR3EN = decoder_ctrlSigs_fsr3en;
  assign d0_down_Decoder_IMMSEL = decoder_ctrlSigs_immSel;
  assign d0_down_Decoder_ALUOP = decoder_ctrlSigs_aluop;
  assign d0_down_Decoder_IS_BR = decoder_ctrlSigs_is_br;
  assign d0_down_Decoder_IS_W = decoder_ctrlSigs_is_w;
  assign d0_down_Decoder_RD = d0_up_Decoder_INSTRUCTION[11 : 7];
  assign d0_down_Decoder_RS1 = d0_up_Decoder_INSTRUCTION[19 : 15];
  assign d0_down_Decoder_RS2 = d0_up_Decoder_INSTRUCTION[24 : 20];
  always @(*) begin
    dis0_down_Dispatch_SENDTOALU = 1'b0;
    if(when_scheduler_l128) begin
      dis0_down_Dispatch_SENDTOALU = 1'b1;
    end
  end

  assign when_scheduler_l128 = ((dis0_up_Decoder_EXECUTION_UNIT == ExecutionUnit_ALU) && dis0_up_isValid);
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
  assign _zz_d0_haltRequest_scheduler_l73 = (((hazardChecker_isRs1Haz_0 || hazardChecker_isRs1Haz_1) || hazardChecker_isRs1Haz_2) || hazardChecker_isRs1Haz_3);
  assign d0_haltRequest_scheduler_l73 = _zz_d0_haltRequest_scheduler_l73;
  assign hazardChecker_isRs2Haz_0 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == dis0_down_Decoder_RD)) && (dis0_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs2Haz_1 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == rfread0_down_Decoder_RD)) && (rfread0_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs2Haz_2 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == E1_down_Decoder_RD)) && (E1_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign hazardChecker_isRs2Haz_3 = (((d0_down_Decoder_RS2 != 5'h0) && (d0_down_Decoder_RS2 == wbStage_down_Decoder_RD)) && (wbStage_up_Decoder_RDTYPE == RDTYPE_RD_INT));
  assign when_scheduler_l86 = (((hazardChecker_isRs2Haz_0 || hazardChecker_isRs2Haz_1) || hazardChecker_isRs2Haz_2) || hazardChecker_isRs2Haz_3);
  assign d0_haltRequest_scheduler_l87 = _zz_d0_haltRequest_scheduler_l87;
  always @(*) begin
    srcPlugin_immsel_sext = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      srcPlugin_immsel_sext = _zz_srcPlugin_immsel_sext;
    end
  end

  always @(*) begin
    _zz_srcPlugin_immsel_sext = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(rfread0_up_Decoder_IMMSEL)
      Imm_Select_I_IMM : begin
        _zz_srcPlugin_immsel_sext = {{52{_zz__zz_srcPlugin_immsel_sext[11]}}, _zz__zz_srcPlugin_immsel_sext};
      end
      Imm_Select_S_IMM : begin
        _zz_srcPlugin_immsel_sext = {{52{_zz__zz_srcPlugin_immsel_sext_1[11]}}, _zz__zz_srcPlugin_immsel_sext_1};
      end
      Imm_Select_B_IMM : begin
        _zz_srcPlugin_immsel_sext = {{51{_zz__zz_srcPlugin_immsel_sext_2[12]}}, _zz__zz_srcPlugin_immsel_sext_2};
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    rfread0_down_SrcPlugin_RS1 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      rfread0_down_SrcPlugin_RS1 = _zz_rfread0_down_SrcPlugin_RS1;
    end
  end

  always @(*) begin
    rfread0_down_SrcPlugin_RS2 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(rfread0_up_isValid) begin
      rfread0_down_SrcPlugin_RS2 = _zz_rfread0_down_SrcPlugin_RS2;
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

  assign E1_down_intalu_BR_EQ = (E1_down_SrcPlugin_RS1 == E1_down_SrcPlugin_RS2);
  always @(*) begin
    intalu_aluNodeStage_logic_result = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_IntAlu_l26) begin
      intalu_aluNodeStage_logic_result = _zz_intalu_aluNodeStage_logic_result;
    end
    if(when_IntAlu_l45) begin
      intalu_aluNodeStage_logic_result = {63'd0, _zz_intalu_aluNodeStage_logic_result_1};
    end
    if(when_IntAlu_l50) begin
      intalu_aluNodeStage_logic_result = {63'd0, _zz_intalu_aluNodeStage_logic_result_5};
    end
  end

  assign when_IntAlu_l26 = ((E1_up_Dispatch_SENDTOALU == 1'b1) && E1_up_isValid);
  always @(*) begin
    _zz_intalu_aluNodeStage_logic_result = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(E1_up_Decoder_ALUOP)
      AluOp_xor_1 : begin
        _zz_intalu_aluNodeStage_logic_result = (E1_up_SrcPlugin_RS1 ^ E1_up_SrcPlugin_RS2);
      end
      AluOp_or_1 : begin
        _zz_intalu_aluNodeStage_logic_result = (E1_down_SrcPlugin_RS1 | E1_down_SrcPlugin_RS2);
      end
      AluOp_and_1 : begin
        _zz_intalu_aluNodeStage_logic_result = (E1_down_SrcPlugin_RS1 & E1_down_SrcPlugin_RS2);
      end
      AluOp_add : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result;
      end
      AluOp_sll_1 : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_3;
      end
      AluOp_srl_1 : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_4;
      end
      AluOp_sra_1 : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_5;
      end
      AluOp_sub : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_6;
      end
      AluOp_addw : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_9;
      end
      AluOp_sllw : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_14;
      end
      AluOp_sraw : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_19;
      end
      AluOp_srlw : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_24;
      end
      AluOp_subw : begin
        _zz_intalu_aluNodeStage_logic_result = _zz__zz_intalu_aluNodeStage_logic_result_29;
      end
      default : begin
      end
    endcase
  end

  assign when_IntAlu_l45 = (E1_up_Decoder_ALUOP == AluOp_slt);
  assign when_IntAlu_l50 = (E1_up_Decoder_ALUOP == AluOp_sltu);
  always @(*) begin
    E1_down_Execute_RESULT = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(E1_up_isFiring) begin
      if(when_IntAlu_l57) begin
        E1_down_Execute_RESULT = {32'd0, _zz_E1_down_Execute_RESULT};
      end else begin
        E1_down_Execute_RESULT = intalu_aluNodeStage_logic_result;
      end
    end
  end

  assign when_IntAlu_l57 = (E1_up_Decoder_IS_W == YESNO_Y);
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

  assign when_CtrlLink_l150 = (|fetch_haltRequest_nebulainorder_l78);
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

  assign when_CtrlLink_l150_1 = (|{d0_haltRequest_scheduler_l87,{d0_haltRequest_scheduler_l73,d0_haltRequest_Decode_l119}});
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
  assign E1_down_valid = E1_up_valid;
  assign E1_down_Decoder_RDTYPE = E1_up_Decoder_RDTYPE;
  assign E1_down_Decoder_RD = E1_up_Decoder_RD;
  assign E1_down_SrcPlugin_RS1 = E1_up_SrcPlugin_RS1;
  assign E1_down_SrcPlugin_RS2 = E1_up_SrcPlugin_RS2;
  assign wbStage_down_valid = wbStage_up_valid;
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
      fetcher_pcReg <= 8'h0;
      d0_up_valid <= 1'b0;
      dis0_up_valid <= 1'b0;
      rfread0_up_valid <= 1'b0;
      E1_up_valid <= 1'b0;
      wbStage_up_valid <= 1'b0;
    end else begin
      if(fetch_up_isFiring) begin
        fetcher_pcReg <= (fetch_down_PC + 8'h01);
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
    E1_up_Decoder_RDTYPE <= rfread0_down_Decoder_RDTYPE;
    E1_up_Decoder_ALUOP <= rfread0_down_Decoder_ALUOP;
    E1_up_Decoder_IS_W <= rfread0_down_Decoder_IS_W;
    E1_up_Decoder_RD <= rfread0_down_Decoder_RD;
    E1_up_Dispatch_SENDTOALU <= rfread0_down_Dispatch_SENDTOALU;
    E1_up_SrcPlugin_RS1 <= rfread0_down_SrcPlugin_RS1;
    E1_up_SrcPlugin_RS2 <= rfread0_down_SrcPlugin_RS2;
    wbStage_up_Decoder_RDTYPE <= E1_down_Decoder_RDTYPE;
    wbStage_up_Decoder_RD <= E1_down_Decoder_RD;
    wbStage_up_Execute_RESULT <= E1_down_Execute_RESULT;
  end


endmodule

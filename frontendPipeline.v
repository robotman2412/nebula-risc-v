// Generator : SpinalHDL v1.10.2    git head : 279867b771fb50fc0aec21d8a20d8fdad0f87e3f
// Component : frontendPipeline
// Git hash  : e19e64bb140d9f61dd9ab4bbd0d8d2224ed11bdf

`timescale 1ns/1ps

module frontendPipeline (
  input  wire          clk,
  input  wire          reset
);
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
  localparam RDTYPE_RD_INT = 2'd0;
  localparam RDTYPE_RD_FP = 2'd1;
  localparam RDTYPE_RD_VEC = 2'd2;
  localparam RDTYPE_RD_NA = 2'd3;
  localparam ExecutionUnit_ALU = 3'd0;
  localparam ExecutionUnit_FPU = 3'd1;
  localparam ExecutionUnit_AGU = 3'd2;
  localparam ExecutionUnit_BR = 3'd3;
  localparam ExecutionUnit_NA = 3'd4;
  localparam mainMemory_controller_enumDef_BOOT = 2'd0;
  localparam mainMemory_controller_enumDef_stateA = 2'd1;
  localparam mainMemory_controller_enumDef_stateB = 2'd2;

  wire       [63:0]   icache_mem_spinal_port0;
  wire       [54:0]   icache_tagBank_spinal_port0;
  reg        [63:0]   mainMemory_memory_spinal_port0;
  wire       [63:0]   _zz_PC_pclogic_pcReg;
  wire       [54:0]   _zz_icache_tagBank_port;
  wire       [0:0]    _zz_decoder_trap_shouldHalt;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_1;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_2;
  wire       [3:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_3;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_4;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_5;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_6;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_7;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_8;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_9;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_10;
  wire       [5:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_11;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_12;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_13;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_14;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_15;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_16;
  wire       [2:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_17;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_18;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_19;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_20;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_21;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_22;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_23;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_24;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_25;
  wire       [6:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_26;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_27;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_28;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_29;
  wire       [3:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_30;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_31;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_32;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_33;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_34;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_35;
  wire       [1:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_36;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_37;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_38;
  wire       [8:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_39;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_40;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_41;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_42;
  wire       [5:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_43;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_44;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_45;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_46;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_47;
  wire       [31:0]   _zz__zz_decodeNode_down_Decoder_ALUOP_6_48;
  wire       [3:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_49;
  wire                _zz__zz_decodeNode_down_Decoder_ALUOP_6_50;
  wire       [0:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_51;
  wire       [1:0]    _zz__zz_decodeNode_down_Decoder_ALUOP_6_52;
  wire                _zz_mainMemory_memory_port;
  wire                _zz_mainMemory_bus_ramFetchRsp_payload_data;
  wire                decodeNode_up_isReady;
  wire                decodeNode_up_isValid;
  wire                pcNode_up_isReady;
  wire                pcNode_up_isValid;
  wire                icacheNode_down_isValid;
  wire                icacheNode_up_isValid;
  wire                pcNode_down_isValid;
  reg                 icacheNode_up_PC_VALIDCACHEREAD;
  reg        [63:0]   icacheNode_up_PC_PCVal;
  wire                icacheNode_down_isReady;
  wire                pcNode_down_isReady;
  wire                decodeNode_down_valid;
  reg                 decodeNode_up_valid;
  reg                 icacheNode_down_valid;
  reg                 icacheNode_up_valid;
  reg                 pcNode_down_valid;
  reg                 pcNode_up_ready;
  reg                 pcNode_down_ready;
  reg                 icacheNode_up_ready;
  wire       [4:0]    decodeNode_down_Decoder_RS2;
  wire       [4:0]    decodeNode_down_Decoder_RS1;
  wire       [4:0]    decodeNode_down_Decoder_RD;
  reg        [0:0]    decodeNode_down_Decoder_IS_W;
  reg        [0:0]    decodeNode_down_Decoder_IS_BR;
  reg        [4:0]    decodeNode_down_Decoder_ALUOP;
  reg        [2:0]    decodeNode_down_Decoder_IMMSEL;
  reg        [0:0]    decodeNode_down_Decoder_FSR3EN;
  reg        [2:0]    decodeNode_down_Decoder_RS2TYPE;
  reg        [2:0]    decodeNode_down_Decoder_RS1TYPE;
  reg        [1:0]    decodeNode_down_Decoder_RDTYPE;
  reg        [2:0]    decodeNode_down_Decoder_EXECUTION_UNIT;
  reg        [0:0]    decodeNode_down_Decoder_IS_FP;
  reg        [31:0]   decodeNode_up_Decoder_INSTRUCTION;
  wire                decodeNode_up_isFiring;
  reg        [0:0]    decodeNode_down_Decoder_LEGAL;
  wire       [31:0]   decodeNode_down_Decoder_INSTRUCTION;
  reg                 _zz_1;
  reg                 _zz_2;
  reg                 _zz_icacheNode_haltRequest_iCache_l83;
  wire                icacheNode_down_PC_VALIDCACHEREAD;
  reg        [31:0]   icacheNode_down_Decoder_INSTRUCTION;
  wire       [63:0]   icacheNode_down_PC_PCVal;
  wire                pcNode_up_isFiring;
  reg                 pcNode_down_PC_VALIDCACHEREAD;
  wire                pcNode_up_valid;
  wire       [63:0]   pcNode_up_PC_PCVal;
  wire       [63:0]   pcNode_down_PC_PCVal;
  wire       [63:0]   pcNode_down_PC_PCPLUS4;
  wire                PC_jumpCmd_valid;
  wire       [63:0]   PC_jumpCmd_payload_address;
  wire                PC_jumpcmd_valid_1;
  wire       [63:0]   PC_jumpcmd_payload_address_1;
  wire                PC_cacheReadCmd_valid;
  wire                PC_cacheReadCmd_ready;
  wire       [63:0]   PC_cacheReadCmd_payload_address;
  reg        [63:0]   PC_pclogic_pcReg;
  wire                icache_l1bus_cmd_valid;
  reg                 icache_l1bus_cmd_ready;
  wire       [63:0]   icache_l1bus_cmd_payload_address;
  reg                 icache_l1bus_rsp_valid;
  wire                icache_l1bus_rsp_ready;
  reg                 icache_l1bus_rsp_payload_miss;
  reg        [31:0]   icache_l1bus_rsp_payload_data;
  reg                 icache_ramBus_ramFetchCmd_valid;
  wire                icache_ramBus_ramFetchCmd_ready;
  reg        [63:0]   icache_ramBus_ramFetchCmd_payload_address;
  wire                icache_ramBus_ramFetchRsp_valid;
  reg                 icache_ramBus_ramFetchRsp_ready;
  wire       [63:0]   icache_ramBus_ramFetchRsp_payload_address;
  wire       [63:0]   icache_ramBus_ramFetchRsp_payload_data;
  wire                icache_ramBus_ramStoreCmd_valid;
  wire                icache_ramBus_ramStoreCmd_ready;
  wire       [63:0]   icache_ramBus_ramStoreCmd_payload_address;
  wire       [63:0]   icache_ramBus_ramStoreCmd_payload_data;
  wire                icache_ramBus_ramStoreRsp_valid;
  wire                icache_ramBus_ramStoreRsp_ready;
  wire                icache_ramBus_ramStoreRsp_payload_validStore;
  reg                 icache_haltPc;
  wire       [7:0]    icache_read_index;
  wire       [53:0]   icache_read_reqTag;
  wire                icache_read_tag_valid;
  wire       [53:0]   icache_read_tag_address;
  wire       [54:0]   _zz_icache_read_tag_valid;
  wire       [63:0]   icache_read_word;
  wire       [31:0]   icache_read_lowerHalf;
  wire       [31:0]   icache_read_upperHalf;
  wire                icache_read_hit;
  wire                icacheNode_haltRequest_iCache_l83;
  reg                 icache_refill_fetching;
  wire       [7:0]    _zz_5;
  wire                when_iCache_l118;
  wire                decoder_trap_shouldHalt;
  wire       [0:0]    _zz_decodeNode_down_Decoder_LEGAL;
  wire       [0:0]    _zz_decodeNode_down_Decoder_LEGAL_1;
  wire       [0:0]    _zz_decodeNode_down_Decoder_LEGAL_2;
  wire                _zz_decodeNode_down_Decoder_FSR3EN;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_FP;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_FP_1;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_FP_2;
  wire                _zz_decodeNode_down_Decoder_IS_W;
  wire       [2:0]    _zz_decodeNode_down_Decoder_EXECUTION_UNIT;
  wire       [2:0]    _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1;
  wire       [2:0]    _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2;
  wire                _zz_decodeNode_down_Decoder_IMMSEL;
  wire       [1:0]    _zz_decodeNode_down_Decoder_RDTYPE;
  wire       [1:0]    _zz_decodeNode_down_Decoder_RDTYPE_1;
  wire       [1:0]    _zz_decodeNode_down_Decoder_RDTYPE_2;
  wire       [2:0]    _zz_decodeNode_down_Decoder_RS1TYPE;
  wire       [2:0]    _zz_decodeNode_down_Decoder_RS1TYPE_1;
  wire       [2:0]    _zz_decodeNode_down_Decoder_RS1TYPE_2;
  wire                _zz_decodeNode_down_Decoder_ALUOP;
  wire                _zz_decodeNode_down_Decoder_IMMSEL_1;
  wire       [2:0]    _zz_decodeNode_down_Decoder_RS2TYPE;
  wire       [2:0]    _zz_decodeNode_down_Decoder_RS2TYPE_1;
  wire       [2:0]    _zz_decodeNode_down_Decoder_RS2TYPE_2;
  wire       [0:0]    _zz_decodeNode_down_Decoder_FSR3EN_1;
  wire       [0:0]    _zz_decodeNode_down_Decoder_FSR3EN_2;
  wire       [0:0]    _zz_decodeNode_down_Decoder_FSR3EN_3;
  wire                _zz_decodeNode_down_Decoder_ALUOP_1;
  wire       [2:0]    _zz_decodeNode_down_Decoder_IMMSEL_2;
  wire       [2:0]    _zz_decodeNode_down_Decoder_IMMSEL_3;
  wire       [2:0]    _zz_decodeNode_down_Decoder_IMMSEL_4;
  wire                _zz_decodeNode_down_Decoder_ALUOP_2;
  wire                _zz_decodeNode_down_Decoder_ALUOP_3;
  wire                _zz_decodeNode_down_Decoder_ALUOP_4;
  wire       [4:0]    _zz_decodeNode_down_Decoder_ALUOP_5;
  wire       [4:0]    _zz_decodeNode_down_Decoder_ALUOP_6;
  wire       [4:0]    _zz_decodeNode_down_Decoder_ALUOP_7;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_BR;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_BR_1;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_BR_2;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_W_1;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_W_2;
  wire       [0:0]    _zz_decodeNode_down_Decoder_IS_W_3;
  wire                pcNode_haltRequest_testfrontend_l20;
  wire                mainMemory_bus_ramFetchCmd_valid;
  reg                 mainMemory_bus_ramFetchCmd_ready;
  wire       [63:0]   mainMemory_bus_ramFetchCmd_payload_address;
  reg                 mainMemory_bus_ramFetchRsp_valid;
  wire                mainMemory_bus_ramFetchRsp_ready;
  reg        [63:0]   mainMemory_bus_ramFetchRsp_payload_address;
  reg        [63:0]   mainMemory_bus_ramFetchRsp_payload_data;
  wire                mainMemory_bus_ramStoreCmd_valid;
  wire                mainMemory_bus_ramStoreCmd_ready;
  wire       [63:0]   mainMemory_bus_ramStoreCmd_payload_address;
  wire       [63:0]   mainMemory_bus_ramStoreCmd_payload_data;
  wire                mainMemory_bus_ramStoreRsp_valid;
  wire                mainMemory_bus_ramStoreRsp_ready;
  wire                mainMemory_bus_ramStoreRsp_payload_validStore;
  wire       [9:0]    mainMemory_resizedAddress;
  wire                mainMemory_controller_wantExit;
  reg                 mainMemory_controller_wantStart;
  wire                mainMemory_controller_wantKill;
  wire                when_CtrlLink_l150;
  wire                when_CtrlLink_l150_1;
  wire                when_StageLink_l67;
  reg        [1:0]    mainMemory_controller_stateReg;
  reg        [1:0]    mainMemory_controller_stateNext;
  `ifndef SYNTHESIS
  reg [7:0] decodeNode_down_Decoder_IS_W_string;
  reg [7:0] decodeNode_down_Decoder_IS_BR_string;
  reg [39:0] decodeNode_down_Decoder_ALUOP_string;
  reg [39:0] decodeNode_down_Decoder_IMMSEL_string;
  reg [7:0] decodeNode_down_Decoder_FSR3EN_string;
  reg [47:0] decodeNode_down_Decoder_RS2TYPE_string;
  reg [47:0] decodeNode_down_Decoder_RS1TYPE_string;
  reg [47:0] decodeNode_down_Decoder_RDTYPE_string;
  reg [23:0] decodeNode_down_Decoder_EXECUTION_UNIT_string;
  reg [7:0] decodeNode_down_Decoder_IS_FP_string;
  reg [7:0] decodeNode_down_Decoder_LEGAL_string;
  reg [7:0] _zz_decodeNode_down_Decoder_LEGAL_string;
  reg [7:0] _zz_decodeNode_down_Decoder_LEGAL_1_string;
  reg [7:0] _zz_decodeNode_down_Decoder_LEGAL_2_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_FP_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_FP_1_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_FP_2_string;
  reg [23:0] _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string;
  reg [23:0] _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string;
  reg [23:0] _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RDTYPE_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RDTYPE_1_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RDTYPE_2_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RS1TYPE_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RS1TYPE_1_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RS1TYPE_2_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RS2TYPE_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RS2TYPE_1_string;
  reg [47:0] _zz_decodeNode_down_Decoder_RS2TYPE_2_string;
  reg [7:0] _zz_decodeNode_down_Decoder_FSR3EN_1_string;
  reg [7:0] _zz_decodeNode_down_Decoder_FSR3EN_2_string;
  reg [7:0] _zz_decodeNode_down_Decoder_FSR3EN_3_string;
  reg [39:0] _zz_decodeNode_down_Decoder_IMMSEL_2_string;
  reg [39:0] _zz_decodeNode_down_Decoder_IMMSEL_3_string;
  reg [39:0] _zz_decodeNode_down_Decoder_IMMSEL_4_string;
  reg [39:0] _zz_decodeNode_down_Decoder_ALUOP_5_string;
  reg [39:0] _zz_decodeNode_down_Decoder_ALUOP_6_string;
  reg [39:0] _zz_decodeNode_down_Decoder_ALUOP_7_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_BR_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_BR_1_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_BR_2_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_W_1_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_W_2_string;
  reg [7:0] _zz_decodeNode_down_Decoder_IS_W_3_string;
  reg [47:0] mainMemory_controller_stateReg_string;
  reg [47:0] mainMemory_controller_stateNext_string;
  `endif

  (* ram_style = "distributed" *) reg [63:0] icache_mem [0:255];
  (* ram_style = "distributed" *) reg [54:0] icache_tagBank [0:255];
  reg [63:0] mainMemory_memory [0:1023];

  assign _zz_PC_pclogic_pcReg = (pcNode_down_PC_PCVal + 64'h0000000000000004);
  assign _zz_decoder_trap_shouldHalt = (|((decodeNode_down_Decoder_INSTRUCTION & 32'h0) == 32'h0));
  assign _zz_icache_tagBank_port = {icache_l1bus_cmd_payload_address[63 : 10],1'b1};
  assign _zz_mainMemory_bus_ramFetchRsp_payload_data = 1'b1;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6 = (decodeNode_up_Decoder_INSTRUCTION & 32'h40004028);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_1 = 32'h40000028;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_2 = _zz_decodeNode_down_Decoder_ALUOP;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_3 = {(_zz__zz_decodeNode_down_Decoder_ALUOP_6_4 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_5),{_zz_decodeNode_down_Decoder_ALUOP_2,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_6,_zz__zz_decodeNode_down_Decoder_ALUOP_6_7}}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_10 = _zz_decodeNode_down_Decoder_ALUOP_4;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_11 = {_zz_decodeNode_down_Decoder_ALUOP_3,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_12,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_14,_zz__zz_decodeNode_down_Decoder_ALUOP_6_17}}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_26 = {_zz_decodeNode_down_Decoder_ALUOP,{_zz_decodeNode_down_Decoder_ALUOP_2,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_27,_zz__zz_decodeNode_down_Decoder_ALUOP_6_30}}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_39 = {_zz_decodeNode_down_Decoder_ALUOP_1,{_zz_decodeNode_down_Decoder_ALUOP,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_40,_zz__zz_decodeNode_down_Decoder_ALUOP_6_43}}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_4 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00003040);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_5 = 32'h00003000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_6 = _zz_decodeNode_down_Decoder_ALUOP_3;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_7 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_8 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_9);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_12 = ((decodeNode_up_Decoder_INSTRUCTION & _zz__zz_decodeNode_down_Decoder_ALUOP_6_13) == 32'h00001000);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_14 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_15 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_16);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_17 = {_zz__zz_decodeNode_down_Decoder_ALUOP_6_18,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_20,_zz__zz_decodeNode_down_Decoder_ALUOP_6_23}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_27 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_28 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_29);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_30 = {_zz__zz_decodeNode_down_Decoder_ALUOP_6_31,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_33,_zz__zz_decodeNode_down_Decoder_ALUOP_6_36}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_40 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_41 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_42);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_43 = {_zz__zz_decodeNode_down_Decoder_ALUOP_6_44,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_46,_zz__zz_decodeNode_down_Decoder_ALUOP_6_49}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_8 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00003018);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_9 = 32'h00002000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_13 = 32'h00001018;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_15 = (decodeNode_up_Decoder_INSTRUCTION & 32'h40006004);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_16 = 32'h40004000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_18 = ((decodeNode_up_Decoder_INSTRUCTION & _zz__zz_decodeNode_down_Decoder_ALUOP_6_19) == 32'h00002000);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_20 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_21 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_22);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_23 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_24 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_25);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_28 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00003018);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_29 = 32'h00003000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_31 = ((decodeNode_up_Decoder_INSTRUCTION & _zz__zz_decodeNode_down_Decoder_ALUOP_6_32) == 32'h00002000);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_33 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_34 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_35);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_36 = {_zz__zz_decodeNode_down_Decoder_ALUOP_6_37,_zz__zz_decodeNode_down_Decoder_ALUOP_6_38};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_41 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00006040);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_42 = 32'h00006000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_44 = ((decodeNode_up_Decoder_INSTRUCTION & _zz__zz_decodeNode_down_Decoder_ALUOP_6_45) == 32'h00001008);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_46 = (_zz__zz_decodeNode_down_Decoder_ALUOP_6_47 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_48);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_49 = {_zz__zz_decodeNode_down_Decoder_ALUOP_6_50,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_51,_zz__zz_decodeNode_down_Decoder_ALUOP_6_52}};
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_19 = 32'h00003044;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_21 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00006018);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_22 = 32'h00004000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_24 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00005044);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_25 = 32'h00004000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_32 = 32'h00007040;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_34 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00007040);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_35 = 32'h00004000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_37 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00003018) == 32'h0);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_38 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h40003048) == 32'h00001000);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_45 = 32'h40001008;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_47 = (decodeNode_up_Decoder_INSTRUCTION & 32'h00006010);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_48 = 32'h00004000;
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_50 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00003040) == 32'h00002000);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_51 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h40005040) == 32'h00005000);
  assign _zz__zz_decodeNode_down_Decoder_ALUOP_6_52 = {((decodeNode_up_Decoder_INSTRUCTION & 32'h00003014) == 32'h0),((decodeNode_up_Decoder_INSTRUCTION & 32'h40004068) == 32'h40000020)};
  assign icache_mem_spinal_port0 = icache_mem[icache_read_index];
  always @(posedge clk) begin
    if(_zz_2) begin
      icache_mem[_zz_5] <= icache_ramBus_ramFetchRsp_payload_data;
    end
  end

  assign icache_tagBank_spinal_port0 = icache_tagBank[icache_read_index];
  always @(posedge clk) begin
    if(_zz_1) begin
      icache_tagBank[_zz_5] <= _zz_icache_tagBank_port;
    end
  end

  always @(posedge clk) begin
    if(_zz_mainMemory_bus_ramFetchRsp_payload_data) begin
      mainMemory_memory_spinal_port0 <= mainMemory_memory[mainMemory_resizedAddress];
    end
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(decodeNode_down_Decoder_IS_W)
      YESNO_Y : decodeNode_down_Decoder_IS_W_string = "Y";
      YESNO_N : decodeNode_down_Decoder_IS_W_string = "N";
      default : decodeNode_down_Decoder_IS_W_string = "?";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_IS_BR)
      YESNO_Y : decodeNode_down_Decoder_IS_BR_string = "Y";
      YESNO_N : decodeNode_down_Decoder_IS_BR_string = "N";
      default : decodeNode_down_Decoder_IS_BR_string = "?";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_ALUOP)
      AluOp_add : decodeNode_down_Decoder_ALUOP_string = "add  ";
      AluOp_sub : decodeNode_down_Decoder_ALUOP_string = "sub  ";
      AluOp_sll_1 : decodeNode_down_Decoder_ALUOP_string = "sll_1";
      AluOp_srl_1 : decodeNode_down_Decoder_ALUOP_string = "srl_1";
      AluOp_sra_1 : decodeNode_down_Decoder_ALUOP_string = "sra_1";
      AluOp_or_1 : decodeNode_down_Decoder_ALUOP_string = "or_1 ";
      AluOp_xor_1 : decodeNode_down_Decoder_ALUOP_string = "xor_1";
      AluOp_slt : decodeNode_down_Decoder_ALUOP_string = "slt  ";
      AluOp_sltu : decodeNode_down_Decoder_ALUOP_string = "sltu ";
      AluOp_and_1 : decodeNode_down_Decoder_ALUOP_string = "and_1";
      AluOp_na : decodeNode_down_Decoder_ALUOP_string = "na   ";
      AluOp_lui : decodeNode_down_Decoder_ALUOP_string = "lui  ";
      AluOp_addw : decodeNode_down_Decoder_ALUOP_string = "addw ";
      AluOp_sllw : decodeNode_down_Decoder_ALUOP_string = "sllw ";
      AluOp_sraw : decodeNode_down_Decoder_ALUOP_string = "sraw ";
      AluOp_srlw : decodeNode_down_Decoder_ALUOP_string = "srlw ";
      AluOp_subw : decodeNode_down_Decoder_ALUOP_string = "subw ";
      AluOp_jal : decodeNode_down_Decoder_ALUOP_string = "jal  ";
      AluOp_jalr : decodeNode_down_Decoder_ALUOP_string = "jalr ";
      AluOp_beq : decodeNode_down_Decoder_ALUOP_string = "beq  ";
      AluOp_bne : decodeNode_down_Decoder_ALUOP_string = "bne  ";
      AluOp_bge : decodeNode_down_Decoder_ALUOP_string = "bge  ";
      AluOp_bgeu : decodeNode_down_Decoder_ALUOP_string = "bgeu ";
      AluOp_blt : decodeNode_down_Decoder_ALUOP_string = "blt  ";
      AluOp_bltu : decodeNode_down_Decoder_ALUOP_string = "bltu ";
      default : decodeNode_down_Decoder_ALUOP_string = "?????";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_IMMSEL)
      Imm_Select_N_IMM : decodeNode_down_Decoder_IMMSEL_string = "N_IMM";
      Imm_Select_I_IMM : decodeNode_down_Decoder_IMMSEL_string = "I_IMM";
      Imm_Select_S_IMM : decodeNode_down_Decoder_IMMSEL_string = "S_IMM";
      Imm_Select_B_IMM : decodeNode_down_Decoder_IMMSEL_string = "B_IMM";
      Imm_Select_U_IMM : decodeNode_down_Decoder_IMMSEL_string = "U_IMM";
      Imm_Select_J_IMM : decodeNode_down_Decoder_IMMSEL_string = "J_IMM";
      default : decodeNode_down_Decoder_IMMSEL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_FSR3EN)
      YESNO_Y : decodeNode_down_Decoder_FSR3EN_string = "Y";
      YESNO_N : decodeNode_down_Decoder_FSR3EN_string = "N";
      default : decodeNode_down_Decoder_FSR3EN_string = "?";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_RS2TYPE)
      RSTYPE_RS_INT : decodeNode_down_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : decodeNode_down_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : decodeNode_down_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : decodeNode_down_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : decodeNode_down_Decoder_RS2TYPE_string = "RS_NA ";
      default : decodeNode_down_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_RS1TYPE)
      RSTYPE_RS_INT : decodeNode_down_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : decodeNode_down_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : decodeNode_down_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : decodeNode_down_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : decodeNode_down_Decoder_RS1TYPE_string = "RS_NA ";
      default : decodeNode_down_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : decodeNode_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : decodeNode_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : decodeNode_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : decodeNode_down_Decoder_RDTYPE_string = "RD_NA ";
      default : decodeNode_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_EXECUTION_UNIT)
      ExecutionUnit_ALU : decodeNode_down_Decoder_EXECUTION_UNIT_string = "ALU";
      ExecutionUnit_FPU : decodeNode_down_Decoder_EXECUTION_UNIT_string = "FPU";
      ExecutionUnit_AGU : decodeNode_down_Decoder_EXECUTION_UNIT_string = "AGU";
      ExecutionUnit_BR : decodeNode_down_Decoder_EXECUTION_UNIT_string = "BR ";
      ExecutionUnit_NA : decodeNode_down_Decoder_EXECUTION_UNIT_string = "NA ";
      default : decodeNode_down_Decoder_EXECUTION_UNIT_string = "???";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_IS_FP)
      YESNO_Y : decodeNode_down_Decoder_IS_FP_string = "Y";
      YESNO_N : decodeNode_down_Decoder_IS_FP_string = "N";
      default : decodeNode_down_Decoder_IS_FP_string = "?";
    endcase
  end
  always @(*) begin
    case(decodeNode_down_Decoder_LEGAL)
      YESNO_Y : decodeNode_down_Decoder_LEGAL_string = "Y";
      YESNO_N : decodeNode_down_Decoder_LEGAL_string = "N";
      default : decodeNode_down_Decoder_LEGAL_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_LEGAL)
      YESNO_Y : _zz_decodeNode_down_Decoder_LEGAL_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_LEGAL_string = "N";
      default : _zz_decodeNode_down_Decoder_LEGAL_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_LEGAL_1)
      YESNO_Y : _zz_decodeNode_down_Decoder_LEGAL_1_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_LEGAL_1_string = "N";
      default : _zz_decodeNode_down_Decoder_LEGAL_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_LEGAL_2)
      YESNO_Y : _zz_decodeNode_down_Decoder_LEGAL_2_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_LEGAL_2_string = "N";
      default : _zz_decodeNode_down_Decoder_LEGAL_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_FP)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_FP_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_FP_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_FP_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_FP_1)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_FP_1_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_FP_1_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_FP_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_FP_2)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_FP_2_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_FP_2_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_FP_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_EXECUTION_UNIT)
      ExecutionUnit_ALU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string = "ALU";
      ExecutionUnit_FPU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string = "FPU";
      ExecutionUnit_AGU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string = "AGU";
      ExecutionUnit_BR : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string = "BR ";
      ExecutionUnit_NA : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string = "NA ";
      default : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_EXECUTION_UNIT_1)
      ExecutionUnit_ALU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string = "ALU";
      ExecutionUnit_FPU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string = "FPU";
      ExecutionUnit_AGU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string = "AGU";
      ExecutionUnit_BR : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string = "BR ";
      ExecutionUnit_NA : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string = "NA ";
      default : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_EXECUTION_UNIT_2)
      ExecutionUnit_ALU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string = "ALU";
      ExecutionUnit_FPU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string = "FPU";
      ExecutionUnit_AGU : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string = "AGU";
      ExecutionUnit_BR : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string = "BR ";
      ExecutionUnit_NA : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string = "NA ";
      default : _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RDTYPE)
      RDTYPE_RD_INT : _zz_decodeNode_down_Decoder_RDTYPE_string = "RD_INT";
      RDTYPE_RD_FP : _zz_decodeNode_down_Decoder_RDTYPE_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_decodeNode_down_Decoder_RDTYPE_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_decodeNode_down_Decoder_RDTYPE_string = "RD_NA ";
      default : _zz_decodeNode_down_Decoder_RDTYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RDTYPE_1)
      RDTYPE_RD_INT : _zz_decodeNode_down_Decoder_RDTYPE_1_string = "RD_INT";
      RDTYPE_RD_FP : _zz_decodeNode_down_Decoder_RDTYPE_1_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_decodeNode_down_Decoder_RDTYPE_1_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_decodeNode_down_Decoder_RDTYPE_1_string = "RD_NA ";
      default : _zz_decodeNode_down_Decoder_RDTYPE_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RDTYPE_2)
      RDTYPE_RD_INT : _zz_decodeNode_down_Decoder_RDTYPE_2_string = "RD_INT";
      RDTYPE_RD_FP : _zz_decodeNode_down_Decoder_RDTYPE_2_string = "RD_FP ";
      RDTYPE_RD_VEC : _zz_decodeNode_down_Decoder_RDTYPE_2_string = "RD_VEC";
      RDTYPE_RD_NA : _zz_decodeNode_down_Decoder_RDTYPE_2_string = "RD_NA ";
      default : _zz_decodeNode_down_Decoder_RDTYPE_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RS1TYPE)
      RSTYPE_RS_INT : _zz_decodeNode_down_Decoder_RS1TYPE_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decodeNode_down_Decoder_RS1TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decodeNode_down_Decoder_RS1TYPE_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decodeNode_down_Decoder_RS1TYPE_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decodeNode_down_Decoder_RS1TYPE_string = "RS_NA ";
      default : _zz_decodeNode_down_Decoder_RS1TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RS1TYPE_1)
      RSTYPE_RS_INT : _zz_decodeNode_down_Decoder_RS1TYPE_1_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decodeNode_down_Decoder_RS1TYPE_1_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decodeNode_down_Decoder_RS1TYPE_1_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decodeNode_down_Decoder_RS1TYPE_1_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decodeNode_down_Decoder_RS1TYPE_1_string = "RS_NA ";
      default : _zz_decodeNode_down_Decoder_RS1TYPE_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RS1TYPE_2)
      RSTYPE_RS_INT : _zz_decodeNode_down_Decoder_RS1TYPE_2_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decodeNode_down_Decoder_RS1TYPE_2_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decodeNode_down_Decoder_RS1TYPE_2_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decodeNode_down_Decoder_RS1TYPE_2_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decodeNode_down_Decoder_RS1TYPE_2_string = "RS_NA ";
      default : _zz_decodeNode_down_Decoder_RS1TYPE_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RS2TYPE)
      RSTYPE_RS_INT : _zz_decodeNode_down_Decoder_RS2TYPE_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decodeNode_down_Decoder_RS2TYPE_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decodeNode_down_Decoder_RS2TYPE_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decodeNode_down_Decoder_RS2TYPE_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decodeNode_down_Decoder_RS2TYPE_string = "RS_NA ";
      default : _zz_decodeNode_down_Decoder_RS2TYPE_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RS2TYPE_1)
      RSTYPE_RS_INT : _zz_decodeNode_down_Decoder_RS2TYPE_1_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decodeNode_down_Decoder_RS2TYPE_1_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decodeNode_down_Decoder_RS2TYPE_1_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decodeNode_down_Decoder_RS2TYPE_1_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decodeNode_down_Decoder_RS2TYPE_1_string = "RS_NA ";
      default : _zz_decodeNode_down_Decoder_RS2TYPE_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_RS2TYPE_2)
      RSTYPE_RS_INT : _zz_decodeNode_down_Decoder_RS2TYPE_2_string = "RS_INT";
      RSTYPE_RS_FP : _zz_decodeNode_down_Decoder_RS2TYPE_2_string = "RS_FP ";
      RSTYPE_RS_VEC : _zz_decodeNode_down_Decoder_RS2TYPE_2_string = "RS_VEC";
      RSTYPE_IMMED : _zz_decodeNode_down_Decoder_RS2TYPE_2_string = "IMMED ";
      RSTYPE_RS_NA : _zz_decodeNode_down_Decoder_RS2TYPE_2_string = "RS_NA ";
      default : _zz_decodeNode_down_Decoder_RS2TYPE_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_FSR3EN_1)
      YESNO_Y : _zz_decodeNode_down_Decoder_FSR3EN_1_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_FSR3EN_1_string = "N";
      default : _zz_decodeNode_down_Decoder_FSR3EN_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_FSR3EN_2)
      YESNO_Y : _zz_decodeNode_down_Decoder_FSR3EN_2_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_FSR3EN_2_string = "N";
      default : _zz_decodeNode_down_Decoder_FSR3EN_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_FSR3EN_3)
      YESNO_Y : _zz_decodeNode_down_Decoder_FSR3EN_3_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_FSR3EN_3_string = "N";
      default : _zz_decodeNode_down_Decoder_FSR3EN_3_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IMMSEL_2)
      Imm_Select_N_IMM : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "N_IMM";
      Imm_Select_I_IMM : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "I_IMM";
      Imm_Select_S_IMM : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "S_IMM";
      Imm_Select_B_IMM : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "B_IMM";
      Imm_Select_U_IMM : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "U_IMM";
      Imm_Select_J_IMM : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "J_IMM";
      default : _zz_decodeNode_down_Decoder_IMMSEL_2_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IMMSEL_3)
      Imm_Select_N_IMM : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "N_IMM";
      Imm_Select_I_IMM : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "I_IMM";
      Imm_Select_S_IMM : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "S_IMM";
      Imm_Select_B_IMM : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "B_IMM";
      Imm_Select_U_IMM : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "U_IMM";
      Imm_Select_J_IMM : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "J_IMM";
      default : _zz_decodeNode_down_Decoder_IMMSEL_3_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IMMSEL_4)
      Imm_Select_N_IMM : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "N_IMM";
      Imm_Select_I_IMM : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "I_IMM";
      Imm_Select_S_IMM : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "S_IMM";
      Imm_Select_B_IMM : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "B_IMM";
      Imm_Select_U_IMM : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "U_IMM";
      Imm_Select_J_IMM : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "J_IMM";
      default : _zz_decodeNode_down_Decoder_IMMSEL_4_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_ALUOP_5)
      AluOp_add : _zz_decodeNode_down_Decoder_ALUOP_5_string = "add  ";
      AluOp_sub : _zz_decodeNode_down_Decoder_ALUOP_5_string = "sub  ";
      AluOp_sll_1 : _zz_decodeNode_down_Decoder_ALUOP_5_string = "sll_1";
      AluOp_srl_1 : _zz_decodeNode_down_Decoder_ALUOP_5_string = "srl_1";
      AluOp_sra_1 : _zz_decodeNode_down_Decoder_ALUOP_5_string = "sra_1";
      AluOp_or_1 : _zz_decodeNode_down_Decoder_ALUOP_5_string = "or_1 ";
      AluOp_xor_1 : _zz_decodeNode_down_Decoder_ALUOP_5_string = "xor_1";
      AluOp_slt : _zz_decodeNode_down_Decoder_ALUOP_5_string = "slt  ";
      AluOp_sltu : _zz_decodeNode_down_Decoder_ALUOP_5_string = "sltu ";
      AluOp_and_1 : _zz_decodeNode_down_Decoder_ALUOP_5_string = "and_1";
      AluOp_na : _zz_decodeNode_down_Decoder_ALUOP_5_string = "na   ";
      AluOp_lui : _zz_decodeNode_down_Decoder_ALUOP_5_string = "lui  ";
      AluOp_addw : _zz_decodeNode_down_Decoder_ALUOP_5_string = "addw ";
      AluOp_sllw : _zz_decodeNode_down_Decoder_ALUOP_5_string = "sllw ";
      AluOp_sraw : _zz_decodeNode_down_Decoder_ALUOP_5_string = "sraw ";
      AluOp_srlw : _zz_decodeNode_down_Decoder_ALUOP_5_string = "srlw ";
      AluOp_subw : _zz_decodeNode_down_Decoder_ALUOP_5_string = "subw ";
      AluOp_jal : _zz_decodeNode_down_Decoder_ALUOP_5_string = "jal  ";
      AluOp_jalr : _zz_decodeNode_down_Decoder_ALUOP_5_string = "jalr ";
      AluOp_beq : _zz_decodeNode_down_Decoder_ALUOP_5_string = "beq  ";
      AluOp_bne : _zz_decodeNode_down_Decoder_ALUOP_5_string = "bne  ";
      AluOp_bge : _zz_decodeNode_down_Decoder_ALUOP_5_string = "bge  ";
      AluOp_bgeu : _zz_decodeNode_down_Decoder_ALUOP_5_string = "bgeu ";
      AluOp_blt : _zz_decodeNode_down_Decoder_ALUOP_5_string = "blt  ";
      AluOp_bltu : _zz_decodeNode_down_Decoder_ALUOP_5_string = "bltu ";
      default : _zz_decodeNode_down_Decoder_ALUOP_5_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_ALUOP_6)
      AluOp_add : _zz_decodeNode_down_Decoder_ALUOP_6_string = "add  ";
      AluOp_sub : _zz_decodeNode_down_Decoder_ALUOP_6_string = "sub  ";
      AluOp_sll_1 : _zz_decodeNode_down_Decoder_ALUOP_6_string = "sll_1";
      AluOp_srl_1 : _zz_decodeNode_down_Decoder_ALUOP_6_string = "srl_1";
      AluOp_sra_1 : _zz_decodeNode_down_Decoder_ALUOP_6_string = "sra_1";
      AluOp_or_1 : _zz_decodeNode_down_Decoder_ALUOP_6_string = "or_1 ";
      AluOp_xor_1 : _zz_decodeNode_down_Decoder_ALUOP_6_string = "xor_1";
      AluOp_slt : _zz_decodeNode_down_Decoder_ALUOP_6_string = "slt  ";
      AluOp_sltu : _zz_decodeNode_down_Decoder_ALUOP_6_string = "sltu ";
      AluOp_and_1 : _zz_decodeNode_down_Decoder_ALUOP_6_string = "and_1";
      AluOp_na : _zz_decodeNode_down_Decoder_ALUOP_6_string = "na   ";
      AluOp_lui : _zz_decodeNode_down_Decoder_ALUOP_6_string = "lui  ";
      AluOp_addw : _zz_decodeNode_down_Decoder_ALUOP_6_string = "addw ";
      AluOp_sllw : _zz_decodeNode_down_Decoder_ALUOP_6_string = "sllw ";
      AluOp_sraw : _zz_decodeNode_down_Decoder_ALUOP_6_string = "sraw ";
      AluOp_srlw : _zz_decodeNode_down_Decoder_ALUOP_6_string = "srlw ";
      AluOp_subw : _zz_decodeNode_down_Decoder_ALUOP_6_string = "subw ";
      AluOp_jal : _zz_decodeNode_down_Decoder_ALUOP_6_string = "jal  ";
      AluOp_jalr : _zz_decodeNode_down_Decoder_ALUOP_6_string = "jalr ";
      AluOp_beq : _zz_decodeNode_down_Decoder_ALUOP_6_string = "beq  ";
      AluOp_bne : _zz_decodeNode_down_Decoder_ALUOP_6_string = "bne  ";
      AluOp_bge : _zz_decodeNode_down_Decoder_ALUOP_6_string = "bge  ";
      AluOp_bgeu : _zz_decodeNode_down_Decoder_ALUOP_6_string = "bgeu ";
      AluOp_blt : _zz_decodeNode_down_Decoder_ALUOP_6_string = "blt  ";
      AluOp_bltu : _zz_decodeNode_down_Decoder_ALUOP_6_string = "bltu ";
      default : _zz_decodeNode_down_Decoder_ALUOP_6_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_ALUOP_7)
      AluOp_add : _zz_decodeNode_down_Decoder_ALUOP_7_string = "add  ";
      AluOp_sub : _zz_decodeNode_down_Decoder_ALUOP_7_string = "sub  ";
      AluOp_sll_1 : _zz_decodeNode_down_Decoder_ALUOP_7_string = "sll_1";
      AluOp_srl_1 : _zz_decodeNode_down_Decoder_ALUOP_7_string = "srl_1";
      AluOp_sra_1 : _zz_decodeNode_down_Decoder_ALUOP_7_string = "sra_1";
      AluOp_or_1 : _zz_decodeNode_down_Decoder_ALUOP_7_string = "or_1 ";
      AluOp_xor_1 : _zz_decodeNode_down_Decoder_ALUOP_7_string = "xor_1";
      AluOp_slt : _zz_decodeNode_down_Decoder_ALUOP_7_string = "slt  ";
      AluOp_sltu : _zz_decodeNode_down_Decoder_ALUOP_7_string = "sltu ";
      AluOp_and_1 : _zz_decodeNode_down_Decoder_ALUOP_7_string = "and_1";
      AluOp_na : _zz_decodeNode_down_Decoder_ALUOP_7_string = "na   ";
      AluOp_lui : _zz_decodeNode_down_Decoder_ALUOP_7_string = "lui  ";
      AluOp_addw : _zz_decodeNode_down_Decoder_ALUOP_7_string = "addw ";
      AluOp_sllw : _zz_decodeNode_down_Decoder_ALUOP_7_string = "sllw ";
      AluOp_sraw : _zz_decodeNode_down_Decoder_ALUOP_7_string = "sraw ";
      AluOp_srlw : _zz_decodeNode_down_Decoder_ALUOP_7_string = "srlw ";
      AluOp_subw : _zz_decodeNode_down_Decoder_ALUOP_7_string = "subw ";
      AluOp_jal : _zz_decodeNode_down_Decoder_ALUOP_7_string = "jal  ";
      AluOp_jalr : _zz_decodeNode_down_Decoder_ALUOP_7_string = "jalr ";
      AluOp_beq : _zz_decodeNode_down_Decoder_ALUOP_7_string = "beq  ";
      AluOp_bne : _zz_decodeNode_down_Decoder_ALUOP_7_string = "bne  ";
      AluOp_bge : _zz_decodeNode_down_Decoder_ALUOP_7_string = "bge  ";
      AluOp_bgeu : _zz_decodeNode_down_Decoder_ALUOP_7_string = "bgeu ";
      AluOp_blt : _zz_decodeNode_down_Decoder_ALUOP_7_string = "blt  ";
      AluOp_bltu : _zz_decodeNode_down_Decoder_ALUOP_7_string = "bltu ";
      default : _zz_decodeNode_down_Decoder_ALUOP_7_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_BR)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_BR_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_BR_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_BR_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_BR_1)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_BR_1_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_BR_1_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_BR_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_BR_2)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_BR_2_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_BR_2_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_BR_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_W_1)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_W_1_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_W_1_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_W_1_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_W_2)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_W_2_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_W_2_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_W_2_string = "?";
    endcase
  end
  always @(*) begin
    case(_zz_decodeNode_down_Decoder_IS_W_3)
      YESNO_Y : _zz_decodeNode_down_Decoder_IS_W_3_string = "Y";
      YESNO_N : _zz_decodeNode_down_Decoder_IS_W_3_string = "N";
      default : _zz_decodeNode_down_Decoder_IS_W_3_string = "?";
    endcase
  end
  always @(*) begin
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_BOOT : mainMemory_controller_stateReg_string = "BOOT  ";
      mainMemory_controller_enumDef_stateA : mainMemory_controller_stateReg_string = "stateA";
      mainMemory_controller_enumDef_stateB : mainMemory_controller_stateReg_string = "stateB";
      default : mainMemory_controller_stateReg_string = "??????";
    endcase
  end
  always @(*) begin
    case(mainMemory_controller_stateNext)
      mainMemory_controller_enumDef_BOOT : mainMemory_controller_stateNext_string = "BOOT  ";
      mainMemory_controller_enumDef_stateA : mainMemory_controller_stateNext_string = "stateA";
      mainMemory_controller_enumDef_stateB : mainMemory_controller_stateNext_string = "stateB";
      default : mainMemory_controller_stateNext_string = "??????";
    endcase
  end
  `endif

  always @(*) begin
    _zz_1 = 1'b0;
    if(icache_refill_fetching) begin
      if(icache_ramBus_ramFetchRsp_valid) begin
        _zz_1 = 1'b1;
      end
    end
  end

  always @(*) begin
    _zz_2 = 1'b0;
    if(icache_refill_fetching) begin
      if(icache_ramBus_ramFetchRsp_valid) begin
        _zz_2 = 1'b1;
      end
    end
  end

  always @(*) begin
    _zz_icacheNode_haltRequest_iCache_l83 = 1'b0;
    if(icache_l1bus_cmd_valid) begin
      if(!icache_read_hit) begin
        _zz_icacheNode_haltRequest_iCache_l83 = 1'b1;
      end
    end
  end

  assign PC_jumpcmd_valid_1 = 1'b0;
  assign PC_jumpcmd_payload_address_1 = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
  assign pcNode_up_PC_PCVal = PC_pclogic_pcReg;
  assign pcNode_down_PC_PCPLUS4 = (PC_pclogic_pcReg + 64'h0000000000000004);
  assign pcNode_up_valid = 1'b1;
  always @(*) begin
    pcNode_down_PC_VALIDCACHEREAD = 1'b0;
    if(pcNode_up_isFiring) begin
      pcNode_down_PC_VALIDCACHEREAD = 1'b1;
    end
  end

  assign icache_l1bus_cmd_payload_address = icacheNode_down_PC_PCVal;
  assign icache_read_index = icache_l1bus_cmd_payload_address[9 : 2];
  assign icache_read_reqTag = icache_l1bus_cmd_payload_address[63 : 10];
  assign _zz_icache_read_tag_valid = icache_tagBank_spinal_port0;
  assign icache_read_tag_valid = _zz_icache_read_tag_valid[0];
  assign icache_read_tag_address = _zz_icache_read_tag_valid[54 : 1];
  assign icache_read_word = icache_mem_spinal_port0;
  assign icache_read_lowerHalf = icache_read_word[31 : 0];
  assign icache_read_upperHalf = icache_read_word[63 : 32];
  assign icache_read_hit = (icache_read_tag_valid && (icache_read_tag_address == icache_read_reqTag));
  always @(*) begin
    icacheNode_down_Decoder_INSTRUCTION = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(icache_l1bus_cmd_valid) begin
      if(icache_read_hit) begin
        icacheNode_down_Decoder_INSTRUCTION = (icache_l1bus_cmd_payload_address[2] ? icache_read_upperHalf : icache_read_lowerHalf);
      end
    end
  end

  always @(*) begin
    icache_l1bus_rsp_valid = 1'b0;
    if(icache_l1bus_cmd_valid) begin
      if(icache_read_hit) begin
        icache_l1bus_rsp_valid = 1'b1;
      end else begin
        icache_l1bus_rsp_valid = 1'b0;
      end
    end
  end

  always @(*) begin
    icache_l1bus_rsp_payload_miss = 1'bx;
    if(icache_l1bus_cmd_valid) begin
      if(icache_read_hit) begin
        icache_l1bus_rsp_payload_miss = 1'b0;
      end else begin
        icache_l1bus_rsp_payload_miss = 1'b1;
      end
    end
  end

  always @(*) begin
    icache_l1bus_rsp_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(icache_l1bus_cmd_valid) begin
      if(icache_read_hit) begin
        icache_l1bus_rsp_payload_data = (icache_l1bus_cmd_payload_address[2] ? icache_read_upperHalf : icache_read_lowerHalf);
      end else begin
        icache_l1bus_rsp_payload_data = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      end
    end
  end

  always @(*) begin
    icache_ramBus_ramFetchCmd_valid = 1'b0;
    if(icache_l1bus_cmd_valid) begin
      if(!icache_read_hit) begin
        icache_ramBus_ramFetchCmd_valid = 1'b1;
      end
    end
  end

  always @(*) begin
    icache_ramBus_ramFetchCmd_payload_address = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(icache_l1bus_cmd_valid) begin
      if(!icache_read_hit) begin
        icache_ramBus_ramFetchCmd_payload_address = icache_l1bus_cmd_payload_address;
      end
    end
    if(icache_ramBus_ramFetchCmd_valid) begin
      icache_ramBus_ramFetchCmd_payload_address = icache_l1bus_cmd_payload_address;
    end
  end

  assign icache_l1bus_cmd_valid = icacheNode_down_PC_VALIDCACHEREAD;
  always @(*) begin
    icache_haltPc = 1'b0;
    if(icache_l1bus_cmd_valid) begin
      if(!icache_read_hit) begin
        icache_haltPc = 1'b1;
      end
    end
  end

  assign icacheNode_haltRequest_iCache_l83 = _zz_icacheNode_haltRequest_iCache_l83;
  assign _zz_5 = icache_l1bus_cmd_payload_address[9 : 2];
  always @(*) begin
    icache_ramBus_ramFetchRsp_ready = 1'b0;
    if(icache_ramBus_ramFetchCmd_valid) begin
      icache_ramBus_ramFetchRsp_ready = 1'b1;
    end
  end

  always @(*) begin
    icache_l1bus_cmd_ready = 1'b1;
    if(when_iCache_l118) begin
      icache_l1bus_cmd_ready = 1'b1;
    end
  end

  assign when_iCache_l118 = (icache_refill_fetching && icache_l1bus_rsp_valid);
  assign decoder_trap_shouldHalt = _zz_decoder_trap_shouldHalt[0];
  always @(*) begin
    decodeNode_down_Decoder_LEGAL = (1'bx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_LEGAL = _zz_decodeNode_down_Decoder_LEGAL_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_LEGAL_1 = 1'b0;
  assign _zz_decodeNode_down_Decoder_LEGAL = _zz_decodeNode_down_Decoder_LEGAL_1;
  assign _zz_decodeNode_down_Decoder_LEGAL_2 = _zz_decodeNode_down_Decoder_LEGAL;
  always @(*) begin
    decodeNode_down_Decoder_IS_FP = (1'bx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_IS_FP = _zz_decodeNode_down_Decoder_IS_FP_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_FSR3EN = ((decodeNode_up_Decoder_INSTRUCTION & 32'h0) == 32'h0);
  assign _zz_decodeNode_down_Decoder_IS_FP_1 = (|_zz_decodeNode_down_Decoder_FSR3EN);
  assign _zz_decodeNode_down_Decoder_IS_FP = _zz_decodeNode_down_Decoder_IS_FP_1;
  assign _zz_decodeNode_down_Decoder_IS_FP_2 = _zz_decodeNode_down_Decoder_IS_FP;
  always @(*) begin
    decodeNode_down_Decoder_EXECUTION_UNIT = (3'bxxx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_EXECUTION_UNIT = _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_IS_W = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00000010) == 32'h0);
  assign _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1 = {1'b0,{(|_zz_decodeNode_down_Decoder_IS_W),(|_zz_decodeNode_down_Decoder_IS_W)}};
  assign _zz_decodeNode_down_Decoder_EXECUTION_UNIT = _zz_decodeNode_down_Decoder_EXECUTION_UNIT_1;
  assign _zz_decodeNode_down_Decoder_EXECUTION_UNIT_2 = _zz_decodeNode_down_Decoder_EXECUTION_UNIT;
  always @(*) begin
    decodeNode_down_Decoder_RDTYPE = (2'bxx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_RDTYPE = _zz_decodeNode_down_Decoder_RDTYPE_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_IMMSEL = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00000014) == 32'h0);
  assign _zz_decodeNode_down_Decoder_RDTYPE_1 = {(|_zz_decodeNode_down_Decoder_IMMSEL),(|_zz_decodeNode_down_Decoder_IMMSEL)};
  assign _zz_decodeNode_down_Decoder_RDTYPE = _zz_decodeNode_down_Decoder_RDTYPE_1;
  assign _zz_decodeNode_down_Decoder_RDTYPE_2 = _zz_decodeNode_down_Decoder_RDTYPE;
  always @(*) begin
    decodeNode_down_Decoder_RS1TYPE = (3'bxxx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_RS1TYPE = _zz_decodeNode_down_Decoder_RS1TYPE_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_RS1TYPE_1 = {(|{((decodeNode_up_Decoder_INSTRUCTION & 32'h00000004) == 32'h00000004),_zz_decodeNode_down_Decoder_IS_W}),{1'b0,1'b0}};
  assign _zz_decodeNode_down_Decoder_RS1TYPE = _zz_decodeNode_down_Decoder_RS1TYPE_1;
  assign _zz_decodeNode_down_Decoder_RS1TYPE_2 = _zz_decodeNode_down_Decoder_RS1TYPE;
  always @(*) begin
    decodeNode_down_Decoder_RS2TYPE = (3'bxxx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_RS2TYPE = _zz_decodeNode_down_Decoder_RS2TYPE_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_ALUOP = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00000044) == 32'h00000004);
  assign _zz_decodeNode_down_Decoder_IMMSEL_1 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00000020) == 32'h0);
  assign _zz_decodeNode_down_Decoder_RS2TYPE_1 = {(|_zz_decodeNode_down_Decoder_IS_W),{(|{_zz_decodeNode_down_Decoder_IMMSEL_1,_zz_decodeNode_down_Decoder_ALUOP}),(|{_zz_decodeNode_down_Decoder_IMMSEL_1,_zz_decodeNode_down_Decoder_ALUOP})}};
  assign _zz_decodeNode_down_Decoder_RS2TYPE = _zz_decodeNode_down_Decoder_RS2TYPE_1;
  assign _zz_decodeNode_down_Decoder_RS2TYPE_2 = _zz_decodeNode_down_Decoder_RS2TYPE;
  always @(*) begin
    decodeNode_down_Decoder_FSR3EN = (1'bx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_FSR3EN = _zz_decodeNode_down_Decoder_FSR3EN_3;
    end
  end

  assign _zz_decodeNode_down_Decoder_FSR3EN_2 = (|_zz_decodeNode_down_Decoder_FSR3EN);
  assign _zz_decodeNode_down_Decoder_FSR3EN_1 = _zz_decodeNode_down_Decoder_FSR3EN_2;
  assign _zz_decodeNode_down_Decoder_FSR3EN_3 = _zz_decodeNode_down_Decoder_FSR3EN_1;
  always @(*) begin
    decodeNode_down_Decoder_IMMSEL = (3'bxxx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_IMMSEL = _zz_decodeNode_down_Decoder_IMMSEL_4;
    end
  end

  assign _zz_decodeNode_down_Decoder_ALUOP_1 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00000018) == 32'h00000008);
  assign _zz_decodeNode_down_Decoder_IMMSEL_3 = {(|{_zz_decodeNode_down_Decoder_ALUOP_1,_zz_decodeNode_down_Decoder_ALUOP}),{(|_zz_decodeNode_down_Decoder_IMMSEL),(|{_zz_decodeNode_down_Decoder_IS_W,_zz_decodeNode_down_Decoder_IMMSEL_1})}};
  assign _zz_decodeNode_down_Decoder_IMMSEL_2 = _zz_decodeNode_down_Decoder_IMMSEL_3;
  assign _zz_decodeNode_down_Decoder_IMMSEL_4 = _zz_decodeNode_down_Decoder_IMMSEL_2;
  always @(*) begin
    decodeNode_down_Decoder_ALUOP = (5'bxxxxx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_ALUOP = _zz_decodeNode_down_Decoder_ALUOP_7;
    end
  end

  assign _zz_decodeNode_down_Decoder_ALUOP_2 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00004048) == 32'h00004008);
  assign _zz_decodeNode_down_Decoder_ALUOP_3 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h40000048) == 32'h00000008);
  assign _zz_decodeNode_down_Decoder_ALUOP_4 = ((decodeNode_up_Decoder_INSTRUCTION & 32'h00000028) == 32'h00000008);
  assign _zz_decodeNode_down_Decoder_ALUOP_6 = {(|{_zz_decodeNode_down_Decoder_IS_W,(_zz__zz_decodeNode_down_Decoder_ALUOP_6 == _zz__zz_decodeNode_down_Decoder_ALUOP_6_1)}),{(|{_zz_decodeNode_down_Decoder_ALUOP_4,{_zz__zz_decodeNode_down_Decoder_ALUOP_6_2,_zz__zz_decodeNode_down_Decoder_ALUOP_6_3}}),{(|{_zz__zz_decodeNode_down_Decoder_ALUOP_6_10,_zz__zz_decodeNode_down_Decoder_ALUOP_6_11}),{(|_zz__zz_decodeNode_down_Decoder_ALUOP_6_26),(|_zz__zz_decodeNode_down_Decoder_ALUOP_6_39)}}}};
  assign _zz_decodeNode_down_Decoder_ALUOP_5 = _zz_decodeNode_down_Decoder_ALUOP_6;
  assign _zz_decodeNode_down_Decoder_ALUOP_7 = _zz_decodeNode_down_Decoder_ALUOP_5;
  always @(*) begin
    decodeNode_down_Decoder_IS_BR = (1'bx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_IS_BR = _zz_decodeNode_down_Decoder_IS_BR_2;
    end
  end

  assign _zz_decodeNode_down_Decoder_IS_BR_1 = (|{((decodeNode_up_Decoder_INSTRUCTION & 32'h00000008) == 32'h00000008),{((decodeNode_up_Decoder_INSTRUCTION & 32'h00000040) == 32'h0),((decodeNode_up_Decoder_INSTRUCTION & 32'h00005000) == 32'h0)}});
  assign _zz_decodeNode_down_Decoder_IS_BR = _zz_decodeNode_down_Decoder_IS_BR_1;
  assign _zz_decodeNode_down_Decoder_IS_BR_2 = _zz_decodeNode_down_Decoder_IS_BR;
  always @(*) begin
    decodeNode_down_Decoder_IS_W = (1'bx);
    if(decodeNode_up_isFiring) begin
      decodeNode_down_Decoder_IS_W = _zz_decodeNode_down_Decoder_IS_W_3;
    end
  end

  assign _zz_decodeNode_down_Decoder_IS_W_2 = (|{((decodeNode_up_Decoder_INSTRUCTION & 32'h00000008) == 32'h0),_zz_decodeNode_down_Decoder_IS_W});
  assign _zz_decodeNode_down_Decoder_IS_W_1 = _zz_decodeNode_down_Decoder_IS_W_2;
  assign _zz_decodeNode_down_Decoder_IS_W_3 = _zz_decodeNode_down_Decoder_IS_W_1;
  assign decodeNode_down_Decoder_RD = decodeNode_up_Decoder_INSTRUCTION[11 : 7];
  assign decodeNode_down_Decoder_RS1 = decodeNode_up_Decoder_INSTRUCTION[19 : 15];
  assign decodeNode_down_Decoder_RS2 = decodeNode_up_Decoder_INSTRUCTION[24 : 20];
  assign pcNode_haltRequest_testfrontend_l20 = icache_haltPc;
  assign mainMemory_resizedAddress = mainMemory_bus_ramFetchCmd_payload_address[9 : 0];
  always @(*) begin
    mainMemory_bus_ramFetchCmd_ready = 1'bx;
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_stateA : begin
        mainMemory_bus_ramFetchCmd_ready = 1'b1;
      end
      mainMemory_controller_enumDef_stateB : begin
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mainMemory_bus_ramFetchRsp_valid = 1'bx;
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_stateA : begin
      end
      mainMemory_controller_enumDef_stateB : begin
        mainMemory_bus_ramFetchRsp_valid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mainMemory_bus_ramFetchRsp_payload_address = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_stateA : begin
      end
      mainMemory_controller_enumDef_stateB : begin
        mainMemory_bus_ramFetchRsp_payload_address = mainMemory_bus_ramFetchCmd_payload_address;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    mainMemory_bus_ramFetchRsp_payload_data = 64'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_stateA : begin
      end
      mainMemory_controller_enumDef_stateB : begin
        mainMemory_bus_ramFetchRsp_payload_data = mainMemory_memory_spinal_port0;
      end
      default : begin
      end
    endcase
  end

  assign mainMemory_controller_wantExit = 1'b0;
  always @(*) begin
    mainMemory_controller_wantStart = 1'b0;
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_stateA : begin
      end
      mainMemory_controller_enumDef_stateB : begin
      end
      default : begin
        mainMemory_controller_wantStart = 1'b1;
      end
    endcase
  end

  assign mainMemory_controller_wantKill = 1'b0;
  assign mainMemory_bus_ramFetchCmd_valid = icache_ramBus_ramFetchCmd_valid;
  assign icache_ramBus_ramFetchCmd_ready = mainMemory_bus_ramFetchCmd_ready;
  assign mainMemory_bus_ramFetchCmd_payload_address = icache_ramBus_ramFetchCmd_payload_address;
  assign icache_ramBus_ramFetchRsp_valid = mainMemory_bus_ramFetchRsp_valid;
  assign mainMemory_bus_ramFetchRsp_ready = icache_ramBus_ramFetchRsp_ready;
  assign icache_ramBus_ramFetchRsp_payload_address = mainMemory_bus_ramFetchRsp_payload_address;
  assign icache_ramBus_ramFetchRsp_payload_data = mainMemory_bus_ramFetchRsp_payload_data;
  always @(*) begin
    pcNode_down_valid = pcNode_up_valid;
    if(when_CtrlLink_l150) begin
      pcNode_down_valid = 1'b0;
    end
  end

  always @(*) begin
    pcNode_up_ready = pcNode_down_isReady;
    if(when_CtrlLink_l150) begin
      pcNode_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l150 = (|pcNode_haltRequest_testfrontend_l20);
  assign pcNode_down_PC_PCVal = pcNode_up_PC_PCVal;
  always @(*) begin
    icacheNode_down_valid = icacheNode_up_valid;
    if(when_CtrlLink_l150_1) begin
      icacheNode_down_valid = 1'b0;
    end
  end

  always @(*) begin
    icacheNode_up_ready = icacheNode_down_isReady;
    if(when_CtrlLink_l150_1) begin
      icacheNode_up_ready = 1'b0;
    end
  end

  assign when_CtrlLink_l150_1 = (|icacheNode_haltRequest_iCache_l83);
  assign icacheNode_down_PC_PCVal = icacheNode_up_PC_PCVal;
  assign icacheNode_down_PC_VALIDCACHEREAD = icacheNode_up_PC_VALIDCACHEREAD;
  assign decodeNode_down_valid = decodeNode_up_valid;
  assign decodeNode_down_Decoder_INSTRUCTION = decodeNode_up_Decoder_INSTRUCTION;
  always @(*) begin
    pcNode_down_ready = icacheNode_up_ready;
    if(when_StageLink_l67) begin
      pcNode_down_ready = 1'b1;
    end
  end

  assign when_StageLink_l67 = (! icacheNode_up_isValid);
  assign pcNode_up_isFiring = (pcNode_up_isValid && pcNode_up_isReady);
  assign pcNode_up_isValid = pcNode_up_valid;
  assign pcNode_up_isReady = pcNode_up_ready;
  assign pcNode_down_isValid = pcNode_down_valid;
  assign pcNode_down_isReady = pcNode_down_ready;
  assign icacheNode_up_isValid = icacheNode_up_valid;
  assign icacheNode_down_isValid = icacheNode_down_valid;
  assign icacheNode_down_isReady = 1'b1;
  assign decodeNode_up_isFiring = (decodeNode_up_isValid && decodeNode_up_isReady);
  assign decodeNode_up_isValid = decodeNode_up_valid;
  assign decodeNode_up_isReady = 1'b1;
  always @(*) begin
    mainMemory_controller_stateNext = mainMemory_controller_stateReg;
    case(mainMemory_controller_stateReg)
      mainMemory_controller_enumDef_stateA : begin
        if(mainMemory_bus_ramFetchCmd_valid) begin
          mainMemory_controller_stateNext = mainMemory_controller_enumDef_stateB;
        end
      end
      mainMemory_controller_enumDef_stateB : begin
        if(mainMemory_bus_ramFetchRsp_ready) begin
          mainMemory_controller_stateNext = mainMemory_controller_enumDef_stateA;
        end
      end
      default : begin
      end
    endcase
    if(mainMemory_controller_wantStart) begin
      mainMemory_controller_stateNext = mainMemory_controller_enumDef_stateA;
    end
    if(mainMemory_controller_wantKill) begin
      mainMemory_controller_stateNext = mainMemory_controller_enumDef_BOOT;
    end
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      PC_pclogic_pcReg <= 64'h0;
      icache_refill_fetching <= 1'b0;
      icacheNode_up_valid <= 1'b0;
      decodeNode_up_valid <= 1'b0;
      mainMemory_controller_stateReg <= mainMemory_controller_enumDef_BOOT;
    end else begin
      if(pcNode_up_isFiring) begin
        PC_pclogic_pcReg <= (PC_jumpcmd_valid_1 ? PC_jumpcmd_payload_address_1 : _zz_PC_pclogic_pcReg);
      end
      if(icache_refill_fetching) begin
        if(icache_ramBus_ramFetchRsp_valid) begin
          icache_refill_fetching <= 1'b0;
        end
      end
      if(icache_ramBus_ramFetchCmd_valid) begin
        icache_refill_fetching <= 1'b1;
      end
      if(pcNode_down_isReady) begin
        icacheNode_up_valid <= pcNode_down_isValid;
      end
      decodeNode_up_valid <= icacheNode_down_isValid;
      mainMemory_controller_stateReg <= mainMemory_controller_stateNext;
    end
  end

  always @(posedge clk) begin
    if(pcNode_down_isReady) begin
      icacheNode_up_PC_PCVal <= pcNode_down_PC_PCVal;
      icacheNode_up_PC_VALIDCACHEREAD <= pcNode_down_PC_VALIDCACHEREAD;
    end
    decodeNode_up_Decoder_INSTRUCTION <= icacheNode_down_Decoder_INSTRUCTION;
  end


endmodule

// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : decoderForTest
// Git hash  : ede7f1f1f9df04ce6332277403fb1c862cf0253f

`timescale 1ns/1ps

module decoderForTest (
  input  wire [31:0]   io_instr,
  output reg           recieve_io_is_int,
  input  wire          clk,
  input  wire          reset
);

  wire       [0:0]    _zz_decode_node_down_Decoder_IS_INT;
  wire       [0:0]    _zz_decode_node_down_Decoder_IS_INT_1;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_FPU;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_FPU_1;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_RM;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_RM_1;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_VPU;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_VPU_1;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_PC;
  wire       [0:0]    _zz_decode_node_down_Decoder_NEED_PC_1;
  wire       [0:0]    _zz_decode_node_down_decoder_logic_need_funct3;
  wire       [0:0]    _zz_decode_node_down_decoder_logic_need_funct3_1;
  wire                recieve_signals_up_isReady;
  wire                recieve_signals_up_isValid;
  reg                 recieve_signals_up_Decoder_IS_INT;
  wire                recieve_signals_down_Decoder_IS_INT;
  wire                recieve_signals_up_isFiring;
  wire       [31:0]   test_signals_node_down_Decoder_INSTRUCTION;
  reg                 decode_node_down_decoder_logic_need_funct3;
  reg                 decode_node_down_Decoder_NEED_PC;
  reg                 decode_node_down_Decoder_NEED_VPU;
  reg                 decode_node_down_Decoder_NEED_RM;
  reg                 decode_node_down_Decoder_NEED_FPU;
  wire                decode_node_up_isValid;
  reg                 decode_node_down_Decoder_IS_INT;
  wire       [6:0]    decode_node_down_Decoder_OPCODE;
  wire       [6:0]    decode_node_down_Decoder_FUNCT7;
  wire       [2:0]    decode_node_down_Decoder_FUNCT3;
  reg        [31:0]   decode_node_up_Decoder_INSTRUCTION;

  assign _zz_decode_node_down_Decoder_IS_INT = _zz_decode_node_down_Decoder_IS_INT_1[0];
  assign _zz_decode_node_down_Decoder_IS_INT_1 = (|((decode_node_up_Decoder_INSTRUCTION & 32'h00000074) == 32'h00000030));
  assign _zz_decode_node_down_Decoder_NEED_FPU = _zz_decode_node_down_Decoder_NEED_FPU_1[0];
  assign _zz_decode_node_down_Decoder_NEED_FPU_1 = 1'b0;
  assign _zz_decode_node_down_Decoder_NEED_RM = _zz_decode_node_down_Decoder_NEED_RM_1[0];
  assign _zz_decode_node_down_Decoder_NEED_RM_1 = 1'b0;
  assign _zz_decode_node_down_Decoder_NEED_VPU = _zz_decode_node_down_Decoder_NEED_VPU_1[0];
  assign _zz_decode_node_down_Decoder_NEED_VPU_1 = 1'b0;
  assign _zz_decode_node_down_Decoder_NEED_PC = _zz_decode_node_down_Decoder_NEED_PC_1[0];
  assign _zz_decode_node_down_Decoder_NEED_PC_1 = (|{((decode_node_up_Decoder_INSTRUCTION & 32'h0000002c) == 32'h00000004),{((decode_node_up_Decoder_INSTRUCTION & 32'h00000054) == 32'h00000040),((decode_node_up_Decoder_INSTRUCTION & 32'h00000038) == 32'h00000000)}});
  assign _zz_decode_node_down_decoder_logic_need_funct3 = _zz_decode_node_down_decoder_logic_need_funct3_1[0];
  assign _zz_decode_node_down_decoder_logic_need_funct3_1 = (|{((decode_node_up_Decoder_INSTRUCTION & 32'h00000044) == 32'h00000000),((decode_node_up_Decoder_INSTRUCTION & 32'h00000018) == 32'h00000000)});
  assign decode_node_down_Decoder_FUNCT3 = decode_node_up_Decoder_INSTRUCTION[14 : 12];
  assign decode_node_down_Decoder_FUNCT7 = decode_node_up_Decoder_INSTRUCTION[31 : 25];
  assign decode_node_down_Decoder_OPCODE = decode_node_up_Decoder_INSTRUCTION[6 : 0];
  always @(*) begin
    decode_node_down_Decoder_IS_INT = 1'bx;
    if(decode_node_up_isValid) begin
      decode_node_down_Decoder_IS_INT = _zz_decode_node_down_Decoder_IS_INT[0];
    end
  end

  always @(*) begin
    decode_node_down_Decoder_NEED_FPU = 1'bx;
    if(decode_node_up_isValid) begin
      decode_node_down_Decoder_NEED_FPU = _zz_decode_node_down_Decoder_NEED_FPU[0];
    end
  end

  always @(*) begin
    decode_node_down_Decoder_NEED_RM = 1'bx;
    if(decode_node_up_isValid) begin
      decode_node_down_Decoder_NEED_RM = _zz_decode_node_down_Decoder_NEED_RM[0];
    end
  end

  always @(*) begin
    decode_node_down_Decoder_NEED_VPU = 1'bx;
    if(decode_node_up_isValid) begin
      decode_node_down_Decoder_NEED_VPU = _zz_decode_node_down_Decoder_NEED_VPU[0];
    end
  end

  always @(*) begin
    decode_node_down_Decoder_NEED_PC = 1'bx;
    if(decode_node_up_isValid) begin
      decode_node_down_Decoder_NEED_PC = _zz_decode_node_down_Decoder_NEED_PC[0];
    end
  end

  always @(*) begin
    decode_node_down_decoder_logic_need_funct3 = 1'bx;
    if(decode_node_up_isValid) begin
      decode_node_down_decoder_logic_need_funct3 = _zz_decode_node_down_decoder_logic_need_funct3[0];
    end
  end

  assign test_signals_node_down_Decoder_INSTRUCTION = io_instr;
  always @(*) begin
    recieve_io_is_int = 1'b0;
    if(recieve_signals_up_isFiring) begin
      recieve_io_is_int = recieve_signals_down_Decoder_IS_INT;
    end
  end

  assign recieve_signals_down_Decoder_IS_INT = recieve_signals_up_Decoder_IS_INT;
  assign decode_node_up_isValid = 1'b1;
  assign recieve_signals_up_isFiring = (recieve_signals_up_isValid && recieve_signals_up_isReady);
  assign recieve_signals_up_isValid = 1'b1;
  assign recieve_signals_up_isReady = 1'b1;
  always @(posedge clk) begin
    decode_node_up_Decoder_INSTRUCTION <= test_signals_node_down_Decoder_INSTRUCTION;
    recieve_signals_up_Decoder_IS_INT <= decode_node_down_Decoder_IS_INT;
  end


endmodule

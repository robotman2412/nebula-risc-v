// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : decoderForTest
// Git hash  : c2acc991922f72890e82817025adb0465d7b2b55

`timescale 1ns/1ps

module decoderForTest (
  input  wire [31:0]   io_instr,
  output reg           recieve_io_is_int,
  input  wire          clk,
  input  wire          reset
);

  wire       [0:0]    _zz_decode_node_down_Decoder_IS_INT;
  wire       [0:0]    _zz_decode_node_down_Decoder_IS_INT_1;
  wire                recieve_signals_up_isReady;
  wire                recieve_signals_up_isValid;
  reg                 recieve_signals_up_Decoder_IS_INT;
  wire                recieve_signals_down_Decoder_IS_INT;
  wire                recieve_signals_up_isFiring;
  wire       [31:0]   test_signals_node_down_Decoder_INSTRUCTION;
  wire                decode_node_up_isValid;
  reg                 decode_node_down_Decoder_IS_INT;
  wire       [2:0]    decode_node_down_Decoder_FUNCT3_0;
  reg        [31:0]   decode_node_up_Decoder_INSTRUCTION;

  assign _zz_decode_node_down_Decoder_IS_INT = _zz_decode_node_down_Decoder_IS_INT_1[0];
  assign _zz_decode_node_down_Decoder_IS_INT_1 = (|((decode_node_up_Decoder_INSTRUCTION & 32'h00000030) == 32'h00000030));
  assign decode_node_down_Decoder_FUNCT3_0 = decode_node_up_Decoder_INSTRUCTION[14 : 12];
  always @(*) begin
    decode_node_down_Decoder_IS_INT = 1'b0;
    if(decode_node_up_isValid) begin
      decode_node_down_Decoder_IS_INT = _zz_decode_node_down_Decoder_IS_INT[0];
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

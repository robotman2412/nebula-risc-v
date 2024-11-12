// Generator : SpinalHDL v1.10.1    git head : 2527c7c6b0fb0f95e5e1a5722a0be732b364ce43
// Component : decoderTest
// Git hash  : bda3a71e2d222aa892bfe707ba8b7a6a128769f9

`timescale 1ns/1ps

module decoderTest (
);

  wire       [0:0]    _zz_decode_node_Decoder_IS_INT_0;
  wire       [0:0]    _zz_decode_node_Decoder_IS_INT_0_1;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_FPU_0;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_FPU_0_1;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_RM_0;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_RM_0_1;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_VPU_0;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_VPU_0_1;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_PC_0;
  wire       [0:0]    _zz_decode_node_Decoder_NEED_PC_0_1;
  wire                decode_node_Decoder_NEED_PC_0;
  wire                decode_node_Decoder_NEED_VPU_0;
  wire                decode_node_Decoder_NEED_RM_0;
  wire                decode_node_Decoder_NEED_FPU_0;
  wire                decode_node_Decoder_IS_INT_0;
  wire       [6:0]    decode_node_Decoder_OPCODE_0;
  wire       [6:0]    decode_node_Decoder_FUNCT7_0;
  wire       [2:0]    decode_node_Decoder_FUNCT3_0;
  wire       [31:0]   decode_node_Decoder_INSTRUCTION_0;

  assign _zz_decode_node_Decoder_IS_INT_0 = _zz_decode_node_Decoder_IS_INT_0_1[0];
  assign _zz_decode_node_Decoder_IS_INT_0_1 = (|((decode_node_Decoder_INSTRUCTION_0 & 32'h00000030) == 32'h00000030));
  assign _zz_decode_node_Decoder_NEED_FPU_0 = _zz_decode_node_Decoder_NEED_FPU_0_1[0];
  assign _zz_decode_node_Decoder_NEED_FPU_0_1 = 1'b0;
  assign _zz_decode_node_Decoder_NEED_RM_0 = _zz_decode_node_Decoder_NEED_RM_0_1[0];
  assign _zz_decode_node_Decoder_NEED_RM_0_1 = 1'b0;
  assign _zz_decode_node_Decoder_NEED_VPU_0 = _zz_decode_node_Decoder_NEED_VPU_0_1[0];
  assign _zz_decode_node_Decoder_NEED_VPU_0_1 = 1'b0;
  assign _zz_decode_node_Decoder_NEED_PC_0 = _zz_decode_node_Decoder_NEED_PC_0_1[0];
  assign _zz_decode_node_Decoder_NEED_PC_0_1 = (|{((decode_node_Decoder_INSTRUCTION_0 & 32'h00000048) == 32'h00000040),{((decode_node_Decoder_INSTRUCTION_0 & 32'h00000044) == 32'h00000004),((decode_node_Decoder_INSTRUCTION_0 & 32'h00000030) == 32'h00000000)}});
  assign decode_node_Decoder_FUNCT3_0 = decode_node_Decoder_INSTRUCTION_0[14 : 12];
  assign decode_node_Decoder_FUNCT7_0 = decode_node_Decoder_INSTRUCTION_0[31 : 25];
  assign decode_node_Decoder_OPCODE_0 = decode_node_Decoder_INSTRUCTION_0[6 : 0];
  assign decode_node_Decoder_IS_INT_0 = _zz_decode_node_Decoder_IS_INT_0[0];
  assign decode_node_Decoder_NEED_FPU_0 = _zz_decode_node_Decoder_NEED_FPU_0[0];
  assign decode_node_Decoder_NEED_RM_0 = _zz_decode_node_Decoder_NEED_RM_0[0];
  assign decode_node_Decoder_NEED_VPU_0 = _zz_decode_node_Decoder_NEED_VPU_0[0];
  assign decode_node_Decoder_NEED_PC_0 = _zz_decode_node_Decoder_NEED_PC_0[0];

endmodule

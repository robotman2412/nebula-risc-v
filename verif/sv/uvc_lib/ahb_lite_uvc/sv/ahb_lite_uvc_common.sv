`ifndef AHB_LITE_UVC_COMMON_SV
`define AHB_LITE_UVC_COMMON_SV

`define ADDR_WIDTH      32
`define DATA_WIDTH      32
`define HBURST_WIDTH    3
`define HPROT_WIDTH     4

typedef enum bit [1:0] {
    TRANS_IDLE,
    TRANS_BUSY,
    TRANS_NONSEQ,
    TRANS_SEQ
} ahb_lite_trans_e;

typedef enum bit [`HBURST_WIDTH-1:0] {
    BURST_SINGLE,
    BURST_INCR,
    BURST_WRAP4,
    BURST_INCR4,
    BURST_WRAP8,
    BURST_INCR8,
    BURST_WRAP16,
    BURST_INCR16
} ahb_lite_burst_e;

`endif // AHB_LITE_UVC_COMMON_SV

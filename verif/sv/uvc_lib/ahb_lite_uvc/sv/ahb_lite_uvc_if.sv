`ifndef AHB_LITE_UVC_IF_SV
`define AHB_LITE_UVC_IF_SV

interface ahb_lite_uvc_if (
    input bit HCLK,
    input bit HRESETn
);

    /* INTERFACE SIGNALS */

    // master signals
    logic [  `ADDR_WIDTH-1:0]   HADDR;
    logic [`HBURST_WIDTH-1:0]   HBURST;
    logic                       HMASTLOCK;
    logic [ `HPROT_WIDTH-1:0]   HPROT;
    logic [              2:0]   HSIZE;
    logic [              1:0]   HTRANS;
    logic [  `DATA_WIDTH-1:0]   HWDATA;
    logic                       HWRITE;

    // slave signals
    logic [  `DATA_WIDTH-1:0]   HRDATA;
    logic                       HREADYOUT;
    logic                       HRESP;

    /* ASSERTIONS */
    // TODO

endinterface : ahb_lite_uvc_if

`endif // AHB_LITE_UVC_IF_SV

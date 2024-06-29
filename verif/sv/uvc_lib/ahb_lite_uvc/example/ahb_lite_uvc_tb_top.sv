import uvm_pkg::*;

import ahb_lite_uvc_pkg::*;
import ahb_lite_uvc_env_top_pkg::*;
import ahb_lite_uvc_test_pkg::*;

module ahb_lite_uvc_tb_top;

    reg HCLK;
    reg HRESETn;

    ahb_lite_uvc_if ahb_if(HCLK, HRESETn);

    initial begin
        uvm_config_db#(virtual ahb_lite_uvc_if)::set(
            uvm_root::get(),
            "uvm_test_top.m_env_top.m_env.m_agent",
            "m_vif",
            ahb_if
        );
    end

    initial begin
        run_test("test_ahb_lite_uvc_base");
    end

    initial begin
        HCLK = 1;
        forever HCLK = #5 ~HCLK;
    end

    initial begin
        HRESETn = 0;
        #201 HRESETn = 1;
    end

    initial begin
        ahb_if.HREADYOUT    <= 1'b1;

        #205
        ahb_if.HTRANS       <= TRANS_NONSEQ;
        ahb_if.HADDR        <= 32'h20;
        ahb_if.HWRITE       <= 1'b0;
        ahb_if.HBURST       <= BURST_INCR;
        ahb_if.HREADYOUT    <= 1'b1;

        #10
        ahb_if.HTRANS       <= TRANS_BUSY;
        ahb_if.HADDR        <= 32'h24;
        ahb_if.HWRITE       <= 0;
        ahb_if.HBURST       <= BURST_INCR;
        ahb_if.HREADYOUT    <= 1'b1;
        ahb_if.HRDATA       <= 32'h11;

        #10
        ahb_if.HTRANS       <= TRANS_SEQ;
        ahb_if.HADDR        <= 32'h24;
        ahb_if.HWRITE       <= 0;
        ahb_if.HBURST       <= BURST_INCR;
        ahb_if.HREADYOUT    <= 1'b1;
        ahb_if.HRDATA       <= 32'hx;

        #10
        ahb_if.HTRANS       <= TRANS_SEQ;
        ahb_if.HADDR        <= 32'h28;
        ahb_if.HWRITE       <= 0;
        ahb_if.HBURST       <= BURST_INCR;
        ahb_if.HREADYOUT    <= 1'b1;
        ahb_if.HRDATA       <= 32'h12;

        #10
        ahb_if.HTRANS       <= TRANS_SEQ;
        ahb_if.HADDR        <= 32'h2c;
        ahb_if.HWRITE       <= 0;
        ahb_if.HBURST       <= BURST_INCR;
        ahb_if.HREADYOUT    <= 1'b0;
        ahb_if.HRDATA       <= 32'hx;

        #10
        ahb_if.HTRANS       <= TRANS_SEQ;
        ahb_if.HADDR        <= 32'h2c;
        ahb_if.HWRITE       <= 0;
        ahb_if.HBURST       <= BURST_INCR;
        ahb_if.HREADYOUT    <= 1'b1;
        ahb_if.HRDATA       <= 32'h13;

        #10
        ahb_if.HREADYOUT    <= 1'b0;
    end

endmodule : ahb_lite_uvc_tb_top

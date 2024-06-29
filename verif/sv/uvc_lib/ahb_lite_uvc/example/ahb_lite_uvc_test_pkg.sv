`ifndef AHB_LITE_UVC_TEST_PKG_SV
`define AHB_LITE_UVC_TEST_PKG_SV

`include "ahb_lite_uvc_env_top_pkg.sv"

package ahb_lite_uvc_test_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

import ahb_lite_uvc_pkg::*;
import ahb_lite_uvc_env_top_pkg::*;

`include "test_ahb_lite_uvc_base.sv"

endpackage : ahb_lite_uvc_test_pkg

`endif // AHB_LITE_UVC_TEST_PKG_SV

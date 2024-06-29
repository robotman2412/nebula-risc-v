`ifndef AHB_LITE_UVC_CFG_TOP_SV
`define AHB_LITE_UVC_CFG_TOP_SV

class ahb_lite_uvc_cfg_top extends uvm_object;

    /* CONFIGURATION FIELDS */
    // TODO
    ahb_lite_uvc_env_cfg m_env_cfg;

    /* REGISTRATION MACRO */
    `uvm_object_utils_begin(ahb_lite_uvc_cfg_top)
        // TODO
        `uvm_field_object(m_env_cfg, UVM_ALL_ON)
    `uvm_object_utils_end

    /* METHODS */
    extern function new(string name = "ahb_lite_uvc_cfg_top");

endclass : ahb_lite_uvc_cfg_top

// constructor
function ahb_lite_uvc_cfg_top::new(string name = "ahb_lite_uvc_cfg_top");
    super.new(name);

    // create environment config object
    m_env_cfg = ahb_lite_uvc_env_cfg::type_id::create("m_env_cfg");

endfunction : new

`endif // AHB_LITE_UVC_CFG_TOP_SV

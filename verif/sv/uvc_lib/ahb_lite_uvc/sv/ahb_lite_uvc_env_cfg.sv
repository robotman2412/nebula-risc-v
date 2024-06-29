`ifndef AHB_LITE_UVC_ENV_CFG_SV
`define AHB_LITE_UVC_ENV_CFG_SV

class ahb_lite_uvc_env_cfg extends uvm_object;

    /* CONFIGURATION FIELDS */
    // TODO
    ahb_lite_uvc_agent_cfg m_agent_cfg;

    /* REGISTRATION MACRO */
    `uvm_object_utils_begin(ahb_lite_uvc_env_cfg)
        // TODO
        `uvm_field_object(m_agent_cfg, UVM_ALL_ON)
    `uvm_object_utils_end

    /* METHODS */
    extern function new(string name = "ahb_lite_uvc_env_cfg");

endclass : ahb_lite_uvc_env_cfg

// constructor
function ahb_lite_uvc_env_cfg::new(string name = "ahb_lite_uvc_env_cfg");
    super.new(name);

    // create agent config object
    m_agent_cfg = ahb_lite_uvc_agent_cfg::type_id::create("m_agent_cfg");

endfunction : new

`endif // AHB_LITE_UVC_ENV_CFG_SV

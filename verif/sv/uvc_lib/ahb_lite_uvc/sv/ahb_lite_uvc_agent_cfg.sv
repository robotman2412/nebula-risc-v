`ifndef AHB_LITE_UVC_AGENT_CFG_SV
`define AHB_LITE_UVC_AGENT_CFG_SV

class ahb_lite_uvc_agent_cfg extends uvm_object;

    /* CONFIGURATION FIELDS */
    // TODO
    uvm_active_passive_enum     m_is_active      = UVM_ACTIVE;
    bit                         m_has_subscriber = 1;

    /* REGISTRATION MACRO */
    `uvm_object_utils_begin(ahb_lite_uvc_agent_cfg)
        // TODO
        `uvm_field_enum(uvm_active_passive_enum, m_is_active,      UVM_ALL_ON)
        `uvm_field_int (                         m_has_subscriber, UVM_ALL_ON)
    `uvm_object_utils_end

    /* METHODS */
    extern function new(string name = "ahb_lite_uvc_agent_cfg");

endclass : ahb_lite_uvc_agent_cfg

// constructor
function ahb_lite_uvc_agent_cfg::new(string name = "ahb_lite_uvc_agent_cfg");
    super.new(name);
endfunction : new

`endif // AHB_LITE_UVC_AGENT_CFG_SV

`ifndef AHB_LITE_UVC_ENV_TOP_SV
`define AHB_LITE_UVC_ENV_TOP_SV

class ahb_lite_uvc_env_top extends uvm_env;

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_env_top)

    /* CONFIGURATION REF */
    ahb_lite_uvc_cfg_top m_cfg_top;

    /* COMPONENTS */
    ahb_lite_uvc_env m_env;

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);

endclass : ahb_lite_uvc_env_top

// constructor
function ahb_lite_uvc_env_top::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void ahb_lite_uvc_env_top::build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(ahb_lite_uvc_cfg_top)::get(
        this, "", "m_cfg", m_cfg_top
    )) begin
        `uvm_fatal(get_type_name(), "Failed to get configuration from DB!")
    end

    `uvm_info(get_type_name(), {"\n", m_cfg_top.sprint()}, UVM_LOW)

    m_env = ahb_lite_uvc_env::type_id::create("m_env", this);

    uvm_config_db#(ahb_lite_uvc_env_cfg)::set(
        this, "m_env", "m_cfg", m_cfg_top.m_env_cfg
    );

endfunction : build_phase

`endif // AHB_LITE_UVC_ENV_TOP_SV

`ifndef AHB_LITE_UVC_ENV_SV
`define AHB_LITE_UVC_ENV_SV

class ahb_lite_uvc_env extends uvm_env;

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_env)

    /* ANALYSIS PORT */
    uvm_analysis_port#(ahb_lite_uvc_item) m_aport;

    /* CONFIGURATION REF */
    ahb_lite_uvc_env_cfg m_cfg;

    /* COMPONENTS */
    ahb_lite_uvc_agent m_agent;

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass : ahb_lite_uvc_env

// constructor
function ahb_lite_uvc_env::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void ahb_lite_uvc_env::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // get configuration from DB
    if(!uvm_config_db#(ahb_lite_uvc_env_cfg)::get(
        this, "", "m_cfg", m_cfg
    )) begin
        `uvm_fatal(get_type_name(), "Failed to get configuration from DB!")
    end

    // print environment config
    `uvm_info(get_type_name(), {"\n", m_cfg.sprint()}, UVM_LOW)

    // create analysis port
    m_aport = new("m_aport", this);

    // create agent component
    m_agent = ahb_lite_uvc_agent::type_id::create("m_agent", this);

    // set agent config
    uvm_config_db#(ahb_lite_uvc_agent_cfg)::set(
        this, "m_agent", "m_cfg", m_cfg.m_agent_cfg
    );

endfunction : build_phase

// connect phase
function void ahb_lite_uvc_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // connect environment analysis port
    m_agent.m_aport.connect(m_aport);

endfunction : connect_phase

`endif // AHB_LITE_UVC_ENV_SV

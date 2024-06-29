`ifndef AHB_LITE_UVC_AGENT_SV
`define AHB_LITE_UVC_AGENT_SV

class ahb_lite_uvc_agent extends uvm_agent;

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_agent)

    /* ANALYSIS PORT */
    uvm_analysis_port#(ahb_lite_uvc_item) m_aport;

    virtual interface ahb_lite_uvc_if m_vif;

    /* AGENT CONFIGURATION REF */
    ahb_lite_uvc_agent_cfg m_cfg;

    /* COMPONENTS */
    ahb_lite_uvc_driver         m_driver;
    ahb_lite_uvc_sequencer      m_sequencer;
    ahb_lite_uvc_monitor        m_monitor;
    ahb_lite_uvc_subscriber     m_subscriber;

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass : ahb_lite_uvc_agent

// constructor
function ahb_lite_uvc_agent::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void ahb_lite_uvc_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // get configuration from DB
    if(!uvm_config_db#(ahb_lite_uvc_agent_cfg)::get(
        this, "", "m_cfg", m_cfg
    )) begin
        `uvm_fatal(get_type_name(), "Failed to get configuration from DB!")
    end

    if(!uvm_config_db#(virtual ahb_lite_uvc_if)::get(
        this, "", "m_vif", m_vif
    )) begin
        `uvm_fatal(get_type_name(), "Failed to get virtual interface from DB!")
    end

    // print agent config
    `uvm_info(get_type_name(), {"\n", m_cfg.sprint()}, UVM_LOW)

    // create analysis port
    m_aport = new("m_aport", this);

    // create active agent components
    if(m_cfg.m_is_active == UVM_ACTIVE) begin

        // create driver component
        m_driver = ahb_lite_uvc_driver::type_id::create("m_driver", this);

        // set driver config
        m_driver.m_cfg = m_cfg;

        // set driver virtual interface
        uvm_config_db#(virtual ahb_lite_uvc_if)::set(
            this, "m_driver", "m_vif", m_vif
        );

        // create sequencer component
        m_sequencer = ahb_lite_uvc_sequencer::type_id::create("m_sequencer", this);

        // set sequencer config
        m_sequencer.m_cfg = m_cfg;

    end

    // create monitor component
    m_monitor = ahb_lite_uvc_monitor::type_id::create("m_monitor", this);

    // set monitor config
    m_monitor.m_cfg = m_cfg;

    // set monitor virtual interface
    uvm_config_db#(virtual ahb_lite_uvc_if)::set(
        this, "m_monitor", "m_vif", m_vif
    );

    if(m_cfg.m_has_subscriber) begin

        // create subscriber component
        m_subscriber = ahb_lite_uvc_subscriber::type_id::create(
            "m_subscriber", this
        );

        // set subscriber config
        m_subscriber.m_cfg = m_cfg;

    end

endfunction : build_phase

// connect phase
function void ahb_lite_uvc_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // connect driver import to sequencer export
    if(m_cfg.m_is_active == UVM_ACTIVE) begin
        m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
    end

    // connect monitor analysis port to subscriber analysis export
    if(m_cfg.m_has_subscriber) begin
        m_monitor.m_aport.connect(m_subscriber.analysis_export);
    end

    // connect agent analysis port
    m_monitor.m_aport.connect(m_aport);

endfunction : connect_phase

`endif // AHB_LITE_UVC_AGENT_SV

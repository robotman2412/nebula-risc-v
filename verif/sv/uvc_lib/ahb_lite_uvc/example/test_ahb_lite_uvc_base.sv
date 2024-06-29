`ifndef TEST_AHB_LITE_UVC_BASE_SV
`define TEST_AHB_LITE_UVC_BASE_SV

class test_ahb_lite_uvc_base extends uvm_test;

    /* REGISTRATION MACRO */
    `uvm_component_utils(test_ahb_lite_uvc_base)

    /* COMPONENTS */
    ahb_lite_uvc_env_top m_env_top;

    /* CONFIG */
    ahb_lite_uvc_cfg_top m_cfg_top;

    /* UVM PHASESE */
    uvm_phase main_phase;

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void end_of_elaboration_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);

    extern virtual function void set_test_config();

endclass : test_ahb_lite_uvc_base

// constructor
function test_ahb_lite_uvc_base::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void test_ahb_lite_uvc_base::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // create configuration object
    m_cfg_top = ahb_lite_uvc_cfg_top::type_id::create("m_env_cfg", this);

    // set test config
    set_test_config();

    // set env top configuration
    uvm_config_db#(ahb_lite_uvc_cfg_top)::set(
        this,
        "m_env_top",
        "m_cfg",
        m_cfg_top
    );

    // create env top component
    m_env_top = ahb_lite_uvc_env_top::type_id::create("m_env_top", this);

endfunction : build_phase

// end of elaboration phase
function void test_ahb_lite_uvc_base::end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    // set drain time at end of simulation
    main_phase = phase.find_by_name("main", 0);
    main_phase.phase_done.set_drain_time(this, 10us);

endfunction : end_of_elaboration_phase

task test_ahb_lite_uvc_base::run_phase(uvm_phase phase);

    phase.raise_objection(this);
    `uvm_info(
        get_type_name(),
        "TEST STARTED",
        UVM_LOW
    )

    #10_000us;

    phase.drop_objection(this);
    `uvm_info(
        get_type_name(),
        "TEST FINISHED",
        UVM_LOW
    )

endtask : run_phase

// set test config
function void test_ahb_lite_uvc_base::set_test_config();
    // TODO
    m_cfg_top.m_env_cfg.m_agent_cfg.m_is_active = UVM_PASSIVE;
    m_cfg_top.m_env_cfg.m_agent_cfg.m_has_subscriber = 0;
endfunction : set_test_config

`endif // TEST_AHB_LITE_UVC_BASE

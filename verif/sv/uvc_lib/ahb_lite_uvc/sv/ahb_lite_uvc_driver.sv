`ifndef AHB_LITE_UVC_DRIVER_SV
`define AHB_LITE_UVC_DRIVER_SV

class ahb_lite_uvc_driver extends uvm_driver#(ahb_lite_uvc_item);

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_driver)

    /* CONFIGURATION REF */
    ahb_lite_uvc_agent_cfg m_cfg;

    /* VIRTUAL INTERFACE REF */
    virtual interface ahb_lite_uvc_if m_vif;

    /* DRIVER ITEM */
    REQ m_item;

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);

    extern local task process_item();
    extern local task handle_reset();

endclass : ahb_lite_uvc_driver

// constructor
function ahb_lite_uvc_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void ahb_lite_uvc_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // get virtual interface from DB
    if(!uvm_config_db#(virtual ahb_lite_uvc_if)::get(
        this, "", "m_vif", m_vif
    )) begin
        `uvm_fatal(get_type_name(), "Failed to get virtual interface from DB!")
    end

endfunction : build_phase

// run phase
task ahb_lite_uvc_driver::run_phase(uvm_phase phase);

    // initialize signal values
    // TODO

    forever begin : driver_run_phase_blk

        // wait for reset signal de-assertion
        wait(m_vif.HRESETn);

        // get next driver item
        seq_item_port.get_next_item(m_item);

        fork : process_item_fork_blk
            begin
                process_item();
            end
            begin
                handle_reset();
            end
        join_any // proces_item_fork_blk
        disable fork;

        // signal driver item done
        seq_item_port.item_done();

    end // driver_run_phase_blk

endtask : run_phase

// process driver item
task ahb_lite_uvc_driver::process_item();

    // print driver item
    `uvm_info(get_type_name(), {"\n", m_item.sprint()}, UVM_HIGH)

    // drive item
    // TODO

endtask : process_item

// handle reset
task ahb_lite_uvc_driver::handle_reset();

    // wait for reset assertion
    // TODO
    // @(posedge m_vif.rst);
    // @(negedge m_vif.rst_n);

    // print debug info
    `uvm_info(get_type_name(), "Reset signal asserted", UVM_HIGH)

endtask : handle_reset

`endif // AHB_LITE_UVC_DRIVER_SV

`ifndef AHB_LITE_UVC_MONITOR_SV
`define AHB_LITE_UVC_MONITOR_SV

class ahb_lite_uvc_monitor extends uvm_monitor;

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_monitor)

    /* ANALYSIS PORT */
    uvm_analysis_port#(ahb_lite_uvc_item) m_aport;

    /* CONFIGURATION REF */
    ahb_lite_uvc_agent_cfg m_cfg;

    /* VIRTUAL INTERFACE REF */
    virtual interface ahb_lite_uvc_if m_vif;

    /* MONITOR ITEM */
    ahb_lite_uvc_item   m_req_queue[$]; // bus request queue

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);

    extern local task collect_item();
    extern local task handle_reset();

endclass : ahb_lite_uvc_monitor

// constructor
function ahb_lite_uvc_monitor::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void ahb_lite_uvc_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);

    // create analysis port
    m_aport = new("m_aport", this);

    // get virtual interface from DB
    if(!uvm_config_db#(virtual ahb_lite_uvc_if)::get(
        this, "", "m_vif", m_vif
    )) begin
        `uvm_fatal(get_type_name(), "Failed to get virtual interface from DB!")
    end

endfunction : build_phase

// run phase
task ahb_lite_uvc_monitor::run_phase(uvm_phase phase);
    super.run_phase(phase);

    forever begin

        // wait for reset de-assertion
        wait(m_vif.HRESETn);

        fork : collect_item_fork_blk
            begin
                collect_item();
            end
            begin
                handle_reset();
            end
        join_any // collect_item_fork_blk
        disable fork;

    end

endtask : run_phase

task ahb_lite_uvc_monitor::collect_item();

    ahb_lite_uvc_item req_item;
    ahb_lite_uvc_item res_item;

    // wait for bus ready signal
    @(posedge m_vif.HCLK iff m_vif.HREADYOUT);

    // check if awaiting response from previous request
    if(m_req_queue.size() > 0) begin

        // get previous request data
        res_item = m_req_queue.pop_front();

        // if request was read transaction type, get read data from bus
        if(res_item.write == 0) res_item.data = m_vif.HRDATA;

        // print response item
        `uvm_info(get_type_name(), {"\n", res_item.sprint()}, UVM_HIGH)

        // write to analysis port
        m_aport.write(res_item);

    end

    // check if current bus cycle is a valid bus transaction request
    if(m_vif.HTRANS inside {TRANS_SEQ, TRANS_NONSEQ}) begin

        // create request item
        req_item = ahb_lite_uvc_item::type_id::create("req_item");

        // write bust transaction request data
        req_item.trans = m_vif.HTRANS;
        req_item.burst = m_vif.HBURST;
        req_item.addr  = m_vif.HADDR;
        req_item.data  = m_vif.HWDATA;
        req_item.write = m_vif.HWRITE;

        // insert bus transaction request to request queue
        m_req_queue.push_back(req_item);

    end

endtask : collect_item

// handle reset
task ahb_lite_uvc_monitor::handle_reset();

    // wait for reset assertion
    @(negedge m_vif.HRESETn);

    // print debug info
    `uvm_info(get_type_name(), "Reset signal asserted", UVM_HIGH)

endtask : handle_reset

`endif // AHB_LITE_UVC_MONITOR_SV

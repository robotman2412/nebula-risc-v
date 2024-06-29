`ifndef AHB_LITE_UVC_SUBSCRIBER_SV
`define AHB_LITE_UVC_SUBSCRIBER_SV

class ahb_lite_uvc_subscriber extends uvm_subscriber#(ahb_lite_uvc_item);

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_subscriber)

    /* CONFIGURATION REF */
    ahb_lite_uvc_agent_cfg m_cfg;

    /* SUBSCRIBER ITEM */
    ahb_lite_uvc_item m_item;

    /* COVERAGE GROUPS */
    // TODO

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void write(ahb_lite_uvc_item t);

endclass : ahb_lite_uvc_subscriber

// constructor
function ahb_lite_uvc_subscriber::new(string name, uvm_component parent);
    super.new(name, parent);

    // create covergroup instances
    // TODO

endfunction : new

// build phase
function void ahb_lite_uvc_subscriber::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

// write item
function void ahb_lite_uvc_subscriber::write(ahb_lite_uvc_item t);

    // clone item
    $cast(m_item, t.clone());

    // sample covergroups
    // TODO

endfunction : write

`endif // AHB_LITE_UVC_SUBSCRIBER_SV

`ifndef AHB_LITE_UVC_SEQUENCER_SV
`define AHB_LITE_UVC_SEQUENCER_SV

class ahb_lite_uvc_sequencer extends uvm_sequencer#(ahb_lite_uvc_item);

    /* REGISTRATION MACRO */
    `uvm_component_utils(ahb_lite_uvc_sequencer)

    /* CONFIGURATION REF */
    ahb_lite_uvc_agent_cfg m_cfg;

    /* METHODS */
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);

endclass : ahb_lite_uvc_sequencer

// constructor
function ahb_lite_uvc_sequencer::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

// build phase
function void ahb_lite_uvc_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase

`endif // AHB_LITE_UVC_SEQUENCER_SV

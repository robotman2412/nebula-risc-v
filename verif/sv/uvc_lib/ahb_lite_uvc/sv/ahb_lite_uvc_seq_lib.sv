`ifndef AHB_LITE_UVC_SEQ_LIB_SV
`define AHB_LITE_UVC_SEQ_LIB_SV

class ahb_lite_uvc_seq_base extends uvm_sequence#(ahb_lite_uvc_item);

    /* SEQUENCE FIELDS */
    // TODO

    /* CONSTRAINTS */
    // TODO

    /* SEQUENCE ITEM */
    REQ m_item;

    /* REGISTRATION MACRO */
    `uvm_object_utils_begin(ahb_lite_uvc_seq_base)
        // TODO
    `uvm_object_utils_end

    /* METHODS */
    extern function new(string name = "ahb_lite_uvc_seq_base");
    extern virtual task body();

endclass : ahb_lite_uvc_seq_base

// constructor
function ahb_lite_uvc_seq_base::new(string name = "ahb_lite_uvc_seq_base");
    super.new(name);
endfunction : new

// body
task ahb_lite_uvc_seq_base::body();
    // TODO
endtask : body

`endif // AHB_LITE_UVC_SEQ_LIB_SV

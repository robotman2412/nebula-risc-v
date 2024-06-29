`ifndef AHB_LITE_UVC_ITEM_SV
`define AHB_LITE_UVC_ITEM_SV

class ahb_lite_uvc_item extends uvm_sequence_item;

    /* ITEM FIELDS */
    rand ahb_lite_trans_e           trans;
    rand ahb_lite_burst_e           burst;
    rand logic [`ADDR_WIDTH-1:0]    addr;
    rand logic [`DATA_WIDTH-1:0]    data;
    rand bit                        write;

    /* CONSTRAINTS */
    // TODO

    /* REGISTRATION MACRO */
    `uvm_object_utils_begin(ahb_lite_uvc_item)
        `uvm_field_enum (ahb_lite_trans_e,  trans,  UVM_ALL_ON)
        `uvm_field_enum (ahb_lite_burst_e,  burst,  UVM_ALL_ON)
        `uvm_field_int  (                   addr,   UVM_ALL_ON)
        `uvm_field_int  (                   data,   UVM_ALL_ON)
        `uvm_field_int  (                   write,  UVM_ALL_ON)
    `uvm_object_utils_end

    /* METHODS */
    extern function new(string name = "ahb_lite_uvc_item");

endclass : ahb_lite_uvc_item

// constructor
function ahb_lite_uvc_item::new(string name = "ahb_lite_uvc_item");
    super.new(name);
endfunction : new

`endif // AHB_LITE_UVC_ITEM_SV

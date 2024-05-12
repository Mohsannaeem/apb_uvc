////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_agent
// Description    : APB RAL Adapter
///////////////////////////////////////////////////////////////////////
class apb_ral_adapter extends  uvm_reg_adapter;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_ral_adapter)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string name = "apb_ral_adapter");
    super.new(name);
    // Does the protocol the Agent is modeling support byte enables?
    // 0 = NO
    // 1 = YES
    supports_byte_enable = 0;

    // Does the Agent's Driver provide separate response sequence items?
    // i.e. Does the driver call seq_item_port.put()
    // and do the sequences call get_response()?
    // 0 = NO
    // 1 = YES
    provides_responses = 0;
  endfunction : new
  virtual function uvm_sequence_item reg2bus( const ref uvm_reg_bus_op rw);
      apb_mst_seq_item seq_item;
      seq_item = apb_mst_seq_item::type_id::create("seq_item");
      seq_item.write = (rw.kind ==UVM_READ) ? 1'b0 : 1'b1;
      seq_item.address = rw.addr;
      seq_item.wdata = rw.data;
      return seq_item;
  endfunction : reg2bus
  virtual  function void bus2reg(uvm_sequence_item bus_item,ref uvm_reg_bus_op rw);
    apb_mst_seq_item seq_item; 
    seq_item = apb_mst_seq_item::type_id::create("seq_item");
    if(!$cast(seq_item,bus_item)) begin
      `uvm_fatal(get_type_name(),"Bus Item to APB Mst Item Casting Failed")
      return;
    end
    else begin 
      rw.kind = (seq_item.write) ? UVM_WRITE : UVM_READ ;
      rw.addr = seq_item.address;
      rw.data = seq_item.rdata;
      rw.status = UVM_IS_OK;
    end 
  endfunction: bus2reg
endclass : apb_ral_adapter
////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_scrb
// Description    : APB Master Scoreboard which can be used to scoreboard the APB 
///////////////////////////////////////////////////////////////////////
class apb_mst_scrb extends  uvm_scoreboard;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  uvm_analysis_imp #(apb_mst_seq_item,apb_mst_scrb) ap_im; 
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_apb_mst_scrb and create
  `uvm_component_utils(apb_mst_scrb)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string apb_mst_scrb = "apb_mst_scrb", uvm_component parent=null);
    super.new(apb_mst_scrb, parent);
  endfunction : new
  function void build_phase(uvm_phase phase);
    ap_im = new ("ap_im",this);
  endfunction : build_phase

  virtual function void write(apb_mst_seq_item pkt);
    `uvm_info(get_type_name(),"data Recieved from uvm_analysis_imp",UVM_LOW);
    pkt.print();
  endfunction : write

  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(),"Run Phase Started",UVM_LOW);
    #500ns 
    `uvm_info(get_type_name(),"Run Phase Ended",UVM_LOW);
  endtask : run_phase

endclass : apb_mst_scrb
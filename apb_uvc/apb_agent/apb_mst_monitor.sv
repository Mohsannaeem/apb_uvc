////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_monitor
// Description    : Dummy monitor which can be used to create new monitor
///////////////////////////////////////////////////////////////////////
class apb_mst_monitor extends  uvm_monitor;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
virtual interface apb_mst_monitor_bfm apb_mst_mntr_bfm;
apb_mst_seq_item apb_item;
apb_agent_config apb_agnt_cfg;
int write_counter = 0,read_counter =0;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
`uvm_component_utils(apb_mst_monitor)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor

function new(string name = "apb_mst_monitor", uvm_component parent=null);
  super.new(name, parent);
endfunction : new

function void build_phase (uvm_phase phase);
  `uvm_info(get_type_name(),"Build Phase Started",UVM_FULL);
  super.build_phase(phase);
  apb_item = apb_mst_seq_item::type_id::create("apb_item",this);
  if(!(uvm_config_db#(apb_agent_config)::get(this, "", "agnt_cfg",apb_agnt_cfg)))
        `uvm_fatal(get_type_name(),"Unable to get the agent config");
    apb_mst_mntr_bfm = apb_agnt_cfg.apb_mst_mntr_bfm; 
  `uvm_info(get_type_name(),"Build Phase Ended",UVM_FULL);
endfunction : build_phase 

task run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name(),"Run Phase Started",UVM_FULL);
  forever 
  begin
    apb_mst_mntr_bfm.monitor(apb_item.address,apb_item.wdata,apb_item.rdata,apb_item.write,apb_item.pslverr);
    if(apb_item.pslverr) 
      `uvm_error(get_type_name(),"Slave Error for the following transaction"); 
    if(apb_item.write) begin
      write_counter++;
      `uvm_info(get_type_name(),$sformatf("\n/***** APB Write Transaction =%d",write_counter),UVM_MEDIUM);
      apb_item.print();
    end
    else begin
      read_counter++;
      `uvm_info(get_type_name(),$sformatf("\n/***** APB Read Transaction =%d",read_counter),UVM_MEDIUM);
      apb_item.print();
    end 
  end
  `uvm_info(get_type_name(),"Run Phase Ended",UVM_FULL);
endtask : run_phase

endclass : apb_mst_monitor
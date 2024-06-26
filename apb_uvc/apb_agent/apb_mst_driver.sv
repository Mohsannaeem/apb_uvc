////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_driver
// Description    : Dummy Driver which can be used to create new driver
///////////////////////////////////////////////////////////////////////
class apb_mst_driver extends  uvm_driver#(apb_mst_seq_item);

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
virtual interface apb_mst_driver_bfm apb_mst_drv_bfm;
apb_mst_seq_item apb_item;
apb_agent_config apb_agnt_cfg;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
`uvm_component_utils(apb_mst_driver)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor

function new(string name = "apb_mst_driver", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

function void build_phase (uvm_phase phase);
	`uvm_info(get_type_name(),"Build Phase Started",UVM_FULL);
	super.build_phase(phase);
  if(!(uvm_config_db#(apb_agent_config)::get(this, "", "agnt_cfg",apb_agnt_cfg)))
      `uvm_fatal(get_type_name(),"Unable to get the agent config");
  apb_mst_drv_bfm = apb_agnt_cfg.apb_mst_drv_bfm; 
  `uvm_info(get_type_name(),"Build Phase Ended",UVM_FULL);
endfunction : build_phase 

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_type_name(),"Run Phase Started",UVM_FULL);
	apb_mst_drv_bfm.init_zeros();
	forever 
	begin
		seq_item_port.get_next_item(apb_item);
		apb_mst_drv_bfm.execute(apb_item.address,
												apb_item.wdata,
												apb_item.write,
												apb_item.b2b_trans,
												apb_item.rdata,
                        apb_item.pslverr);
		seq_item_port.item_done();
	end 
	`uvm_info(get_type_name(),"Run Phase Ended",UVM_FULL);
endtask : run_phase

endclass : apb_mst_driver
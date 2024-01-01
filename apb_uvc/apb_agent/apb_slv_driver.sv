////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_slv_driver
// Description    : Dummy Driver which can be used to create new driver
///////////////////////////////////////////////////////////////////////
class apb_slv_driver extends  uvm_driver#(apb_slv_seq_item);

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
virtual apb_slave_bfm apb_slv_bfm;
apb_slv_seq_item apb_slv_req;
apb_slv_seq_item apb_slv_rsp;
apb_agent_config apb_agnt_cfg;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
`uvm_component_utils(apb_slv_driver)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_slv_driver", uvm_component parent=null);
	super.new(name, parent);
endfunction : new
function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	if(!(uvm_config_db#(apb_agent_config)::get(this, "", "agnt_cfg",apb_agnt_cfg)))
        `uvm_fatal(get_type_name(),"Unable to get the agent config");
  apb_slv_bfm=apb_agnt_cfg.apb_slv_bfm;
endfunction : build_phase 
task run_phase(uvm_phase phase);
	super.run_phase(phase);
	apb_slv_bfm.init_zeros();
	//Waiting for reset to deasserted
	apb_slv_bfm.wait_for_reset();
	`uvm_info(get_type_name(),"APB Reset Deasseted",UVM_FULL);
	forever 
	begin 
		seq_item_port.get_next_item(apb_slv_req);
		//Setup Phase activity
		apb_slv_bfm.setup_phase(apb_slv_req.address,
														apb_slv_req.rw);
		seq_item_port.item_done();
		seq_item_port.get_next_item(apb_slv_rsp);
		`uvm_info(get_type_name(),"Asserting APB Ready Asserted",UVM_FULL);
		//Access Phase Activity
		apb_slv_bfm.access_phase(apb_slv_rsp.rdata,apb_slv_rsp.delay,apb_slv_rsp.slv_err,apb_slv_rsp.data);
		seq_item_port.item_done();
	end
endtask : run_phase

endclass : apb_slv_driver
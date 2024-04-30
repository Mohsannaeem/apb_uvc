////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_agent
// Description    : Dummy Agent which can be used to create new agent
///////////////////////////////////////////////////////////////////////

class apb_mst_agent extends uvm_agent;
	/****************************************************************/
	//	Factory Registeration 
	/****************************************************************/
	`uvm_component_utils(apb_mst_agent)
	
	/****************************************************************/
	//	Variable Handlers
	/****************************************************************/
	apb_mst_driver 				apb_mst_drv;
	apb_mst_sequencer			apb_mst_sqr;
	apb_mst_monitor				apb_mst_mntr;
	apb_agent_config	    apb_agnt_cfg;
	/****************************************************************/
	//	Default Contructor
	/****************************************************************/
	function new(string name="apb_mst_agent",uvm_component parent =null);
		super.new(name,parent);
	endfunction : new
	/****************************************************************/
	//	Build phase 
	/****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(),"Build Phase Started",UVM_FULL);
		if(!(uvm_config_db#(apb_agent_config)::get(this, "", "agnt_cfg",apb_agnt_cfg)))
        `uvm_fatal(get_type_name(),"Unable to get the agent config");
    if(apb_agnt_cfg.is_mst_active == 1) begin
      apb_mst_sqr 	= apb_mst_sequencer::type_id::create("apb_mst_sqr",this);
		  apb_mst_drv 	= apb_mst_driver::type_id::create("apb_mst_drv",this);
		end
    apb_mst_mntr	= apb_mst_monitor::type_id::create("apb_mst_mntr",this);
    `uvm_info(get_type_name(),"Build Phase Ended",UVM_FULL);
		  
	endfunction : build_phase
	/****************************************************************/
	//	Connect Phase
	/****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(),"Connect Phase Started",UVM_FULL);
		if(apb_agnt_cfg.is_mst_active == 1)
		begin
			apb_mst_drv.seq_item_port.connect(apb_mst_sqr.seq_item_export);
		end
		`uvm_info(get_type_name(),"Connect Phase Ended",UVM_FULL);
	endfunction : connect_phase

endclass : apb_mst_agent

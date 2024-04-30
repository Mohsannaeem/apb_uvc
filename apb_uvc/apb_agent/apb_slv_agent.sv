////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_slv_agent
// Description    : Dummy Agent which can be used to create new agent
///////////////////////////////////////////////////////////////////////

class apb_slv_agent extends uvm_agent;
	/****************************************************************/
	//	Factory Registeration 
	/****************************************************************/
	`uvm_component_utils(apb_slv_agent)
	
	/****************************************************************/
	//	Variable Handlers
	/****************************************************************/
	apb_slv_driver 				apb_slv_drv;
	apb_slv_sequencer			apb_slv_sqr;
	apb_slv_monitor				apb_slv_mntr;
	apb_agent_config 			apb_agnt_cfg;
	/****************************************************************/
	//	Default Contructor
	/****************************************************************/
	function new(string name="apb_slv_agent",uvm_component parent =null);
		super.new(name,parent);
	endfunction : new
	/****************************************************************/
	//	Build phase 
	/****************************************************************/
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
    if(!(uvm_config_db#(apb_agent_config)::get(this, "", "agnt_cfg",apb_agnt_cfg)))
        `uvm_fatal(get_type_name(),"Unable to get the agent config");
    if(apb_agnt_cfg.is_slv_active == 1) begin
   	  apb_slv_sqr 	= apb_slv_sequencer::type_id::create("apb_slv_sqr",this);
		  apb_slv_drv 	= apb_slv_driver::type_id::create("apb_slv_drv",this);
		end
    apb_slv_mntr	= apb_slv_monitor::type_id::create("apb_slv_mntr",this);
	endfunction : build_phase
	/****************************************************************/
	//	Connect Phase
	/****************************************************************/
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		if(apb_agnt_cfg.is_slv_active == 1)
		begin
			apb_slv_drv.seq_item_port.connect(apb_slv_sqr.seq_item_export);
		end
	endfunction : connect_phase

endclass : apb_slv_agent

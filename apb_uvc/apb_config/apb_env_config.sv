////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_env_config
// Description    : Dummy config which can be used to create new config
///////////////////////////////////////////////////////////////////////
class apb_env_config extends  uvm_component;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	uvm_cmdline_processor cmpld;
  apb_agent_config apb_agnt_cfg;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(apb_env_config)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "apb_env_config", uvm_component parent=null);
		super.new(name, parent);
    apb_agnt_cfg = apb_agent_config::type_id::create("apb_agnt_cfg",this);
	endfunction : new
	function void post_randomize();
		super.post_randomize();

	endfunction : post_randomize 

endclass : apb_env_config
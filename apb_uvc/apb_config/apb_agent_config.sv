////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_agent_config
// Description    : Dummy Agent Config which can be used to create new Agent Config
///////////////////////////////////////////////////////////////////////
class apb_agent_config extends uvm_component;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
 virtual apb_master_bfm apb_mst_bfm;
 virtual apb_slave_bfm  apb_slv_bfm;
 bit                    is_active;
 int                    no_of_trans;
 string                 apb_ver = "APB3";
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_component_utils(apb_agent_config)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_agent_config", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

endclass : apb_agent_config
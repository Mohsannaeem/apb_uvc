////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_sequencer
// Description    : Dummy sequencer which can be used to create new sequencer
///////////////////////////////////////////////////////////////////////
class apb_mst_sequencer extends  uvm_sequencer#(apb_mst_seq_item);

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_component_utils(apb_mst_sequencer)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "apb_mst_sequencer", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

endclass : apb_mst_sequencer
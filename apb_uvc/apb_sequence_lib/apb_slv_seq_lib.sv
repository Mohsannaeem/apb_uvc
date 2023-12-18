////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_slv_base_sequence
// Description    : Dummy Base Sequence which can be used to create new base  Sequence
///////////////////////////////////////////////////////////////////////
class apb_slv_base_sequence extends uvm_sequence#(apb_slv_seq_item);

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	apb_slv_seq_item apb_slv_seq_req;
	apb_slv_seq_item apb_slv_seq_rsp;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
	`uvm_object_utils(apb_slv_base_sequence)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "apb_slv_base_sequence");
		super.new(name);
	endfunction : new
	task body ();
		`uvm_info(get_type_name,"APB Slave Sequence Body Started",UVM_FULL);
		apb_slv_seq_req=apb_slv_seq_item::type_id::create("apb_slv_seq_req");
		apb_slv_seq_rsp=apb_slv_seq_item::type_id::create("apb_slv_seq_rsp");
		//TODO Get apb_agent config using sequencer m_sequencer
		//TODO Wait foor reset before driving the sequence 
		forever 
		begin
			start_item(apb_slv_seq_req);
			`uvm_info(get_type_name,"APB Request Started",UVM_FULL);
			finish_item(apb_slv_seq_req);
			`uvm_info(get_type_name,"APB Request Done",UVM_FULL);
			// apb_slv_seq_req.print();
			start_item(apb_slv_seq_rsp);
			`uvm_info(get_type_name,"APB Response Start",UVM_FULL);
			if(apb_slv_seq_req.rw) begin 
				//TODO : Think about memory here or in slave driver
				// memory[apb_slv_seq_req.addr]=apb_slv_req.data
			end
      else begin 
        `uvm_info(get_type_name(),"Read Request Recieved",UVM_FULL);
      end  
			apb_slv_seq_rsp.copy(apb_slv_seq_req);
			// apb_slv_seq_rsp.print();
			apb_slv_seq_rsp.randomize();
			finish_item(apb_slv_seq_rsp);
			`uvm_info(get_type_name,"APB Response Ended",UVM_FULL);
		end
		`uvm_info(get_type_name,"APB Slave Sequence Body Ended",UVM_FULL);
	endtask : body
  
endclass : apb_slv_base_sequence
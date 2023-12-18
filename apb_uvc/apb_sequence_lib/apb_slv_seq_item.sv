////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_slv_seq_item
// Description    : Dummy seq_item which can be used to create new seq_item
///////////////////////////////////////////////////////////////////////
class apb_slv_seq_item extends uvm_sequence_item;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
logic [31:0]	address;
logic [31:0]	data;
logic					rw;

rand logic [31:0]	rdata ; 
rand logic 				slv_err;
rand int 					delay;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_object_utils(apb_slv_seq_item)

/*-------------------------------------------------------------------------------
-- Default Constraints
-------------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_slv_seq_item");
	super.new(name);
endfunction : new

function void do_copy(uvm_object rhs);
	apb_slv_seq_item rhs_;
	if(!$cast(rhs_,rhs))
	begin
			`uvm_error("do_copy","Cast Failed");
			return;
	end
	super.do_copy(rhs_);
	address = rhs_.address;
	data 		= rhs_.data;
	rw 			=	rhs_.rw;
	rdata		= rhs_.rdata;
	slv_err = rhs_.slv_err;
	delay		=	rhs_.delay; 
endfunction
function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	apb_slv_seq_item rhs_;
	if(!$cast(rhs,rhs))begin
		`uvm_error("do_compare","Cast Failed");
		return -1;
	end
	return(super.do_compare(rhs,comparer)	&&
		(address	==	rhs_.address)	&&
		(data 		==	rhs_.data)	&&
		(rw				==	rhs_.rw)	&&
		(rdata		==	rhs_.rdata)	&&
		(slv_err	==	rhs_.slv_err)	&&
		(delay		==	rhs_.delay));
endfunction
function string convert2string();
	string str;
	str  =	super.convert2string();
	$sformat(str,"%s\n address \t%0h\n data \t%0h\n rw \t%b\n rdata \t%0h\n slv_err \t%0b\n delay \t%d\n",
								str,address,data,rw,rdata,slv_err,delay);
	return str;
endfunction
function void do_print(uvm_printer printer);
	$display(convert2string());
endfunction
function void do_record(uvm_recorder recorder);
	super.do_record(recorder);
	`uvm_record_field("address",address)
	`uvm_record_field("data",data)
	`uvm_record_field("rw",rw)
	`uvm_record_field("rdata",rdata)
	`uvm_record_field("slv_err",slv_err)
	`uvm_record_field("delay",delay)
endfunction

endclass : apb_slv_seq_item
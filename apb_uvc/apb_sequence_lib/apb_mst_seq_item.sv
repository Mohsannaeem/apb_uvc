////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_seq_item
// Description    : Dummy seq_item which can be used to create new seq_item
///////////////////////////////////////////////////////////////////////
class apb_mst_seq_item extends uvm_sequence_item;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
rand logic [31:0]	address;
rand logic [31:0]	wdata;
rand logic 		  	write;
rand logic		  	b2b_trans;
logic [31:0]      rdata;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_object_utils(apb_mst_seq_item)

/*-------------------------------------------------------------------------------
-- Default Constraints
-------------------------------------------------------------------------------*/
 constraint dist_trans_type { write dist{0:=50,1:=50};}
 constraint dist_b2b_trans  { b2b_trans dist{0:=50,1:=50};}

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_mst_seq_item");
	super.new(name);
endfunction : new

function void do_copy(uvm_object rhs);
	apb_mst_seq_item rhs_;
	if (!$cast(rhs_,rhs)) begin
		`uvm_error("do_copy","Cast Failed");
		return;
	end
	super.do_copy(rhs_);
	address = rhs_.address;
	wdata	=	rhs_.wdata;
	write	=	rhs_.write;
	b2b_trans	=	rhs_.b2b_trans;
  rdata  = rhs_.rdata;
endfunction:do_copy

function bit do_compare(uvm_object rhs, uvm_comparer comparer);
	apb_mst_seq_item rhs_;
	if (!$cast(rhs_,rhs)) begin
		`uvm_error("do_compare","cast failed");
		return -1;
	end
	return ((super.do_compare(rhs_,comparer)) &&
	(address == rhs_.address)&&
	(wdata	==	rhs_.wdata)&&
	(write	==	rhs_.write)&&
	(b2b_trans	==	rhs_.b2b_trans)&&
  (rdata ==  rhs_.rdata));
endfunction : do_compare
function string convert2string();
	string str;
	str = super.convert2string();
	$sformat(str,"\t%s\n address \t%0h\n wdata \t%0h\n write \t%0b\n b2b_trans \t%0b\n rdata \t%0h\n",str,address,wdata,write,b2b_trans,rdata);
  return str;	
endfunction : convert2string
function void do_print(uvm_printer printer);
	$display(convert2string());
endfunction: do_print
function void do_record(uvm_recorder recorder);
  super.do_record(recorder);
  `uvm_record_field("address",address)
  `uvm_record_field("wdata",wdata)
  `uvm_record_field("write",write)
  `uvm_record_field("b2b_trans",b2b_trans)
  `uvm_record_field("rdata",rdata)
endfunction
	
endclass : apb_mst_seq_item
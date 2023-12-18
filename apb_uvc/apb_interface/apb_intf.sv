////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_intf
// Description    : Dummy interface which can be used to create new interface
///////////////////////////////////////////////////////////////////////
interface apb_intf(input logic clk,input logic resetn);
	logic 				psel;
	logic 				penable;
	logic [31:0]	paddr;
	logic 				pwrite;
	logic [31:0]	pwdata;
	logic [31:0]	prdata;
	logic					pready;
	logic					pslverr;
endinterface
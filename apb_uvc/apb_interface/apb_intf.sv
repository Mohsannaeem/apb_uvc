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

  //Assertion Setup for APB Interface 
  // check for not of psel x or z 
  property psel_xz ;
    @(posedge clk) disable iff(!resetn) !$isunknown(psel); 
  endproperty :psel_xz
  // check for not of penable x or z 
  property penable_xz;
    @(posedge clk) disable iff(!resetn) !$isunknown(penable);
  endproperty : penable_xz
  // check for not of pwrite x or z
  property pwrite_xz ;
    @(posedge clk) disable iff(!resetn) !$isunknown(pwrite);
  endproperty : pwrite_xz
  // check for not of pready x or z
  property pready_xz;
    @(posedge clk) disable iff(!resetn) !$isunknown(pready);
  endproperty : pready_xz
  // check for not of pslverr x or z 
  property pslverr_xz;
    @(posedge clk) disable iff(!resetn) !$isunknown(pslverr);
  endproperty : pslverr_xz

  // Asserting the properties
  assert property (psel_xz)    else $error("psel_xs    Failed : PSEL is x or z"); 
  assert property (penable_xz) else $error("penable_xs Failed : PENABLE is x or z"); 
  assert property (pwrite_xz)  else $error("pwrite_xz  Failed : PWRITE is x or z"); 
  assert property (pready_xz)  else $error("pready_xz  Failed : PREADY is x or z"); 
  assert property (pslverr_xz) else $error("pslverr_xz Failed : PSEL is x or z"); 

endinterface
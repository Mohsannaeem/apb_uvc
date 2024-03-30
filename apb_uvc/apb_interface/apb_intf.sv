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
  // Sequences 
  sequence setup_phase_write;
    $rose(psel) and $rose(pwrite) and !pready and !penable;
  endsequence : setup_phase_write
  sequence setup_phase_read ;
    $rose(psel) and $rose(!pwrite) and !pready and !penable;
  endsequence : setup_phase_read
  sequence access_phase_write;
    $rose(penable) and $rose(pready) and $stable(psel) and $stable(pwrite) and $stable(paddr) and $stable(pwdata);
  endsequence 
  sequence access_phase_read; 
    $rose(penable) and $rose(pready) and $stable(psel) and $stable(!pwrite) and $stable(paddr);
  endsequence : access_phase_read
  property read_test;
    @(posedge clk) disable iff (!resetn)
      setup_phase_read |=> access_phase_read ; 
  endproperty : read_test
  property write_test ;
    @(posedge clk) disable iff(!resetn)
      setup_phase_write |=> access_phase_write;
  endproperty
  // Asserting the properties
  assert property (psel_xz)    else $error("Assertion psel_xs    Failed : PSEL is x or z"); 
  assert property (penable_xz) else $error("Assertion penable_xs Failed : PENABLE is x or z"); 
  assert property (pwrite_xz)  else $error("Assertion pwrite_xz  Failed : PWRITE is x or z"); 
  assert property (pready_xz)  else $error("Assertion pready_xz  Failed : PREADY is x or z"); 
  assert property (pslverr_xz) else $error("Assertion pslverr_xz Failed : PSEL is x or z"); 
  assert property (read_test)  else $error($sformatf ("Assertion read_test failed with psel value : %b, pwrite value : %b, pready value : %b, penable value %b , paddr: %h, prdata %h,",$sampled(psel),$sampled(pwrite),$sampled(pready),$sampled(penable),$sampled(paddr),$sampled(prdata))); 
  assert property (write_test) else $error($sformatf ("Assertion write_test failed with psel value : %b, pwrite value : %b, pready value : %b, penable value %b , paddr: %h, pwdata %h,",$sampled(psel),$sampled(pwrite),$sampled(pready),$sampled(penable),$sampled(paddr),$sampled(pwdata))); 
endinterface
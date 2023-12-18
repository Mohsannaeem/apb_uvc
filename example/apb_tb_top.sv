////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : tb_top 
// Description    : APb TB Top to connect the apb master and slave interface
///////////////////////////////////////////////////////////////////////
`timescale 1ps/1fs;
module apb_tb_top ();
	import uvm_pkg::*;
	import apb_test_pkg::*;
	logic clk, resetn;
	apb_intf apb_if(.clk(clk),.resetn(resetn));
  apb_master_bfm apb_mst_bfm(apb_if);
  apb_slave_bfm apb_slv_bfm(apb_if);
	initial begin
		clk =0; 
		forever 
			clk = #50 ~clk;
	end 
	initial begin 
		resetn = 0;
		#10ns
		resetn = 1;
	end
	initial begin 
		uvm_config_db#(virtual apb_master_bfm)::set(null, "uvm_test_top", "apb_mst_bfm",apb_mst_bfm);
    uvm_config_db#(virtual apb_slave_bfm)::set(null, "uvm_test_top", "apb_slv_bfm",apb_slv_bfm);
	end 
	initial begin 
		run_test("apb_base_test");
	end


endmodule
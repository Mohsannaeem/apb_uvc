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
  `ifndef TB_MASTER_DRIVER_DISABLE
    apb_mst_driver_bfm  apb_mst_drv_bfm(apb_if);
  `endif
  apb_mst_monitor_bfm apb_mst_mntr_bfm(apb_if);
  `ifndef TB_SLAVE_DRIVER_DISABLE
    apb_slv_driver_bfm apb_slv_drv_bfm(apb_if);
  `endif
  apb_slv_monitor_bfm apb_slv_mntr_bfm(apb_if);
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
		`ifndef TB_MASTER_DRIVER_DISABLE
      uvm_config_db#(virtual apb_mst_driver_bfm)::set(null, "uvm_test_top", "apb_mst_drv_bfm",apb_mst_drv_bfm);
    `endif
    `ifndef TB_SLAVE_DRIVER_DISABLE
      uvm_config_db#(virtual apb_slv_driver_bfm)::set(null, "uvm_test_top", "apb_slv_drv_bfm",apb_slv_drv_bfm);
    `endif
    uvm_config_db#(virtual apb_slv_monitor_bfm)::set(null, "uvm_test_top", "apb_slv_mntr_bfm",apb_slv_mntr_bfm);
    uvm_config_db#(virtual apb_mst_monitor_bfm)::set(null, "uvm_test_top", "apb_mst_mntr_bfm",apb_mst_mntr_bfm);
	end 
	initial begin 
		run_test("apb_base_test");
	end
  `ifndef TB_RDL_DISABLE
    atxmega_spi_pkg::atxmega_spi__in_t hwif_in;
    atxmega_spi_pkg::atxmega_spi__out_t hwif_out;
    atxmega_spi i_atxmega_spi (
      .clk          (clk          ), // TODO: Check connection ! Signal/port not matching : Expecting logic  -- Found forever 
      .rst          (~resetn      ),
      .s_apb_psel   (apb_if.psel   ),
      .s_apb_penable(apb_if.penable),
      .s_apb_pwrite (apb_if.pwrite ),
      .s_apb_paddr  (apb_if.paddr  ),
      .s_apb_pwdata (apb_if.pwdata ),
      .s_apb_pready (apb_if.pready ),
      .s_apb_prdata (apb_if.prdata ),
      .s_apb_pslverr(apb_if.pslverr),
      .hwif_in      (hwif_in      ),
      .hwif_out     (hwif_out     )
    );
  `endif

endmodule
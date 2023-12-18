interface apb_slave_bfm(apb_intf apb_slv_if);
  task init_zeros();
    apb_slv_if.prdata <= 0;
    apb_slv_if.pready <= 0;
    apb_slv_if.pslverr  <= 0;
  endtask : init_zeros

  task wait_for_reset();
    wait(apb_slv_if.resetn);  
  endtask : wait_for_reset
  
  task setup_phase(output logic [31:0] address,
                   output logic rw);
    wait(apb_slv_if.psel);
    $display("APB slave BFM","APB Sel Asserted");
    @(posedge apb_slv_if.clk);
    wait(apb_slv_if.penable);
    $display("APB slave BFM","APB Enable Asserted");
    address = apb_slv_if.paddr;
    rw = apb_slv_if.pwrite;
  endtask : setup_phase
  
  task access_phase(input logic [31:0] rdata,
                    output logic [31:0] wdata);
    @(posedge apb_slv_if.clk);
    apb_slv_if.pready =1;
    if(apb_slv_if.pwrite)
      wdata = apb_slv_if.pwdata;
    else
      apb_slv_if.prdata = rdata;
    @(posedge apb_slv_if.clk);
    apb_slv_if.pready =0;
  endtask : access_phase

  task monitor(output logic[31:0] address,
               output logic[31:0] wdata,
               output logic[31:0] rdata,
               output logic       rw 
                );
    wait(apb_slv_if.psel);
    @(posedge apb_slv_if.clk);
    wait(apb_slv_if.penable);
    @(posedge apb_slv_if.clk);
    address = apb_slv_if.paddr;
    rw = apb_slv_if.pwrite;
    wait(apb_slv_if.pready);
    rdata = apb_slv_if.prdata;
    wdata = apb_slv_if.pwdata;

   endtask : monitor 

endinterface
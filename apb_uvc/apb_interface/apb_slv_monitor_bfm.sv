interface apb_slv_monitor_bfm(apb_intf apb_slv_if);
  task monitor(output logic[31:0] address,
               output logic[31:0] wdata,
               output logic[31:0] rdata,
               output logic       rw,
               output logic[31:0] delay,
               output logic       slverr
                );
    @(posedge apb_slv_if.clk);
    wait(apb_slv_if.psel);
    @(posedge apb_slv_if.clk);
    wait(apb_slv_if.penable);
    @(posedge apb_slv_if.clk);
    address = apb_slv_if.paddr;
    rw = apb_slv_if.pwrite;
    wdata  = apb_slv_if.pwdata;
    @(posedge apb_slv_if.clk)
    wait(apb_slv_if.pready);
    $display("Time %t",$time(),"Ready Asserted in Slave Monitor");
    delay=0;
    slverr = apb_slv_if.pslverr;
    rdata  = apb_slv_if.prdata;

   endtask : monitor 
endinterface
interface apb_mst_monitor_bfm (apb_intf apb_mst_if);

task monitor(output logic [31:0] address,
            output logic[31:0]   wdata , 
            output logic [31:0]  rdata ,
            output logic         write,
            output logic         pslverr);
  if(apb_mst_if.resetn ==0 && (apb_mst_if.psel ==1 || apb_mst_if.penable ==1)) begin 
    $display("Error", "APB Sel or Enable is asserted in reset state");
  end  
  @(posedge apb_mst_if.clk);
  wait(apb_mst_if.psel);
  @(posedge apb_mst_if.clk);
  wait(apb_mst_if.penable);
  @(posedge apb_mst_if.clk);
  address = apb_mst_if.paddr;
  write = apb_mst_if.pwrite;
  wait(apb_mst_if.pready);
  wdata = apb_mst_if.pwdata;
  rdata = apb_mst_if.prdata;
  pslverr = apb_mst_if.pslverr;

endtask : monitor

endinterface
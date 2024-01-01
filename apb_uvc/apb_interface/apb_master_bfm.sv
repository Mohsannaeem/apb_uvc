interface apb_master_bfm(apb_intf apb_mst_if);

task init_zeros();
  apb_mst_if.psel     <= 0;
  apb_mst_if.penable  <= 0;
  apb_mst_if.paddr    <= 0;
  apb_mst_if.pwrite   <= 0;
  apb_mst_if.pwdata   <= 0;
endtask : init_zeros
task wait_for_reset();
  wait(apb_mst_if.resetn);
endtask : wait_for_reset

task execute(input logic [31:0]   address, //32b APB address
             input logic [31:0]   data,    //32b APB data
             input logic          rw, //Set 1 for write and 0 for read
             input logic          b2b_trans,
             output logic [31:0]  rdata);
  if(rw)
    begin 
      $display("Write Transaction Started");
      write_if(address,b2b_trans,data);
      $display("Write Transaction Done");
    end
    else begin
      $display("Read Transaction Started");
      read_if(address,b2b_trans,rdata);
      $display("Read Transaction Started");
    end
endtask : execute
task write_if(input logic [31:0] address,
              input logic        b2b_trans,
              input logic [31:0] wdata);
  wait_for_reset();
  @(posedge apb_mst_if.clk);
  apb_mst_if.psel <= 1'b1;
  apb_mst_if.pwrite   <= 1;
  apb_mst_if.paddr <= address;
  apb_mst_if.pwdata <= wdata;
  @(posedge apb_mst_if.clk)
  apb_mst_if.penable <= 1'b1;
  wait(apb_mst_if.pready);
  if(!b2b_trans) begin
    @(posedge apb_mst_if.clk);
    apb_mst_if.psel <= 1'b0;
    apb_mst_if.penable <= 1'b0;
  end 
endtask : write_if 

task read_if(input logic [31:0] address,
             input logic        b2b_trans,
             output logic[31:0] rdata);
  wait_for_reset();
  @(posedge apb_mst_if.clk);
  apb_mst_if.psel <= 1'b1;
  apb_mst_if.paddr <= address;
  apb_mst_if.pwrite   <= 0;
  @(posedge apb_mst_if.clk)
  apb_mst_if.penable <= 1'b1;
  wait(apb_mst_if.pready);
  rdata <= apb_mst_if.prdata;
  apb_mst_if.pwdata <=32'h0;
  if(!b2b_trans)begin
    @(posedge apb_mst_if.clk);
    apb_mst_if.psel <= 1'b0;
    apb_mst_if.penable <= 1'b0;
  end 
endtask : read_if

task monitor(output logic [31:0] address,
            output logic[31:0]   wdata , 
            output logic [31:0]  rdata ,
            output logic         write );
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

endtask : monitor

endinterface
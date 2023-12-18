class apb_mst_virtual_sequence extends uvm_sequence;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  rand int unsigned no_of_transaction;
  apb_mst_base_sequence rand_seq;
  apb_write_sequence write_seq;
  apb_read_sequence read_seq;
  apb_b2b_write_sequence b2b_write_seq;
  apb_b2b_read_sequence b2b_read_seq;
  constraint no_of_trans {no_of_transaction inside {[5:20]};}
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_mst_virtual_sequence)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string name = "apb_mst_virtual_sequence");
    super.new(name);
  endfunction : new

  task body();
    rand_seq  = apb_mst_base_sequence::type_id::create("rand_rd_wr_sequence");
    write_seq = apb_write_sequence::type_id::create("Write_sequence");
    read_seq  = apb_read_sequence::type_id::create("Read Sequence");
    b2b_write_seq = apb_b2b_write_sequence::type_id::create("b2b_write_seq");
    b2b_read_seq  = apb_b2b_read_sequence::type_id::create("b2b_read_seq");
    `uvm_info(get_type_name(),$sformatf("No of no_of_trans",no_of_transaction),UVM_FULL);
    for (int i = 0; i < no_of_transaction; i++) begin
      rand_seq.start(m_sequencer);
    end
    for (int i = 0; i < no_of_transaction; i++) begin
      write_seq.start(m_sequencer);
    end
    for (int i = 0; i < no_of_transaction; i++) begin
      read_seq.start(m_sequencer);
    end
    for (int i = 0; i < no_of_transaction; i++) begin
      b2b_write_seq.start(m_sequencer);
    end
    for (int i = 0; i < no_of_transaction; i++) begin
      b2b_read_seq.start(m_sequencer);
    end

  endtask : body
endclass : apb_mst_virtual_sequence
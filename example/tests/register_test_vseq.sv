
class register_test_vseq extends uvm_sequence;

  `uvm_object_utils(register_test_vseq)
  atxmega_spi reg_mdl;

  function new(string name = "register_test_vseq");
    super.new(name);
  endfunction

  task body;
    uvm_reg_hw_reset_seq reg_seq = uvm_reg_hw_reset_seq::type_id::create("reg_seq");
    reg_seq.model = reg_mdl;
    super.body;
    reg_seq.start(m_sequencer);
  endtask: body

endclass: register_test_vseq
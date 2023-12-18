////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_mst_base_sequence
// Description    : APB Base Sequence which can be used to create new base  Sequence
///////////////////////////////////////////////////////////////////////
class apb_mst_base_sequence extends uvm_sequence#(apb_mst_seq_item);
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  apb_mst_seq_item apb_seq_itm;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_mst_base_sequence)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
  function new(string name = "apb_mst_base_sequence");
  	super.new(name);
  endfunction : new

  task body ();
    `uvm_info(get_type_name(),"Body Task started",UVM_FULL)
    apb_seq_itm=apb_mst_seq_item::type_id::create("apb_seq_itm");
    // apb_seq_itm.print();
    start_item(apb_seq_itm);
    `uvm_info(get_type_name(),"Start Sequence Item",UVM_FULL)
    apb_seq_itm.randomize();
    finish_item(apb_seq_itm);
    `uvm_info(get_type_name(),"Finish Sequence Item",UVM_FULL)
    `uvm_info(get_type_name(),"Body Task Ended",UVM_FULL)
  endtask : body

endclass : apb_mst_base_sequence

class apb_write_sequence extends  apb_mst_base_sequence;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  apb_mst_seq_item apb_seq_itm;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_write_sequence)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string name = "apb_write_sequence");
    super.new(name);
  endfunction : new

  task body();
    `uvm_info(get_type_name(),"Body Task started",UVM_FULL);
    apb_seq_itm=apb_mst_seq_item::type_id::create("apb_seq_itm");
    start_item(apb_seq_itm);
    `uvm_info(get_type_name(),"Start Sequence Item",UVM_FULL)
    if(!(apb_seq_itm.randomize() with{apb_seq_itm.write==1;}))
      `uvm_fatal(get_type_name(),"Unable to randomize the sequence item");
    finish_item(apb_seq_itm);
    `uvm_info(get_type_name(),"Finish Sequence Item",UVM_FULL)
    `uvm_info(get_type_name(),"Body Task Ended",UVM_FULL)
  endtask : body

endclass : apb_write_sequence

class apb_read_sequence extends  apb_mst_base_sequence;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  apb_mst_seq_item apb_seq_itm;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_read_sequence)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string name = "apb_read_sequence");
    super.new(name);
  endfunction : new

  task body();
    `uvm_info(get_type_name(),"Body Task started",UVM_FULL);
     
    apb_seq_itm=apb_mst_seq_item::type_id::create("apb_seq_itm");
    start_item(apb_seq_itm);
    if(!(apb_seq_itm.randomize() with {apb_seq_itm.write==0;}))
      `uvm_fatal(get_type_name(),"Unable to randomize the seq item");
    finish_item(apb_seq_itm);  
  endtask : body

endclass : apb_read_sequence

class apb_b2b_write_sequence extends  apb_mst_base_sequence;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  apb_mst_seq_item apb_seq_itm;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_b2b_write_sequence)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string name = "apb_b2b_write_sequence");
    super.new(name);
  endfunction : new

  task body();
    apb_seq_itm = apb_mst_seq_item::type_id::create("apb_seq_itm");
    start_item(apb_seq_itm);
    if(!(apb_seq_itm.randomize() with
                                {apb_seq_itm.write==1;
                                 apb_seq_itm.b2b_trans==1;}))
      `uvm_fatal(get_type_name(),"Unabe to randomize the seqence item");
    finish_item(apb_seq_itm);
  endtask : body

endclass : apb_b2b_write_sequence

class apb_b2b_read_sequence extends  apb_mst_base_sequence;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  apb_mst_seq_item apb_seq_itm;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
  // Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils(apb_b2b_read_sequence)

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Constructor
  function new(string name = "apb_b2b_read_sequence");
    super.new(name);
  endfunction : new

  task body();
    apb_seq_itm= apb_mst_seq_item::type_id::create("apb_seq_itm");
    start_item(apb_seq_itm);
    if(!(apb_seq_itm.randomize() with {apb_seq_itm.write==0;
                                  apb_seq_itm.b2b_trans == 1;}))
      `uvm_fatal(get_type_name(),"Unable to randomize the apb_seq_itm");
    finish_item(apb_seq_itm);
  endtask : body

endclass : apb_b2b_read_sequence
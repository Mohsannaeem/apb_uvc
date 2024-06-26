////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_test_pkg
// Description    : Base Test  which can be used an example to make a uvc
///////////////////////////////////////////////////////////////////////
class apb_b2b_test extends apb_base_test ;
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
apb_mst_virtual_sequence apb_mst_virt_seq;
apb_slv_rnd_dly_sequence apb_slv_rnd_dly_seq;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_component_utils(apb_b2b_test)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_b2b_test", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"Build Phase Started",UVM_FULL)
	apb_mst_virt_seq     = apb_mst_virtual_sequence::type_id::create("apb_mst_virt_seq");
	apb_slv_rnd_dly_seq  = apb_slv_rnd_dly_sequence::type_id::create("apb_slv_rnd_dly_seq");
  set_env_config(apb_env_cfg);
  `uvm_info(get_type_name(),"Build Phase Ended",UVM_FULL)
endfunction : build_phase

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_type_name(),"Run Phase Started",UVM_FULL)
	phase.raise_objection(this);
	fork 
    begin 
      fork
        begin 
          if(!(apb_mst_virt_seq.randomize())) 
            `uvm_fatal(get_type_name(),"Unable to randomize the virtual sequence");
        	apb_mst_virt_seq.no_of_transaction=5;
          apb_mst_virt_seq.start(env.apb_mst_agnt.apb_mst_sqr);
        end
        begin 
        	apb_slv_rnd_dly_seq.start(env.apb_slv_agnt.apb_slv_sqr);
        end
	   join
    end
    begin  
	     #500ns;
       `uvm_fatal(get_type_name(),"Watchdog timer expired");
    end 
  join_any
	phase.drop_objection(this);
   `uvm_info(get_type_name(),"Run Phase Ended",UVM_FULL)
endtask : run_phase
function set_env_config(apb_env_config env_cfg);
  super.set_env_config(env_cfg);
  if(!(uvm_config_db#(virtual apb_mst_driver_bfm)::get(this, "", "apb_mst_drv_bfm",env_cfg.apb_agnt_cfg.apb_mst_drv_bfm ))) 
      `uvm_fatal(get_type_name(), "Unable to find the apb_mst_drv_bfm from config db");
  if(!(uvm_config_db#(virtual apb_slv_driver_bfm)::get(this, "", "apb_slv_drv_bfm",env_cfg.apb_agnt_cfg.apb_slv_drv_bfm )))
      `uvm_fatal(get_type_name(), "Unable to find the apb_slv_drv_bfm from config db");
  env_cfg.apb_agnt_cfg.is_mst_active=1;
  env_cfg.apb_agnt_cfg.is_slv_active=1;
  env_cfg.apb_agnt_cfg.no_of_trans=10;
  uvm_config_db#(apb_env_config)::set(this, "env*","env_cfg",env_cfg );
endfunction : set_env_config
endclass : apb_b2b_test

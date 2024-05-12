////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_test_pkg
// Description    : Base Test  which can be used an example to make a uvc
///////////////////////////////////////////////////////////////////////
class apb_reg_test extends apb_base_test;
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
register_test_vseq       t_seq;
atxmega_spi              regmodel;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_component_utils(apb_reg_test)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_reg_test", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"Build Phase Started",UVM_FULL)
  regmodel      = atxmega_spi::type_id::create("regmodel");
	t_seq         = register_test_vseq::type_id::create("t_seq");
  regmodel.build();
  regmodel.lock_model();
  t_seq.reg_mdl = regmodel;
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
          t_seq.start(env.apb_mst_agnt.apb_mst_sqr);
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
  env_cfg.apb_agnt_cfg.is_mst_active=1;
  env_cfg.apb_agnt_cfg.is_slv_active=0;
  env_cfg.apb_agnt_cfg.no_of_trans=10;
  env_cfg.regmodel=regmodel;
  uvm_config_db#(apb_env_config)::set(this, "env*","env_cfg",env_cfg );
endfunction : set_env_config
endclass : apb_reg_test

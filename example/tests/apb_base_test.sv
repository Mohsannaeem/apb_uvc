////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_test_pkg
// Description    : Base Test  which can be used an example to make a uvc
///////////////////////////////////////////////////////////////////////
class apb_base_test extends uvm_test;
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
apb_env                  env;	
apb_env_config           apb_env_cfg;
/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_component_utils(apb_base_test)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
// Constructor
function new(string name = "apb_base_test", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

virtual function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"Build Phase Started",UVM_FULL)
	env                  = apb_env::type_id::create("env",this);
	apb_env_cfg          = apb_env_config::type_id::create("apb_env_cfg",this);
  `uvm_info(get_type_name(),"Build Phase Ended",UVM_FULL)
endfunction : build_phase

task run_phase(uvm_phase phase);
	super.run_phase(phase);
	`uvm_info(get_type_name(),"Run Phase Started",UVM_FULL)
	phase.raise_objection(this);
	phase.drop_objection(this);
   `uvm_info(get_type_name(),"Run Phase Ended",UVM_FULL)
endtask : run_phase
function set_env_config(apb_env_config env_cfg);
  if(!(uvm_config_db#(virtual apb_mst_monitor_bfm)::get(this, "", "apb_mst_mntr_bfm",env_cfg.apb_agnt_cfg.apb_mst_mntr_bfm ))) 
      `uvm_fatal(get_type_name(), "Unable to find the apb_master_bfm from config db");
  if(!(uvm_config_db#(virtual apb_slv_monitor_bfm)::get(this, "", "apb_slv_mntr_bfm",env_cfg.apb_agnt_cfg.apb_slv_mntr_bfm )))
      `uvm_fatal(get_type_name(), "Unable to find the apb_slv_monitor_bfm from config db");
  env_cfg.apb_agnt_cfg.no_of_trans=10;
  uvm_config_db#(apb_env_config)::set(this, "env*","env_cfg",env_cfg );
endfunction : set_env_config
endclass : apb_base_test

////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_env
// Description    : Dummy Env which can be used to create new env
///////////////////////////////////////////////////////////////////////
class apb_env extends  uvm_component;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
apb_mst_agent apb_mst_agnt;
apb_slv_agent apb_slv_agnt;
apb_env_config env_cfg;
apb_mst_scrb   mst_scrb;
apb_ral_adapter mst_adpt;
uvm_reg_predictor#(apb_mst_seq_item) mst_pridct;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
// Provide implementations of virtual methods such as get_type_name and create
`uvm_component_utils(apb_env)
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
function new(string name = "apb_env", uvm_component parent=null);
	super.new(name, parent);
endfunction : new

function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"Build Phase Started",UVM_FULL)
	apb_mst_agnt= apb_mst_agent::type_id::create("apb_mst_agnt",this);
	apb_slv_agnt= apb_slv_agent::type_id::create("apb_slv_agnt",this);
  mst_scrb    = apb_mst_scrb::type_id::create("mst_scrb",this);
  mst_adpt    = apb_ral_adapter::type_id::create("mst_adpt");
  mst_pridct  = uvm_reg_predictor#(apb_mst_seq_item)::type_id::create("mst_pridct",this);
  
	if(!(uvm_config_db#(apb_env_config)::get(this, "", "env_cfg",env_cfg)))
      `uvm_fatal(get_type_name(),"Unable to get the env config")
  `uvm_info(get_type_name(),"Build Phase Ended",UVM_FULL)
  uvm_config_db#(apb_agent_config)::set(this, "apb_mst_agnt*", "agnt_cfg",env_cfg.apb_agnt_cfg);
  uvm_config_db#(apb_agent_config)::set(this, "apb_slv_agnt*", "agnt_cfg",env_cfg.apb_agnt_cfg);
endfunction : build_phase
function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  if(env_cfg.regmodel !=null) begin
    env_cfg.regmodel.default_map.set_sequencer(apb_mst_agnt.apb_mst_sqr,mst_adpt);
    mst_pridct.map = env_cfg.regmodel.default_map;
    mst_pridct.adapter = mst_adpt;
    env_cfg.regmodel.default_map.set_auto_predict(0);
    apb_mst_agnt.apb_mst_mntr.mst_analysis_port.connect(mst_pridct.bus_in);
  end
  // apb_mst_agnt.apb_mst_mntr.mst_analysis_port.connect(mst_scrb.ap_im);
  
endfunction : connect_phase
task run_phase(uvm_phase phase);
	super.run_phase(phase);
 endtask : run_phase 

endclass : apb_env
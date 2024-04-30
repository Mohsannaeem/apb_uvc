To Reuse the project please follow these steps;
	1. cd example
	2. Export the APB_UVC  and APB_TEST in you environment file
		export APB_UVC="../apb_uvc"
		export APB_TEST="."
	3. Add the following directory in your filelist 
		+incdir+$(APB_UVM)/apb_agent
		+incdir+$(APB_UVM)/apb_config
		+incdir+$(APB_UVM)/apb_env
		+incdir+$(APB_UVM)/apb_interface
		+incdir+$(APB_UVM)/apb_sequence_lib                           
	4. Add the following files in fileist 
		$(APB_UVM)/apb_packages/apb_seq_pkg.sv		
		$(APB_UVM)/apb_packages/apb_env_pkg.sv		
		$(APB_UVM)/apb_packages/apb_test_pkg.sv		
		$(APB_UVM)/apb_interface/apb_intf.sv		
		$(APB_UVM)/apb_interface/apb_master_bfm.sv		
		$(APB_UVM)/apb_interface/apb_slave_bfm.sv
	6. Import the following package in your test package
		 import apb_seq_pkg::*;
    	 import apb_env_pkg::*;
    7. Instansiate the env in your test  and set the environment and agent configurations 
    
Examples 
	Run the VIP B2B
	     make run
	Run the VIP with PeakRDL
	 Generate the RTL 
	 	peakrdl regblock .\dumm_register.rdl -o .\regblock --cpuif apb3-flat
	 	make run_rdl
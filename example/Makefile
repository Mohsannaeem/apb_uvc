## #####################################
## GLOBAL VARIABLES
## #####################################
WHOAMI := $(shell whoami)
PWD := $(shell pwd)
DATE := $(shell date '+%Y_%m%d_%H%M_%S')

ABP_UVC  ?="../../apb_uvc"
TB_TOP 	 ?= "../tb_top"
TEST_DIR ?= "../tests"
COMP_DIR := "./"

SUB_DIRS := $(shell ls $(REG_DIR) )

# SIMULATOR = questa for questa and vcs for vcs
SIMULATOR :=questa
ifeq ($(SIMULATOR), questa)
	BUILD_CMD := vlog
  BUILD_CMD := $(BUILD_CMD) -L /EDA/mentor/questasim/uvm-1.2
endif

ifeq ($(SIMULATOR), questa)
	OPTM_CMD := vopt 
endif
DATABASE := apb_tb_top_db

## ####################################
## TEST VARIABLES
## ####################################
USR_OPT := $(addprefix , $(OPT))
USR_LOG := $(addprefix , $(LOG))
## Get test name from test.sv if not supplied
TEST_NAME ?= apb_b2b_test
# SEED
SEED_NUM := $(shell python3 -c 'from random import randint; print(randint(0, 1000))')
SEED_OPT := $(addprefix , $(SEED))
ifeq "$(SEED_OPT)" ""
else
  SEED_NUM := $(SEED_OPT)
endif

# Wave options
GUI  := 0

ifeq ($(SIMULATOR), questa)
	SIM_CMD   := vsim 
	BUILD_OPT := $(BUILD_OPT) -sv -mfcu
	BUILD_OPT := $(BUILD_OPT) -work $(COMP_DIR)/work
	BUILD_OPT := $(BUILD_OPT) +define+VSIM
	BUILD_OPT := $(BUILD_OPT) -timescale=1ns/100fs
	BUILD_OPT := $(BUILD_OPT) -l $(COMP_DIR)/compile.log
else ifeq ($(SIMULATOR), vcs)
	BUILD_OPT := vcs
	BUILD_OPT := $(BUILD_OPT) +define+VCS
	BUILD_OPT := $(BUILD_OPT) -sverilog
	BUILD_OPT := $(BUILD_OPT) -sv_pragma
	BUILD_OPT := $(BUILD_OPT) -top apb_tb_top
	BUILD_OPT := $(BUILD_OPT) -full64
	BUILD_OPT := $(BUILD_OPT) -LDFLAGS -Wl,--no-as-needed 
	BUILD_OPT := $(BUILD_OPT) -cm line+cond+fsm+tgl+path
	BUILD_OPT := $(BUILD_OPT) -lca
	BUILD_OPT := $(BUILD_OPT) +v2k
	BUILD_OPT := $(BUILD_OPT) -debug_all
	BUILD_OPT := $(BUILD_OPT) -Mdirectory=$(COMP_DIR)/csrc
	BUILD_OPT := $(BUILD_OPT) -Mupdate
	BUILD_OPT := $(BUILD_OPT) +nbaopt
	BUILD_OPT := $(BUILD_OPT) -ntb_opts uvm-1.2+dep_check
	BUILD_OPT := $(BUILD_OPT) -timescale=1ns/100fs
	BUILD_OPT := $(BUILD_OPT) ${VCS_HOME}/etc/uvm-1.2
	BUILD_OPT := $(BUILD_OPT) -o ${COMP_DIR}/simv
	BUILD_OPT := $(BUILD_OPT) -l ./compile.log
else
	XCMD      := xrun
	BUILD_OPT := $(BUILD_OPT) -64bit -elaborate -libverbose -uvm -uvmhome CDNS-1.2 -sv
	BUILD_OPT := $(BUILD_OPT)	-licqueue -nowarn CSINFI -vlog_ext +.h -timescale 1ps/1fs
	BUILD_OPT := $(BUILD_OPT)	-xmlibdirpath ${COMP_DIR} -access +rwc -top apb_tb_top 
endif

# Build defines includes and files
BUILD_OPT := $(BUILD_OPT) +incdir+$(APB_UVC)/apb_agent
BUILD_OPT := $(BUILD_OPT) +incdir+$(APB_UVC)/apb_config
BUILD_OPT := $(BUILD_OPT) +incdir+$(APB_UVC)/apb_env
BUILD_OPT := $(BUILD_OPT) +incdir+$(APB_UVC)/apb_interface
BUILD_OPT := $(BUILD_OPT) +incdir+$(APB_UVC)/apb_sequence_lib                           
BUILD_OPT := $(BUILD_OPT) +incdir+$(APB_UVC)/apb_scoreboard                           
BUILD_OPT := $(BUILD_OPT) +incdir+$(TEST_DIR)/
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_packages/apb_seq_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_packages/apb_env_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_interface/apb_intf.sv
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_interface/apb_mst_driver_bfm.sv
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_interface/apb_mst_monitor_bfm.sv
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_interface/apb_slv_driver_bfm.sv
BUILD_OPT := $(BUILD_OPT) $(APB_UVC)/apb_interface/apb_slv_monitor_bfm.sv
BUILD_OPT := $(BUILD_OPT) $(TB_TOP)/regblock/atxmega_spi_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(TB_TOP)/regblock/atxmega_spi.sv
BUILD_OPT := $(BUILD_OPT) $(TB_TOP)/atxmega_spi_uvm_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(TEST_DIR)/apb_test_pkg.sv
BUILD_OPT := $(BUILD_OPT) $(TB_TOP)/apb_tb_top.sv
# Optimization options 
ifeq ($(SIMULATOR), questa)
  OPTM_OPT := +acc apb_tb_top -o $(DATABASE) -designfile design.bin -work $(COMP_DIR)/work
  SIM_OPT := $(SIM_OPT) -work $(COMP_DIR)/work
endif
ifeq ($(SIMULATOR), vcs)
  VCS_SIM_ARG = +UVM_CONFIG_DB_TRACE
  SIMV_CMD= $(COMP_DIR)/simv
endif

# Simulation options
ifeq ($(GUI), 1)
	ifeq ($(SIMULATOR),xcelium)
	 	SIM_OPT := $(SIM_OPT)
	else
		SIM_OPT := $(DATABASE) $(SIM_OPT)
	endif
else
		ifeq ($(SIMULATOR),xcelium)
	 	SIM_OPT := $(SIM_OPT)
	else
	SIM_OPT := -c $(DATABASE) $(SIM_OPT)
	endif
endif

# ifeq ($(SIMULATOR), 1)
SIM_OPT   := $(SIM_OPT) +UVM_TESTNAME=$(TEST_NAME)
# SIM_OPT   := $(SIM_OPT) +UVM_CONFIG_DB_TRACE +UVM_REPORT
SIM_OPT   := $(SIM_OPT) +UVM_REPORT
SIM_OPT   := $(SIM_OPT) +UVM_VERBOSITY=UVM_FULL
SIM_OPT   := $(SIM_OPT) -l $(TEST_NAME).log
ELAB_OPTS := $(ELAB_OPTS) -classdebug

ifeq ($(SIMULATOR), vcs)
  ifeq ($(GUI), 1)
    SIM_OPT := $(SIM_OPT) -gui
  endif
  SIM_OPT := $(SIM_OPT) -cm line+cond+fsm+tgl+path
  SIM_OPT := $(SIM_OPT) -cm_dir $(COMP_DIR)/simv.vdb
  SIM_OPT := $(SIM_OPT) -cm_name $(TEST_NAME)
  SIM_OPT := $(SIM_OPT) -lca
endif

ifeq ($(SIMULATOR), questa)
	SIM_OPT := $(SIM_OPT) -sv_seed random
	SIM_OPT := $(SIM_OPT) -permit_unmatched_virtual_intf	
  ifeq ($(GUI), 1)
    SIM_OPT := $(SIM_OPT) -do "do wave.do; run -a; q"
  else
    SIM_OPT := $(SIM_OPT) -do "run -a; q"
  endif
endif

ifeq ($(SIMULATOR), xcelium)
	ifeq ($(GUI), 1)
		SIM_OPT := $(SIM_OPT) -gui 
	else
		SIM_OPT := $(SIM_OPT)
	endif
endif
#opening coverage in DVE
cov:
	dve -covdir $(COMP_DIR)/simv.vdb -full64
# Compile

compile:
ifeq ($(SIMULATOR), xcelium) 
	$(XCMD) $(BUILD_OPT) -uvmaccess
else
	$(BUILD_CMD) $(BUILD_OPT) +define+TB_RDL_DISABLE
endif
# BUILD_RDL := $(BUILD_RDL) +define+TB_MASTER_DRIVER_DISABLE
BUILD_RDL := $(BUILD_RDL) +define+TB_SLAVE_DRIVER_DISABLE
compile_rdl:
	$(BUILD_CMD) $(BUILD_OPT) $(BUILD_RDL)
# Optimize
optimize:
	$(OPTM_CMD) $(OPTM_OPT)
# Run without wave
run_sim: 
ifeq ($(SIMULATOR), questa) 
	$(SIM_CMD) $(SIM_OPT) $(USR_OPT) $(ELAB_OPTS)
else ifeq ($(SIMULATOR), vcs) 
	$(SIMV_CMD) $(SIM_OPT) $(USR_OPT) $(ELAB_OPTS)
else
	$(XCMD) -R -xmlibdirpath $(COMP_DIR) $(USR_OPT) $(SIM_OPT) 
endif

# Compile and optimize
build: compile optimize
build_rdl : compile_rdl optimize
run: build run_sim
run_rdl: build_rdl run_sim

# Clean
clean:
	@rm -rf $(APB_UVC)/*/cm.log 
	@rm -rf $(APB_UVC)/*/DVEfiles/ 
	@rm -rf $(APB_UVC)/*/inter.vpd 
	@rm -rf $(APB_UVC)/*/*.log 
	@rm -rf $(APB_UVC)/*/ucli.key
	@rm -rf $(APB_UVC)/*/wlft*
	@rm -rf $(APB_UVC)/*/vsim.wlf
	@rm -rf $(APB_UVC)/*/*.bin
	@rm -rf $(APB_UVC)/*/tr_db.log
	@rm -rf $(COMP_DIR)/compile.log
	@rm -rf $(COMP_DIR)/work
	@rm -rf $(COMP_DIR)/design.bin
	@rm -rf $(COMP_DIR)/csrc  
	@rm -rf $(COMP_DIR)/simv  
	@rm -rf $(COMP_DIR)/simv.cst  
	@rm -rf $(COMP_DIR)/simv.daidir  
	@rm -rf $(COMP_DIR)/simv.vdb  
	@rm -rf $(COMP_DIR)/vc_hdrs.h
	@rm -rf $(COMP_DIR)/xcelium.d 
	@rm -rf $(COMP_DIR)/waves.shm 
	@rm -rf $(COMP_DIR)/.simvision 
	@rm -rf $(COMP_DIR)/*history 
	@rm -rf $(COMP_DIR)/*.d/ 
	@rm -rf $(COMP_DIR)/*.log 
	@rm -rf $(COMP_DIR)/scrbrd_fd 
	@rm -rf $(COMP_DIR)/*.key
	@rm -rf $(COMP_DIR)/*.vstf


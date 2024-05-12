////////////////////////////////////////////////////////////////////////
// Developer Name : Mohsan Naeem 
// Contact info   : mohsannaeem1576@gmail.com
// Module Name    : apb_test_pkg
// Description    : Dummy Test Package which can be used to create new test pkg
///////////////////////////////////////////////////////////////////////
package apb_test_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import apb_seq_pkg::*;
    import atxmega_spi_uvm_pkg::*;
    import apb_env_pkg::*;
    `include "apb_mst_virtual_sequence.sv"
    `include "register_test_vseq.sv"
    `include "apb_base_test.sv"
    `include "apb_reg_test.sv"
    `include "apb_b2b_test.sv"
endpackage
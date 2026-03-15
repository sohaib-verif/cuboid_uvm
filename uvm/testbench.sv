`timescale 1ns/1ns

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

module top;
 
  logic clk;
  logic [1:0] in_start_d;
  
  cuboid_interface intf(.clk(clk));
  
  cuboid_prcr dut(
    .clk(intf.clk),
    .in_data(intf.in_data),
    .in_valid(intf.in_valid),
    .in_start(intf.in_start),
    .out_data(intf.out_data),
    .out_start(intf.out_start),
    .out_valid(intf.out_valid)

  );
  
  initial begin
    uvm_config_db #(virtual cuboid_interface)::set(null, "*", "intf", intf );
  end
  
  initial begin
    run_test("cuboid_test");
  end
  
  initial begin
    clk = 0;
    #2;
    forever begin
      clk = ~clk;
      #2;
    end
  end
  
  initial begin
    #50000;
    $display("Sorry! Ran out of clock cycles!");
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
endmodule: top
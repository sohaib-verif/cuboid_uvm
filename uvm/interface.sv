interface cuboid_interface(input logic clk);

  logic [15:0] in_data;
  logic in_valid;
  logic in_start;

  logic [31:0]  out_data;
  logic  out_start;
  logic out_valid;

endinterface: cuboid_interface

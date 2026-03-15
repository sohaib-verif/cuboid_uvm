//Object class
class cuboid_sequence_item extends uvm_sequence_item;
  `uvm_object_utils(cuboid_sequence_item)

  rand logic [15:0] length;
  rand logic [15:0] width;
  rand logic [15:0] height;

  logic [31:0]  area;
  logic [31:0]  volume;
  logic [31:0]  perimeter;
  
  function new(string name = "cuboid_sequence_item");
    super.new(name);
  endfunction: new

endclass: cuboid_sequence_item
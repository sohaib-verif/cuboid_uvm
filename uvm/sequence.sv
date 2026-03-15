// Object class
class cuboid_test_sequence extends uvm_sequence;
  `uvm_object_utils(cuboid_test_sequence)
  
  cuboid_sequence_item item;
  virtual cuboid_interface intf;
  
  function new(string name= "cuboid_test_sequence");
    super.new(name);
  endfunction
  

  task body();    
    item = cuboid_sequence_item::type_id::create("item");
    start_item(item);
    assert((item.randomize()));
    finish_item(item);
  endtask: body
  
endclass: cuboid_test_sequence
class cuboid_driver extends uvm_driver#(cuboid_sequence_item);
  `uvm_component_utils(cuboid_driver)
  
  virtual cuboid_interface intf;
  cuboid_sequence_item item;
  
  
  function new(string name = "cuboid_driver", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);    
    if(!(uvm_config_db #(virtual cuboid_interface)::get(this, "*", "intf", intf))) begin
      `uvm_error("DRIVER_CLASS", "Failed to get intf from config DB!")
    end
  endfunction: build_phase
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);    
  endfunction: connect_phase
  
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);    
    
    // Reset design control signals to LOW
    reset();
    
    forever begin
      
      item = cuboid_sequence_item::type_id::create("item"); 
      seq_item_port.get_next_item(item);
      `uvm_info(get_type_name(), "Before drive task call", UVM_LOW)
      drive(item);
      `uvm_info(get_type_name(), "After  drive task call", UVM_LOW)
      seq_item_port.item_done();
      #1;
    end
  endtask: run_phase
  
 
  task reset();
    intf.in_start <= 0;
    intf.in_valid <= 0;
  endtask: reset
  
  task drive(cuboid_sequence_item item);
    // Length
    @(posedge intf.clk);
    intf.in_start <= 1;
    intf.in_valid <= 1;
    intf.in_data <= item.length;
  	
    // Width
    @(posedge intf.clk);
    intf.in_start <= 0;
    intf.in_data <= item.width;
    
    // Height
    @(posedge intf.clk);
    intf.in_data <= item.height;
    
    @(posedge intf.clk);
    intf.in_valid <= 0;
    
    //`uvm_info("Check value of in_data", $sformatf("Value of in_data in driver: %d", item.in_data), UVM_LOW)
  endtask: drive
  
endclass: cuboid_driver
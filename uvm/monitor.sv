class cuboid_monitor extends uvm_monitor;
  `uvm_component_utils(cuboid_monitor)
  
  virtual cuboid_interface intf;
  cuboid_sequence_item item;
  
  uvm_analysis_port #(cuboid_sequence_item) input_port;
  uvm_analysis_port #(cuboid_sequence_item) output_port;
  
  
  function new(string name = "cuboid_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);    
    input_port  = new("input_port", this);
    output_port = new("output_port", this);
    
    if(!(uvm_config_db #(virtual cuboid_interface)::get(this, "*", "intf", intf))) begin
      `uvm_error(get_type_name(), "Failed to get intf from config DB!")
    end
  endfunction: build_phase
 

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);    
  endfunction: connect_phase
  
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
    item = cuboid_sequence_item::type_id::create("item");
    
      //`uvm_info(get_type_name(), "Inside forever loop", UVM_LOW)
      fork
        begin
          forever begin
            if(intf.in_start && intf.in_valid) begin
              //Get actual inputs from the design

              @(posedge intf.clk);
              item.length = intf.in_data;

              @(posedge intf.clk);
              item.width = intf.in_data;

              @(posedge intf.clk);
              item.height = intf.in_data;
              //`uvm_info(get_type_name(), $sformatf("Value of out_data(Length) in monitor: %d", intf.out_data), UVM_LOW)

              input_port.write(item);
            end
            #1;
          end
        end

        begin
          forever begin
            if(intf.out_start && intf.out_valid) begin
              //Get actual outputs from the design

              @(posedge intf.clk);
              item.area = intf.out_data;

              @(posedge intf.clk);
              item.volume = intf.out_data;

              @(posedge intf.clk);
              item.perimeter = intf.out_data;

              //`uvm_info(get_type_name(), $sformatf("Value of out_data(Length) in monitor: %d", intf.out_data), UVM_LOW)
              output_port.write(item);
            end
            #1;
          end
        end
      join
    
  endtask: run_phase
  
endclass: cuboid_monitor
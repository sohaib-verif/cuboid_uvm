`uvm_analysis_imp_decl(_i)
`uvm_analysis_imp_decl(_o)

class cuboid_scoreboard extends uvm_test;
  `uvm_component_utils(cuboid_scoreboard)
  
  uvm_analysis_imp_i #(cuboid_sequence_item, cuboid_scoreboard) input_port;
  uvm_analysis_imp_o #(cuboid_sequence_item, cuboid_scoreboard) output_port;
    
  cuboid_sequence_item item_inputs, item_outputs;
  cuboid_sequence_item inputs[$], outputs[$];
  

  function new(string name = "cuboid_scoreboard", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);   
    
    // Analysis Ports
    input_port  = new("input_port",  this);
    output_port = new("output_port", this);
    
    item_inputs = cuboid_sequence_item::type_id::create("item_inputs");
    item_outputs = cuboid_sequence_item::type_id::create("item_outputs");
  endfunction: build_phase
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase
  
  function void write_i(cuboid_sequence_item item);
    `uvm_info(get_type_name(), $sformatf("Value of in_data in write function: %d | %d | %d", item.length, item.width, item.height), UVM_LOW)
    inputs.push_back(item);
  endfunction: write_i
  
  
  function void write_o(cuboid_sequence_item item);
    `uvm_info(get_type_name(), $sformatf("Value of out_data in write function: %d | %d | %d", item.area, item.volume, item.perimeter), UVM_LOW)
    outputs.push_back(item);
  endfunction: write_o
  
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);

    //repeat(3) begin
      /*
      // get the packet
      // generate expected value
      // compare it with actual value
      // score the transactions accordingly
      */
    forever begin
      wait(inputs.size() > 0 && outputs.size() >  0);    
      //`uvm_info("Check value of in_data", $sformatf("Value of transactions[0].in_data in scoreboard: %d", transactions[0].in_data), UVM_LOW)
      //`uvm_info("Check value of in_data", $sformatf("Value of transactions[1].in_data in scoreboard: %d", transactions[1].in_data), UVM_LOW)
      //`uvm_info("Check value of in_data", $sformatf("Value of transactions[2].in_data in scoreboard: %d", transactions[2].in_data), UVM_LOW)

      item_inputs = inputs.pop_front();    
      item_outputs = outputs.pop_front();
      compare(item_inputs, item_outputs);
    end
  endtask: run_phase
  
  
  task compare(cuboid_sequence_item item_inputs, cuboid_sequence_item item_outputs);
    logic [31:0] expected_area, expected_volume, expected_perimeter;
    logic [31:0] actual_area, actual_volume, actual_perimeter;
    
    expected_area = 2 * (item_inputs.length*item_inputs.width + item_inputs.width*item_inputs.height + item_inputs.height*item_inputs.length);
    expected_volume = item_inputs.length * item_inputs.width * item_inputs.height;
    expected_perimeter = 4 * (item_inputs.length + item_inputs.width + item_inputs.height);
    
    actual_area = item_outputs.area;
    actual_volume = item_outputs.volume;
    actual_perimeter = item_outputs.perimeter;
    
    `uvm_info("Check value of in_data", $sformatf("Value of actual_area in scoreboard: %d", actual_area), UVM_LOW)
    
    if (actual_area != expected_area) begin
      `uvm_error("COMPARE", $sformatf("Area failed! ACT=%d, EXP=%d", actual_area, expected_area))
    end
    else begin
      `uvm_info("COMPARE", $sformatf("Area Passed! ACT=%d, EXP=%d", actual_area, expected_area), UVM_LOW)
    end
    
    if (actual_volume != expected_volume) begin
      `uvm_error("COMPARE", $sformatf("Volume failed! ACT=%d, EXP=%d", actual_volume, expected_volume))
    end
    else begin
      `uvm_info("COMPARE", $sformatf("Volume Passed! ACT=%d, EXP=%d", actual_volume, expected_volume), UVM_LOW)
    end
    
    if (actual_perimeter != expected_perimeter) begin
      `uvm_error("COMPARE", $sformatf("Perimeter failed! ACT=%d, EXP=%d", actual_perimeter, expected_perimeter))
    end
    else begin
      `uvm_info("COMPARE", $sformatf("Perimeter Passed! ACT=%d, EXP=%d", actual_perimeter, expected_perimeter), UVM_LOW)
    end
    //`uvm_info("Check value of in_data", $sformatf("Value of length_in_data in scoreboard: %d", length_item.in_data), UVM_LOW)
    //`uvm_info("Check value of in_data", $sformatf("Value of width_in_data in scoreboard: %d", width_item.in_data), UVM_LOW)
    //`uvm_info("Check value of in_data", $sformatf("Value of height_in_data in scoreboard: %d", height_item.in_data), UVM_LOW)
    //`uvm_info("Check value of in_data", $sformatf("Value of transactions[3] in scoreboard: %d", transactions[3].in_data), UVM_LOW)
  endtask: compare
  
endclass: cuboid_scoreboard
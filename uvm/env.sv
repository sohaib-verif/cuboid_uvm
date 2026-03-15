class cuboid_env extends uvm_env;
  `uvm_component_utils(cuboid_env)
  
  cuboid_agent agnt;
  cuboid_scoreboard scb;
  
  
  function new(string name = "cuboid_env", uvm_component parent);
    super.new(name, parent);
    `uvm_info("ENV_CLASS", "Inside Constructor!", UVM_HIGH)
  endfunction: new
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("ENV_CLASS", "Build Phase!", UVM_HIGH)
    
    agnt = cuboid_agent::type_id::create("agnt", this);
    scb = cuboid_scoreboard::type_id::create("scb", this);
  endfunction: build_phase
  

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("ENV_CLASS", "Connect Phase!", UVM_HIGH)
    
    agnt.mon.input_port.connect(scb.input_port);
    agnt.mon.output_port.connect(scb.output_port);
  endfunction: connect_phase
  
  
  task run_phase (uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
  
endclass: cuboid_env
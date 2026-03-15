class cuboid_agent extends uvm_agent;
  `uvm_component_utils(cuboid_agent)
  
  cuboid_driver drv;
  cuboid_monitor mon;
  cuboid_sequencer seqr;
  

  function new(string name = "cuboid_agent", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    drv = cuboid_driver::type_id::create("drv", this);
    mon = cuboid_monitor::type_id::create("mon", this);
    seqr = cuboid_sequencer::type_id::create("seqr", this);
  endfunction: build_phase
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);    
    drv.seq_item_port.connect(seqr.seq_item_export); //Connection Between driver and sequencer
  endfunction: connect_phase
  

  task run_phase (uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
  
endclass: cuboid_agent
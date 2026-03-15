class cuboid_test extends uvm_test;
  `uvm_component_utils(cuboid_test)

  cuboid_env env;
  cuboid_test_sequence test_seq;

  
  function new(string name = "cuboid_test", uvm_component parent);
    super.new(name, parent);
  endfunction: new

  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = cuboid_env::type_id::create("env", this);
  endfunction: build_phase

  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase


  task run_phase (uvm_phase phase);
    super.run_phase(phase);

    phase.raise_objection(this);
    repeat(5) begin
      //test_seq
      test_seq = cuboid_test_sequence::type_id::create("test_seq");
      test_seq.start(env.agnt.seqr);
      #12;
    end
    phase.drop_objection(this);
  endtask: run_phase

endclass: cuboid_test
# cuboid_uvm

Cuboid Processor - UVM Verification Environment
This repository contains a Verilog implementation of a Cuboid Processor and a complete UVM (Universal Verification Methodology) testbench to verify its functionality.
The design takes dimensions (Length, Width, Height) serially and calculates the total Surface Area, Volume, and Perimeter of the cuboid.

Design Specifications
The cuboid_prcr module processes three 16-bit inputs and produces three 32-bit outputs sequentially.

Control Signaling:
Input: in_start marks the arrival of the first dimension (Length). in_valid must be high for each dimension (L, W, H).
Output: out_start pulses for the first result (Area). out_valid stays high for 3 clock cycles as Area, Volume, and Perimeter are driven onto out_data.


Verification Environment (UVM)
The testbench is architected to ensure 100% functional coverage and data integrity.
Key Components:
Sequence: Generates random triplets of (L, W, H).
Driver: Converts sequence items into the custom serial handshake protocol.
Monitor: Samples the interface and broadcasts transactions to the scoreboard.
Scoreboard: Implements a golden reference model to compare calculated vs. expected results.

EDA Playground link:
https://www.edaplayground.com/x/JTqv

// Description: tb for emulation circuit for quadrature square wave
// signals. The input frequency will be twice the frequency of the
// output signals due to the clock dividers
//
// Created: 5/15/2019
// Author: David Pimley

`timescale 1 ns / 1 ns
`include "quadrature_emulator.v"

module quadrature_emulator_tb;

    // Declare the Period for the CLK (ns)
    parameter PERIOD = 10;

    // Declare I/O Signals
    output reg clk; 
    output reg nrst;
    input wire phs_0;
    input wire phs_90;

    initial begin
        clk = 1'b0;
        nrst = 1'b1;
    end

    // Keep the Clock Running
    always begin
        #(PERIOD/2) clk = ~clk;
    end
 
    // Declare the DUT
    quadrature_emulator q_em_dut(clk, nrst, phs_0, phs_90);

    initial begin

        $dumpfile("quadrature_emulator.vcd");
        $dumpvars(0, quadrature_emulator_tb);

        // TEST 1 -> ASYNCHRONOUS RESET
        nrst = 1'b0;
        @(posedge clk);
        nrst = 1'b1;
        @(posedge clk);

        #100 $finish;

    end

endmodule


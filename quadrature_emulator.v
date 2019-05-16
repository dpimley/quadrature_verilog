// Description: emulation circuit for quadrature square wave
// signals. The input frequency will be twice the frequency of the
// output signals due to the clock dividers
//
// Created: 5/15/2019
// Author: David Pimley

module quadrature_emulator
(
    input wire clk, 
    input wire nrst, 
    output wire phs_0, 
    output wire phs_90
);

    // Internal Circuitry

    reg phs_0_reg;                          // register for 0 degree phase
    reg phs_90_reg;                         // register for 90 degree phase

    wire inv_clk;                           // inverted clock for 90 degree phase

    // Register for 0 Degree Phase Signal
    always @ (posedge clk, negedge nrst)
    begin
        if (~nrst)
            phs_0_reg <= 1'b0;
        else
            phs_0_reg <= ~phs_0_reg;
    end

    // Register for 90 Degree Phase Signal
    always @ (posedge inv_clk, negedge nrst)
    begin
        if (~nrst)
            phs_90_reg <= 1'b0;
        else
            phs_90_reg <= ~phs_90_reg;
    end

    // Invert the incoming clock for 90 degree phase shift
    assign inv_clk = ~clk;

    // Assign Outputs
    assign phs_0 = phs_0_reg;
    assign phs_90 = phs_90_reg;

endmodule


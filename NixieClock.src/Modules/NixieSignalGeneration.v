////////////////////////////////////////////////////////////////////////////////
// File: NixieSignalGeneration.v
// Author: BlackIsDevin (https://github.com/BlackIsDevin)
// Creation Date: 3/23/2021‏‎
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module takes in the value of the clock state, and generates
// the appropriate signals to drive the nixie tubes.
////////////////////////////////////////////////////////////////////////////////

module NixieSignalGeneration(
    // 100 MHz onboard clock
    input clk,
    // time values from the ClockStateStorage module
    input [5:0] second, minute, hour,

    // enable and value outputs for the nixie tubes
    output reg [5:0] nixieEnable,
    output reg [7:0] nixieValue
);

endmodule
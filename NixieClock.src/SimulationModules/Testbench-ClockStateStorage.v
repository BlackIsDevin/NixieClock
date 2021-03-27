////////////////////////////////////////////////////////////////////////////////
// File: Testbench-ClockStateStorage.v
// Author: BlackIsDevin (https://github.com/BlackIsDevin)
// Creation Date: 3/27/2021â€?â€Ž
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module is intended to test and verify the functionality of
// the ClockStateStorage module.
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
module TestbenchClockStateStorage();

    // 100 MHz "onboard" clock
    reg clk;
    // first dip switch for selecting 12 or 24 hour clock output
    reg dip;
    // up, down, and reset button pulses for incrementing/decrementing time
    // values and for resetting the clock to 0 hours (12:00)
    reg up, down, reset;
    // cursor for handling inputs
    reg [2:0] cursorPos;
    
    // output of the current time formatted based on dip
    wire [5:0] second, minute, hour;

    // Instantiation of our ClockStateStorage module
    ClockStateStorage css(clk, dip, up, down, reset, cursorPos, second, minute, hour);

    initial begin
        clk = 1;
        dip = 1;
        up = 0;
        down = 0;
        reset = 0;
        cursorPos = 3'b001;
    end

    always begin
        #5;
        clk = ~clk;
    end

endmodule
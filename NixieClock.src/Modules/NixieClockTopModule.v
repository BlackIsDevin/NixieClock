////////////////////////////////////////////////////////////////////////////////
// File: NixieClockTopModule.v
// Author: BlackIsDevin (https://github.com/BlackIsDevin)
// Creation Date: 3/23/2021‏‎
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module links together all the underlying modules for the
// NixieClock project and exposes inputs and outputs for the FPGA and any
// testbench modules.
////////////////////////////////////////////////////////////////////////////////

module NixieClockTopModule(
    // 100 MHz onboard clock
    input clk,
    // first dip switch for selecting 12 or 24 hour clock output
    input dip,
    // buttons!!!
    input upBtn,
    input downBtn,
    input leftBtn,
    input rightBtn,
    input resetBtn,

    // output for our LEDs to indicate cursor position
    output [7:0] leds,
    // enable and value outputs for the nixie tubes
    output [5:0] nixieEnable,
    output [7:0] nixieValue
);

    // button debouncing
    wire upPulse, downPulse, leftPulse, rightPulse, resetPulse;
    ButtonDebouncer upDebouncer(.clk(clk), .buttonState(upBtn), .debouncedPosedgePulse(upPulse));
    ButtonDebouncer dnDebouncer(.clk(clk), .buttonState(downBtn), .debouncedPosedgePulse(downPulse));
    ButtonDebouncer ltDebouncer(.clk(clk), .buttonState(leftBtn), .debouncedPosedgePulse(leftPulse));
    ButtonDebouncer rtDebouncer(.clk(clk), .buttonState(rightBtn), .debouncedPosedgePulse(rightPulse));
    ButtonDebouncer rsDebouncer(.clk(clk), .buttonState(resetBtn), .debouncedNegedgePulse(resetPulse));
    
    // extra wires for hooking stuff together
    wire [5:0] second, minute, hour;
    wire [2:0] cursorPos;

    // main modules
    InputHandler inputHandler(leftPulse, rightPulse, leds, cursorPos);
    ClockStateStorage clockStateStorage(clk, dip, upPulse, downPulse, resetPulse, cursorPos, second, minute, hour);
    NixieSignalGeneration nixieSignalGeneration(clk, second, minute, hour, nixieEnable, nixieValue);

endmodule
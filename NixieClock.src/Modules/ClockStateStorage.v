////////////////////////////////////////////////////////////////////////////////
// File: ClockStateStorage.v
// Author: BlackIsDevin (https://github.com/BlackIsDevin)
// Creation Date: 3/23/2021‏‎
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module holds the current value of the clock as well as
// manages incrementing the clock every second. This module also can accept
// signals from the InputHandler module to increment the three different
// segments of the clock.
////////////////////////////////////////////////////////////////////////////////

module ClockStateStorage(
    // 100 MHz onboard clock
    input clk,
    // first dip switch for selecting 12 or 24 hour clock output
    input dip,
    // up, down, and reset button pulses for incrementing/decrementing time
    // values and for resetting the clock to 0 hours (12:00)
    input up, down, reset,
    // cursor for handling inputs
    input [2:0] cursorPos,
    
    
    output [5:0] second, minute, hour
);

endmodule
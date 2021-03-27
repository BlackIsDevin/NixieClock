////////////////////////////////////////////////////////////////////////////////
// File: InputHandler.v
// Author: BlackIsDevin (https://github.com/BlackIsDevin)
// Creation Date: 3/23/2021‏‎
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module parses the user button input (excluding up and down)
// and generates signals for the ClockStateStorage module to interpret as well
// as signals for the onboard LEDs to indicate cursor position to the user.
////////////////////////////////////////////////////////////////////////////////

module InputHandler(
    // inputs of left and right debounced button pulses
    input left, right,

    // output of our led values for showing cursor position
    output reg [7:0] ledValues,
    // output of cursor position to our ClockStateStorage module
    output reg [2:0] cursorPos
);
    
endmodule
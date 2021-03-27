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
    output [7:0] ledValues,
    // output of cursor position to our ClockStateStorage module
    output reg [2:0] cursorPos
);

    // assign ledValues to represent the current cursor position
    // this statement is lowkey pretty cursed
    assign ledValues = {
        {2{cursorPos[2]}},  // hours indicator
        1'b1,               // spacer, always on
        {2{cursorPos[1]}},  // minutes indicator
        1'b1,               // spacer, always on
        {2{cursorPos[0]}}   // seconds indicator
    };

    // initial state will be cursor on seconds position
    initial begin
        cursorPos = 3'b001;
    end

    // on pulse start, update the cursor values
    // default cases are for if we somehow get into an invalid state
    always @(posedge left, posedge right) begin
        if (left) begin // shift left with overflow by 1 bit
            case (cursorPos)
                3'b001 : cursorPos = 3'b010;
                3'b010 : cursorPos = 3'b100;
                3'b100 : cursorPos = 3'b001;
                default: cursorPos = 3'b001;
            endcase
        end
        if (right) begin // shift right with overflow by 1 bit
            case (cursorPos)
                3'b100 : cursorPos = 3'b010;
                3'b010 : cursorPos = 3'b001;
                3'b001 : cursorPos = 3'b100;
                default: cursorPos = 3'b001;
            endcase
        end
    end
    
endmodule
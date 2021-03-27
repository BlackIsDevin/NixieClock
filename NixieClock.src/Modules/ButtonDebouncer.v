////////////////////////////////////////////////////////////////////////////////
// File: ButtonDebouncer.v
// Author: BlackIsDevin (https://github.com/BlackIsDevin)
// Creation Date: 3/7/2021‏‎
// Target Devices: Mimas A7 Revision V3 Development Board 
//
// Description: This module acts as a button debouncer for the Mimas A7
// buttons. It operates on the negative edge of the 100 MHz clock.
// There's three outputs, the debounced state and two pulses.
// The pulses lasts one clock cycle and happen on the first clock cycle
// of buttonState changing, which edge should be self-explanatory.
////////////////////////////////////////////////////////////////////////////////

module ButtonDebouncer(
    input clk,
    input buttonState,

    output reg debouncedState,
    output reg debouncedPosedgePulse,
    output reg debouncedNegedgePulse
);

    reg [22:0] debouncerReg;
    initial begin
        debouncedState = buttonState;
        debouncedPosedgePulse = 0;
        debouncedNegedgePulse = 0;
    end
    always @(negedge clk) begin

        // increment debouncer Register if it isn't zero
        if (|debouncerReg) 
            debouncerReg <= debouncerReg + 1;

        // check if button state has changed + debounce
        if (buttonState != debouncedState && ~|debouncerReg)
        begin
            debouncerReg <= debouncerReg + 1;
            debouncedState <= buttonState;
            if (debouncedState)
                debouncedPosedgePulse <= 1;
            else
                debouncedNegedgePulse <= 1;
        end else begin // if we aren't changing button states, end pulses
            debouncedPosedgePulse <= 0;
            debouncedNegedgePulse <= 0;
        end

    end

endmodule
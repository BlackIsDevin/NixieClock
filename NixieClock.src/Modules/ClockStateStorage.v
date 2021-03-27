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
    
    // output of the current time formatted based on dip
    output [5:0] second, minute, hour
);

    reg [26:0] secondIncrementCounter;
    
    reg [5:0] trueHour; 
    reg [5:0] trueMinute;
    reg [5:0] trueSecond;

    // assign outputs to registers in proper format
    assign hour = dip ? trueHour : hourAs12Representation(trueHour);
    assign minute = trueMinute;
    assign second = trueSecond;

    always @(posedge clk) begin
        // handle input pulses, these do not overflow into each other
        if (reset) begin
            trueSecond = 0;
            trueMinute = 0;
            trueHour = 0;
        end
        if (up) begin
            case (cursorPos)
                3'b001 : trueSecond = trueSecond < 59 ? trueSecond + 1 : 0;
                3'b010 : trueMinute = trueMinute < 59 ? trueMinute + 1 : 0;
                3'b100 : trueHour = trueHour < 23 ? trueHour + 1 : 0;
            endcase
        end
        if (down) begin
            case (cursorPos)
                3'b001 : trueSecond = trueSecond > 0 ? trueSecond - 1 : 59;
                3'b001 : trueMinute = trueMinute > 0 ? trueMinute - 1 : 59;
                3'b001 : trueHour = trueHour > 0 ? trueHour - 1 : 23;
                
            endcase
        end


        // increment counter, if we reach 100M reset to zero, increment clock
        // TODO: verify this works with testbench
        secondIncrementCounter <= secondIncrementCounter + 1;
        if (secondIncrementCounter == 27'd100000000) begin
            secondIncrementCounter <= 0;
            trueSecond <= trueSecond + 1;
            // if second is 60, "overflow" to minutes
            if (trueSecond == 6'd60) begin
                trueSecond <= 0;
                trueMinute <= trueMinute + 1;
                // if minute is 60, "overflow" to hours
                if (trueMinute == 6'd60) begin
                    trueMinute <= 0;
                    trueHour <= trueHour + 1;
                    // if hour is 24, "overflow" to zero (midnight)
                    if (trueHour == 6'24) begin
                        trueHour <= 0;
                    end
                end
            end
        end
    end

    // turns 24 hour value into 12 hour representation for normal people
    function [5:0] hourAs12Representation;
        input [5:0] inHour;
        if (inHour = 0)
            hour12 = 6'd12;
        else if (inHour > 0 & inHour <= 12)
            hour12 = inHour;
        else // if (inHour > 12)
            hour12 = inHour - 6'd12;
    endfunction

endmodule
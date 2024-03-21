module clk_div
#(
    parameter PERIOD = 6,
    parameter DUTY_TIME = PERIOD/2,
    parameter COUNTER_SIZE = $clog2(PERIOD)
)
(
    input wire clk,
    input wire reset,
    output reg clk_div
);

reg [COUNTER_SIZE -1: 0] counter;



always @(posedge clk) begin
    if (reset)
        counter <= 0;
    else begin
        case (counter)
            PERIOD - 1: 
                counter <= 0;
            default: 
                counter <= counter + 1;
        endcase  
    end
end

always @(posedge clk) begin
    if (reset)
        clk_div <= 0;
    else begin
        case (counter)
            PERIOD - 1: 
                clk_div <= 1; 
            DUTY_TIME - 1:
                clk_div <= 0; 
        endcase
    end
end

endmodule
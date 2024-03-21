module log
(
    input wire  [7:0] in,
    output wire [2:0] out
);

wire [2:0] midle_out [8:0];

assign midle_out [8] = 0;

generate
    genvar i;

    for(i = 0; i < 8; i = i + 1) begin
        assign midle_out[i] = ( ((in & (8'b1 << i)) != 0) & (midle_out[i+1] == 3'b0))? i: midle_out[i+1];
    end

endgenerate

assign out = midle_out[0];

endmodule

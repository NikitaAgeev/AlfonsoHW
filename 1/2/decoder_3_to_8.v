module decoder_3_to_8
(
    input wire  [2:0] in,
    output wire [7:0] out
);



generate
    genvar i;

    for(i = 3'b0; i < 8; i = i + 1) begin
        assign out[i] = (in == i);
    end

endgenerate


endmodule
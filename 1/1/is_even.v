module is_even (
    input wire [31:0] in,
    output wire even 
);
    
assign even = ~in[0];

endmodule
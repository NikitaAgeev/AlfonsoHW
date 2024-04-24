module adder   
(
    input wire but_1,
    input wire clk,
	 input wire reset,
    output wire s_led,

    input wire [7:0] A_wire,
    input wire [7:0] B_wire,

    output wire [6:0] C_1seg7,
    output wire [6:0] C_0seg7,

    output wire [6:0] A_1seg7,
    output wire [6:0] A_0seg7,

    output wire [6:0] B_1seg7,
    output wire [6:0] B_0seg7

);

reg [8:0] C;

wire [8:0] result_wire = A_wire + B_wire;

assign s_led = C[8];

hex_to_7seg(A_wire[3:0], A_0seg7);
hex_to_7seg(A_wire[7:4], A_1seg7);

hex_to_7seg(B_wire[3:0], B_0seg7);
hex_to_7seg(B_wire[7:4], B_1seg7);

hex_to_7seg(C[3:0], C_0seg7);
hex_to_7seg(C[7:4], C_1seg7);


always @(posedge clk) begin
    if(~reset)
		  C <= 0;
	 else if(push == 1)
        C <= result_wire;
end



reg but_r;
reg but_rr;

assign push = but_rr & ~but_r;

always @(posedge clk) begin
	  but_r <= but_1;
	  but_rr <= but_r;
end


endmodule


module hex_to_7seg
(
    input wire [3:0] hex,
    output wire [6:0] seg7
);

assign seg7 = (hex == 4'h0)? ~7'b0_111_111:
              (hex == 4'h1)? ~7'b0_000_110:
              (hex == 4'h2)? ~7'b1_011_011:
              (hex == 4'h3)? ~7'b1_001_111:
              (hex == 4'h4)? ~7'b1_100_110:
              (hex == 4'h5)? ~7'b1_101_101:
              (hex == 4'h6)? ~7'b1_111_101:
              (hex == 4'h7)? ~7'b0_000_111:
              (hex == 4'h8)? ~7'b1_111_111:
              (hex == 4'h9)? ~7'b1_101_111:
              (hex == 4'ha)? ~7'b1_110_111:
              (hex == 4'hb)? ~7'b1_111_100:
              (hex == 4'hc)? ~7'b0_111_001:
              (hex == 4'hd)? ~7'b1_011_110:
              (hex == 4'he)? ~7'b1_111_001:
				  (hex == 4'hf)? ~7'b1_110_001:
				  ~7'b0_000_000;

endmodule
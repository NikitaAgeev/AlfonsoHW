module timer  
(
    input wire but_1,
    input wire clk,
	 input wire reset,
    output wire s_led,

    input wire [13:0] data_wire,

    output wire [6:0] A_3seg7,
    output wire [6:0] A_2seg7,
    output wire [6:0] A_1seg7,
    output wire [6:0] A_0seg7,
	 
	 output wire [6:0] B_1seg7,
    output wire [6:0] B_0seg7
);

reg [13:0] C;
reg [13:0] counter;
reg [16:0] pre_counter;
reg [7:0] blk_counter;

assign s_led = counter < (C >> 1);

hex_to_7seg(C[3:0], A_0seg7);
hex_to_7seg(C[7:4], A_1seg7);
hex_to_7seg(C[11:8], A_2seg7);
hex_to_7seg({2'b0, C[13:12]}, A_3seg7);

hex_to_7seg(blk_counter[3:0], B_0seg7);
hex_to_7seg(blk_counter[7:4], B_1seg7);

always @(posedge clk) begin
    if(~reset)
		C <= 0;
	else if(push == 1)
        C <= data_wire;
end

always @(posedge clk) begin
    if(~reset)
		counter <= 0;
	else if(push == 1)
        counter <= 0;
    else
        if(pre_counter == (5000000 - 1)) 
            counter <= (counter != (C - 1))? counter + 1: 0;        
end

always @(posedge clk) begin
    if(~reset)
		blk_counter <= 0;
	 else if(push == 1)
        blk_counter <= 0;
    else
			if(pre_counter == (5000000 - 1))
            blk_counter <= blk_counter + ((counter == 0)? 1: 0);        
end

always @(posedge clk) begin
    if(~reset)
		pre_counter <= 0;
	 else if(push == 1)
        pre_counter <= 0;
    else
				pre_counter <= (pre_counter != (5000000 - 1))? pre_counter + 1: 0;
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
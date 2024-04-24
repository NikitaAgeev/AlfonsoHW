module counter
(
    input wire but_1,
	input wire but_2,
    input wire clk,
    input wire reset,
    output wire [6:0] seg7
);

reg [3:0] counter;

hex_to_7seg a_7seg(counter, seg7);

reg but_r;
reg but_rr;

reg but_r_2;
reg but_rr_2;

assign push = but_rr & ~but_r;
assign push_2 = but_rr_2 & ~but_r_2;

always @(posedge clk) begin
    if(~reset)
        counter <= 0;
    else begin
        if(push == 1 & push_2 == 0)
            counter <= counter + 1;
		  if(push == 0 & push_2 == 1)
            counter <= counter - 1;
    end
end

always @(posedge clk) begin
    if(~reset) begin
        but_r <= 1;
        but_rr <= 1;
	 end
    else begin
        but_r <= but_1;
        but_rr <= but_r;
    end
end

always @(posedge clk) begin
    if(~reset) begin
        but_r_2 <= 1;
        but_rr_2 <= 1;
	 end
    else begin
        but_r_2 <= but_2;
        but_rr_2 <= but_r_2;
    end
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
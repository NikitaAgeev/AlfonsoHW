module converter
(
    input wire but_1,
    input wire clk,
	input wire reset,
    output wire [7:0]s_led,

    input wire [7:0] data_wire,

    output wire [6:0] A_3seg7,
    output wire [6:0] A_2seg7,
    output wire [6:0] A_1seg7,
    output wire [6:0] A_0seg7,
	 
	output wire [6:0] B_1seg7,
    output wire [6:0] B_0seg7
);


reg [4:0] C_1;
reg [4:0] C_2;

reg [1:0] step;

reg [7:0] num;
reg [7:0] old_num;


assign s_led = data_wire;

hex_to_7seg(num, A_0seg7);
hex_to_7seg(C_1, A_1seg7);
hex_to_7seg(C_2, A_2seg7);
hex_to_7seg(4'b0, A_3seg7);

hex_to_7seg(old_num[3:0], B_0seg7);
hex_to_7seg(old_num[7:4], B_1seg7);

always @(posedge clk) begin
    if(~reset) begin
        C_1 <= 0;
        C_2 <= 0;
        num <= 0;
        step <= 3;
		  old_num <= 0;
	 end
	 else if(push == 1) begin
        num <= data_wire;
		  old_num <= data_wire;
		  step <= 3;
		  C_1 <= 0;
        C_2 <= 0;
    end
    else begin
        if(step == 3) begin
            if(num >= 100)begin
                C_2 <= C_2 + 1;
                num <= num - 100;
            end
            else
                step <= 2;
        end	  
		  else if(step == 2)begin
            if(num >= 10)begin
                C_1 <= C_1 + 1;
                num <= num - 10;
            end
            else
                step <= 1;
        end
     end
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
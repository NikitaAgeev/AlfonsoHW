module shift_reg    
(
    input wire but_1,
	 input wire but_2,
    input wire clk,
    input wire reset,
    output wire [7:0] led7,
	 input wire r_sw,
	 input wire l_sw
);

reg [7:0] counter;
assign led7 = counter;

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
        if(push == 1)
            counter <= (counter >> 1) | {{l_sw}, {7'b0}};
		else if(push_2 == 1)
            counter <= (counter << 1) | r_sw;
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



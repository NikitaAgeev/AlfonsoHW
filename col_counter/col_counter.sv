module col_counter       
(
    input wire but_1,
	 input wire but_2,
    input wire clk,
    input wire reset,
    output wire [6:0] led7
);

reg [2:0] counter;

led_columner ldcol(counter, led7);

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


module led_columner
(
    input wire [2:0] hex,
    output wire [6:0] ld7
);

//assign ld7 = (8'b1 << hex) - 8'b1;

wire m_ld[7:0];
assign m_ld[7] = 0;

genvar i;

generate


	for(i = 0; i < 7; i = i + 1) begin: global
		assign m_ld[i] = (hex == i+1) | m_ld[i+1];
		assign ld7[i] = m_ld[i]; 
	end
	
endgenerate

	
endmodule
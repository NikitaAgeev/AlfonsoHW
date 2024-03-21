`timescale 10ps/1ps
`include "decoder_3_to_8.v"

module testbench ();
    
reg clk;
reg  [2:0] in;
wire [7:0] out;

decoder_3_to_8 dec (.in(in), .out(out));

always #5 clk = ~clk;

wire check;

assign check = (out == 8'b1 << in);

initial begin
    clk = 0;
    
    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, out = %b", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, out = %b", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, out = %b", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, out = %b", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, out = %b", check, in, out);
    $finish;

end

endmodule
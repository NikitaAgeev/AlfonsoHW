`timescale 10ps/1ps
`include "is_even.v"

module testbench ();
    
reg clk;
reg [31:0] in;
wire out;

is_even ev (.in(in), .even(out));

always #5 clk = ~clk;

wire check;

assign check = (out == ((in % 2) == 32'b0));

initial begin
    clk = 0;
    
    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, ev: %d", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, ev: %d", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, ev: %d", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, ev: %d", check, in, out);

    in = $random();
    @(posedge clk);
    $display("%d| n  = %d, ev: %d", check, in, out);

    $finish;

end

endmodule
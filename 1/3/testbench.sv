`timescale 10ps/1ps
//`include "log.v"

module testbench ();
    
reg clk;
reg  [7:0] in;
wire [2:0] out;

log dec (.in(in), .out(out));

always #5 clk = ~clk;

wire check;

assign check = (out == $clog2(in));

initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, testbench);
    
    clk = 0;
    
    in =  8'b1 << 2;
    @(posedge clk);
    $display("%d| n  = %b, out = %d", check, in, out);

    in =  8'b1 << 4;
    @(posedge clk);
    $display("%d| n  = %b, out = %d", check, in, out);

    in =  8'b1 << 6;
    @(posedge clk);
    $display("%d| n  = %b, out = %d", check, in, out);

    in =  8'b1 << 3;
    @(posedge clk);
    $display("%d| n  = %b, out = %d", check, in, out);

    in =  8'b1 << 1;
    @(posedge clk);
    $display("%d| n  = %b, out = %d", check, in, out);
    $finish;

end

endmodule
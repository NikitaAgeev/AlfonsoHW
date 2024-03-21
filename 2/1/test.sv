`timescale 10ps/1ps
//`include "log.v"

module testbench ();
    
reg clk;
reg reset;
wire clk_div2;
wire clk_div4;
wire clk_div8;

clk_div clk_div(clk, reset, clk_div2, clk_div4, clk_div8);

always #5 clk = ~clk;



initial begin
    $dumpfile("out.vcd");
    $dumpvars(0, testbench);
    
    clk = 0;
    reset = 0;
    
    @(posedge clk);
    reset = 1;

    @(posedge clk);
    @(posedge clk);
    @(posedge clk);

    reset = 0;
    
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);


    $finish;

end

endmodule
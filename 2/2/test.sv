`timescale 10ps/1ps
//`include "2.sv"

module testbench ();
    
reg clk;
reg reset;
wire clk_div2;


clk_div #(.PERIOD(5), .DUTY_TIME(1)) clk_div (clk, reset, clk_div2);
//#(.PERIOD(5), .DUTY_TIME(1))

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
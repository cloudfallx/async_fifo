`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 05:07:36 PM
// Design Name: 
// Module Name: tb_dff
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_dff;

    reg w1, clk;
    wire w2;
    
    initial begin
         clk = 0;
    end
    always #5 clk = ~clk;
   
    
    d_flip_flop dff(
        .D(w1),
        .clk(clk),
        .Q(w2)
    );
    initial begin
        w1 = 0;
        #10 w1 = 1;
        #10 w1 = 0;
        #10 w1 = 1;
        #20;
        $finish;
    end
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 05:29:21 PM
// Design Name: 
// Module Name: tb_2fs
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


module tb_2fs;

    reg QA, rst_n, clk;
    wire QB2;
    
    two_flop_synchronizer two_fs(
        .QA(QA),
        .clk(clk),
        .rst_n(rst_n),
        .QB2(QB2)
    );
    
    initial begin
        clk = 0;
    end
    always #5 clk = ~clk;
    
    initial begin
        QA = 0;
        rst_n = 0;
        #50 rst_n = 1;
        #10 QA = 1;
        #20 QA = 0;
        #20
        $finish;
    end
    
endmodule

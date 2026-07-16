`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 05:05:31 PM
// Design Name: 
// Module Name: d_flip_flop
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


module d_flip_flop(
    input D, clk, rst_n,
    output reg Q
    );
    
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            Q <= 0;
        end else begin
            Q <= D;
        end
    end
endmodule

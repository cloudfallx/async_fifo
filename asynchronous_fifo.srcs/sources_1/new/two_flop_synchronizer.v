`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 05:22:01 PM
// Design Name: 
// Module Name: two_flop_synchronizer
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


module two_flop_synchronizer(
    input wire clk, rst_n,
    input wire [4:0] QA,
    output wire [4:0] QB2
    );
    
    wire [4:0] QB1;
    
    genvar i;
    
    generate
        for (i = 4; i >= 0; i = i - 1) begin : ff1
            d_flip_flop dff_inst (
                .D(QA[i]),
                .clk(clk),
                .Q(QB1[i]),
                .rst_n(rst_n)
            );        
        end

        for (i = 4; i >= 0; i = i - 1) begin : ff2
            d_flip_flop dff2 (
                .D(QB1[i]),
                .clk(clk),
                .Q(QB2[i]),
                .rst_n(rst_n)
            );
        end
    endgenerate
    
endmodule

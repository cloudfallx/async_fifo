`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 07:12:51 PM
// Design Name: 
// Module Name: fifo_16
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


module fifo_16(
    input wire [7:0] data_in,
    input wire wen, wclk, full,
    input wire ren, rclk, empty,         
    input wire [4:0] b_wptr, b_rptr,
    output reg [7:0] data_out
    );
    
    reg [7:0] fifo_data[0:15]; 
    
    // Write Logic
    always @(posedge wclk) begin
        if (wen && !full) begin
            fifo_data[b_wptr[3:0]] <= data_in;
        end
    end
    
    // Read Logic
    always @(posedge rclk) begin
        if (ren && !empty) begin
            data_out <= fifo_data[b_rptr[3:0]];
        end
    end
    
endmodule

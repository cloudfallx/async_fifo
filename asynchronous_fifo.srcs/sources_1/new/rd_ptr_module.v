`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 07:08:34 PM
// Design Name: 
// Module Name: rd_ptr_module
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


module rd_ptr_module(
    input ren, rclk, rrst_n, 
    input [4:0] g_wptr_sync, // gray code
    output reg empty,
    output wire [4:0] g_rptr, // gray code
    output wire [4:0] b_rptr // binary
    );
    
    reg [4:0] rptr; // binary
    wire [4:0] wptr_sync; // binary
    wire [4:0] rptr_gray_out; // gray
    wire [4:0] rptr_next; // binary
    
    assign b_rptr = rptr;
    assign rptr_next = rptr + (ren && !empty);
    
    // instantiate binary to gray converter to convert write pointer binary to write pointer gray 
    binary_to_gray b2g(
        .bin(rptr[4:0]),
        .gray(rptr_gray_out[4:0])
    );
    
    genvar i;
    
    // generate flops for g_wptr
    generate
        for (i = 4; i >= 0; i = i - 1) begin : rd_ptr_dff
            d_flip_flop dff_inst (
                .clk(rclk),
                .rst_n(rrst_n),
                .D(rptr_gray_out[i]),
                .Q(g_rptr[i])
            );
        end
    endgenerate
    
    // instantiate gray to binary converter to convert read pointer gray to read pointer binary
    gray_to_binary g2b(
        .gray(g_wptr_sync[4:0]),
        .bin(wptr_sync[4:0])
    );
    
    always @(posedge rclk or negedge rrst_n) begin
        if (~rrst_n) begin
            rptr <= 5'b0;
            empty <= 1'b1;
        end else begin
            rptr <= rptr_next;
            empty <= (rptr_next == wptr_sync);
        end
    end
    
endmodule

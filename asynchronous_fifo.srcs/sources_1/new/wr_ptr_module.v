`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 06:08:05 PM
// Design Name: 
// Module Name: wr_ptr_module
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


module wr_ptr_module(
    input wen, wclk, wrst_n, 
    input wire [4:0] g_rptr_sync, // gray code
    output reg full,
    output wire [4:0] g_wptr, // gray code
    output wire [4:0] b_wptr // binary
    );
    
    reg [4:0] wptr; // binary
    wire [4:0] rptr_sync; // binary
    wire [4:0] wptr_gray_out; // gray
    wire [4:0] wptr_next; // binary
    
    assign b_wptr = wptr;
    assign wptr_next = wptr + (wen && !full);
    
    // instantiate binary to gray converter to convert write pointer binary to write pointer gray 
    binary_to_gray b2g(
        .bin(wptr[4:0]),
        .gray(wptr_gray_out[4:0])
    );
    
    genvar i;
    
    // generate flops for g_wptr
    generate
        for (i = 4; i >= 0; i = i - 1) begin : wr_ptr_dff
            d_flip_flop dff_inst (
                .clk(wclk),
                .rst_n(wrst_n),
                .D(wptr_gray_out[i]),
                .Q(g_wptr[i])
            );
        end
    endgenerate
    
    // instantiate gray to binary converter to convert read pointer gray to read pointer binary
    gray_to_binary g2b(
        .gray(g_rptr_sync[4:0]),
        .bin(rptr_sync[4:0])
    );
    
    always @(posedge wclk or negedge wrst_n) begin
        if (~wrst_n) begin
            wptr <= 5'b0;
            full <= 1'b0;
        end else begin
            wptr <= wptr_next;
            full <= ((wptr_next[3:0] == rptr_sync[3:0]) && (wptr_next[4]^rptr_sync[4])); 
        end
    end
    
endmodule

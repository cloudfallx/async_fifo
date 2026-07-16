`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 07:25:53 PM
// Design Name: 
// Module Name: async_fifo_datapath
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


module async_fifo_datapath(
    input wire [7:0] data_in,
    input wire wen, wclk, ren, rclk, wrst_n, rrst_n,
    output wire [7:0] data_out,
    output wire full, empty
    );
    
    wire [4:0] g_wptr, g_wptr_sync, g_rptr, g_rptr_sync, b_wptr, b_rptr;
    
    
    wr_ptr_module wptr_file(
        .wen(wen),
        .wclk(wclk),
        .wrst_n(wrst_n),
        .g_rptr_sync(g_rptr_sync),
        .full(full),
        .g_wptr(g_wptr),
        .b_wptr(b_wptr)
    );
    
    rd_ptr_module rptr_file(
        .ren(ren),
        .rclk(rclk),
        .rrst_n(rrst_n),
        .g_wptr_sync(g_wptr_sync),
        .empty(empty),
        .g_rptr(g_rptr),
        .b_rptr(b_rptr)
    );
    
    fifo_16 fifo_file(
        .data_in(data_in),
        .wen(wen),
        .wclk(wclk),
        .ren(ren),
        .rclk(rclk),
        .b_wptr(b_wptr),
        .b_rptr(b_rptr),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    two_flop_synchronizer rptr_sync(
        .QA(g_rptr),
        .clk(wclk),
        .rst_n(wrst_n),
        .QB2(g_rptr_sync)
    );  

    two_flop_synchronizer wptr_sync(
        .QA(g_wptr),
        .clk(rclk),
        .rst_n(rrst_n),
        .QB2(g_wptr_sync)
    );     

endmodule

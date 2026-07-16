`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 07:39:03 PM
// Design Name: 
// Module Name: async_fifo_tb
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


module async_fifo_tb();
    
    reg [7:0] data_in;
    reg wclk, rclk, wen, wrst_n, ren, rrst_n;
    wire full, empty;
    wire [7:0] data_out;

    wire [4:0] wptr, rptr;
    wire [7:0] w_val;
    assign wptr = uut.b_wptr;
    assign rptr = uut.b_rptr;
    assign w_val = uut.fifo_file.fifo_data[wptr[3:0]];
    
    async_fifo_datapath uut(
        .data_in(data_in),
        .wen(wen),
        .wclk(wclk),
        .wrst_n(wrst_n),
        .ren(ren),
        .rclk(rclk),
        .rrst_n(rrst_n),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    initial begin
        wclk = 0;
        forever #5 wclk = ~wclk;
    end
    
    initial begin
        rclk = 1;
        #2;
        forever #10 rclk = ~rclk;
    end
    
    initial begin
        wrst_n = 0;
        rrst_n = 0;
        wen = 0;
        ren = 0;
        #10;
        wrst_n = 1;
        rrst_n = 1;
        #10;
        wen = 1;
        
        data_in = 8'h21;
        #10 data_in = 8'h24;
        #10 data_in = 8'hA7;
        #10 data_in = 8'h3B;
        #10 data_in = 8'h6F;
        #10 data_in = 8'h1C;
        #10 data_in = 8'hE2;
        #10 data_in = 8'h5D;
        #10 data_in = 8'h21;
        #10 data_in = 8'h24;
        #10 data_in = 8'hA7;
        #10 data_in = 8'h3B;
        #10 data_in = 8'h6F;
        #10 data_in = 8'h1C;
        #10 data_in = 8'hE2;
        #10 data_in = 8'h5D;
        #10 data_in = 8'hxx;
        wen = 0;
        #10 
        ren = 1;
        #110;
        wen = 1;
        data_in = 8'hE2;
        #10 data_in = 8'h5D;
        #10 data_in = 8'hxx;
        wen = 0;
        #400 $finish;
    end
    
    initial begin
        #572 ren = 0;
    end
    
endmodule

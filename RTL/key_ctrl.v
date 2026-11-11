`timescale 1ns / 1ns

module key_ctrl(
    input wire vga_clk, 
    input wire sys_rst_n,  
    input wire key_in,
    output reg key_press  
);

    parameter CNT_20MS_MAX = 20'd499_999;

    reg [19:0] cnt_20ms;
    reg key_flag;  

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            cnt_20ms <= 20'd0;
        else if (key_in == 1'b0) begin
            if (cnt_20ms != CNT_20MS_MAX)
                cnt_20ms <= cnt_20ms + 1'b1; 
        end
        else
            cnt_20ms <= 20'd0; 
    end

    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            key_flag <= 1'b0;
        else if (cnt_20ms == CNT_20MS_MAX)
            key_flag <= 1'b1; 
        else if (key_in == 1'b1)
            key_flag <= 1'b0;
    end

    reg key_flag_s0, key_flag_s1;
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n) begin
            key_flag_s0 <= 1'b0;
            key_flag_s1 <= 1'b0;
        end
        else begin
            key_flag_s0 <= key_flag;
            key_flag_s1 <= key_flag_s0;
        end
    end
    
    always @(posedge vga_clk or negedge sys_rst_n) begin
        if (!sys_rst_n)
            key_press <= 1'b0;
        else
            key_press <= key_flag_s0 & (~key_flag_s1);
    end

endmodule

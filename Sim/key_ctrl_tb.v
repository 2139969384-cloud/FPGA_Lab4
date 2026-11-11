`timescale 1ns / 1ns

module key_ctrl_tb;
    reg  vga_clk;
    reg  sys_rst_n;
    reg  key_in;
    wire key_press;

    key_ctrl #(
        .CNT_20MS_MAX (20'd10) 
    ) u_key_ctrl (
        .vga_clk   (vga_clk),
        .sys_rst_n (sys_rst_n),
        .key_in    (key_in),
        .key_press (key_press)
    );

    initial begin
        vga_clk = 0;
        forever #5 vga_clk = ~vga_clk;
    end

    initial begin
        $dumpfile("key_ctrl_tb.vcd");
        $dumpvars(0, key_ctrl_tb);
    end

    initial begin
        sys_rst_n = 0;
        key_in = 1;
        #50;
        sys_rst_n = 1;
        #50;
        key_in = 0; 
        #200; 
        key_in = 1;
        #200;
        key_in = 0; #20;
        key_in = 1; #10;
        key_in = 0; #10;
        key_in = 1; #20;
        key_in = 0;
        #200;
        key_in = 1; #20;
        key_in = 0; #20;
        key_in = 1;
        #200;

        key_in = 0;
        #1000;      
        key_in = 1;
        #200;
        $finish;
    end
endmodule
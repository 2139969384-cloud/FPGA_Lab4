`timescale 1ns / 1ns

module Top_tb;
    reg sys_clk;
    reg sys_rst_n;
    reg key_in;
    wire hsync;
    wire vsync;
    wire [15:0] rgb;

    Top u_Top (
        .sys_clk(sys_clk),
        .sys_rst_n(sys_rst_n),
        .key_in(key_in),
        .hsync(hsync),
        .vsync(vsync),
        .rgb(rgb)
    );

    initial begin
        sys_clk = 0;
        forever #10 sys_clk = ~sys_clk;
    end

    initial begin
        $dumpfile("Top_tb.vcd");
        $dumpvars(0, Top_tb);
    end

    initial begin
        sys_rst_n = 0;
        key_in = 1;
        #50;
        sys_rst_n = 1;

        // 6ms + 21ms
        key_in = 0; #1500000; 
        key_in = 1; #1500000; 
        key_in = 0; #1500000; 
        key_in = 1; #1500000; 
        key_in = 0; 

        #21000000; 
        
        key_in = 1;

        #2000000; 
        $finish;
    end

endmodule
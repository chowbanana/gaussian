module NISC4test_test;

logic clk, fastclk, n_reset, poll;
logic [7:0] SW;
logic [7:0] LED;

NISC4test nisc (.fastclk(fastclk), .n_reset(n_reset), .poll(poll), .SW(SW), .LED(LED));

initial
begin
    fastclk = 0;
    forever #5 fastclk = ~fastclk;
end

initial
begin
    poll = 0;
    n_reset = 1;

    #100
    n_reset = 0;

    #400
    n_reset = 1;

    #1000
    poll = 1;
    SW = 8'b01011000;

    #1000
    poll = 0;
    SW = 8'b10000000;

    #1000
    poll = 1;
    // n_reset = 0;
    // #500
    // poll = 0;

    #1000
    poll = 0;
    // poll = 1;
    // n_reset = 1;

    #1000
    poll = 1;
    SW = 8'b00000011;

    #1000 poll =0;

    #1000 poll = 1;
    SW = 8'b01100110; //102

    #1000 poll = 0;
    #1000 $stop;
end

endmodule
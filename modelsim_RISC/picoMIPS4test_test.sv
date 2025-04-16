module picoMIPS4test_test;

logic clk, fastclk, reset, branch_status;
logic [7:0] SW;
logic [7:0] LED;

picoMIPS4test pico (.fastclk(fastclk), .reset(reset), .branch_status(branch_status), .SW(SW), .LED(LED));

initial
begin
    fastclk = 0;
    forever #5 fastclk = ~fastclk;
end

initial
begin
    branch_status = 0;
    reset = 1;

    #100
    reset = 0;
    branch_status = 1;
    SW = 8'b01011000;

    #500
    branch_status = 0;
    SW = 8'b10000000;

    #100
    branch_status = 1;
    // #100 $stop;
end

endmodule
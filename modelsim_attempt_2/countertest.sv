module countertest;

parameter n = 3;

logic fastclk, clk, reset;

counter #(.n(n)) c(
    .reset(reset),
    .fastclk(fastclk),  // Connect fastclk to fastclk input of counter
    .clk(clk)
);

initial
begin
    fastclk = 0;
    #5ns  forever #5ns fastclk = ~fastclk;
end

initial
begin
    reset = 1;
    #1000ns 
    reset = 0;
    #10000000ns;
    $stop;
end

endmodule
module countertest;

parameter n = 3;

logic fastclk, clk, n_reset;

counter #(.n(n)) c(
    .n_reset(n_reset),
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
    n_reset = 0;
    #1000ns 
    n_reset = 1;
    #10000000ns;
    $stop;
end

endmodule
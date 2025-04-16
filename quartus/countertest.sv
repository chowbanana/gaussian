module countertest;

parameter n = 6;

logic fastclk, clk;

counter #(.n(n)) c(
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
    #10000000ns;
    $stop;
end

endmodule
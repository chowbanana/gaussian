// counter for slow clock
module counter #(parameter n = 26) //clock divides by 2^n, adjust n if necessary
  (input logic fastclk, input logic reset, output logic clk);
  
logic [n-1:0] count;

always_ff @(posedge fastclk, posedge reset)
    if (reset)
      count <= 0;
    else
      count <= count + 1;

assign clk = count[n-1]; // slow clock

endmodule
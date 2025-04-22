// counter for slow clock
module counter #(parameter n = 2) //clock divides by 2^n, adjust n if necessary
  (input logic fastclk, input logic n_reset, output logic clk);
  
logic [n-1:0] count;

always_ff @(posedge fastclk, negedge n_reset)
    if (!n_reset)
      count <= 0;
    else
      count <= count + 1;

assign clk = count[n-1]; // slow clock

endmodule
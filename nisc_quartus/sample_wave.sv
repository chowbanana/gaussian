module sample_wave #(parameter i_size = 8, width = 8)(
    input logic [i_size-1:0] i,
    output logic [width-1:0] wave_val
);

logic [width-1:0] wave_mem[(1 << width) - 1 :0];

initial
    $readmemh("wave.hex", wave_mem);

always_comb
    wave_val = wave_mem[i];

endmodule
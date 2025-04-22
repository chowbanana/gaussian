module control_unit(
    //! input signals
    // Branch Condition
    input logic branch_condition,
    // SW[8]
    input logic poll,
    // Instruction
    input logic [6:0] microinstruction,
    //! output signals
    //    PC control
    output logic PCincr,PCabsbranch,
    //    ALU control
    output logic ALUfunc, 
    // imm value
    output logic imm,
    //   register file control
    output logic w_or_LED,
    //   Wdata_select
    output logic Wdata_select
);

always_comb
begin
    PCincr = microinstruction[6];
    imm = microinstruction[4];
    Wdata_select = microinstruction[3];
    w_or_LED = microinstruction[2];
    ALUfunc = microinstruction[1];

    if (microinstruction[0] == 1'b1)
    begin
        if (poll == branch_condition)
            PCabsbranch = 1'b1;

        else
            PCabsbranch = 1'b0;
    end

    else
        PCabsbranch = microinstruction[5];

end
endmodule
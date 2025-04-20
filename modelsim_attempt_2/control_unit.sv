module control_unit(
    //! input signals
    // Branch Condition
    input logic branch_condition,
    // SW[8]
    input logic poll,
    // Instruction
    input logic [8:0] microinstruction,
    //! output signals
    //    PC control
    output logic PCincr,PCabsbranch,
    //    ALU control
    output logic [1:0] ALUfunc, 
    // imm mux control
    output logic imm,
    // retrieve value from switch
    output logic retrieve_switch,
    // retrieve value from wave
    output logic retrieve_wave,
    //   register file control
    output logic w,
    // Branch Status
    output logic LED_status
);

always_comb
begin
    PCincr = microinstruction[8];
    imm = microinstruction[6];
    w = microinstruction[5];
    retrieve_switch = microinstruction[4];
    retrieve_wave = microinstruction[3];
    LED_status = microinstruction[2];
    ALUfunc = microinstruction[1:0];

    if (ALUfunc == 2'b00)
    begin
        if (poll == branch_condition)
        begin
            PCabsbranch = 1'b1;
        end

        else
        begin
            PCabsbranch = 1'b0;
        end
    end

    else
        PCabsbranch = microinstruction[7];

end
endmodule
module branchtest;

logic a, b, is_branch, beq;

branch bra (.*);

initial
begin
    a = 1;
    b = 1;
    is_branch = 0;

    #50
    is_branch = 1;

    #50 a = 0;

    #50 b = 0;

    #50 is_branch = 0;

    #50 $stop;
end

endmodule
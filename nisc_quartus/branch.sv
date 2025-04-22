module branch (
    input logic a, b, is_branch,
    output logic beq
);

assign beq = is_branch && (a ==b);
endmodule
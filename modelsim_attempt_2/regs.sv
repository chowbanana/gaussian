//-----------------------------------------------------
// File Name : regs.sv
// Function : picoMIPS 32 x n registers, %0 == 0
// Version 1 :
// Author: tjk
// Last rev. 27 Oct 2012
//-----------------------------------------------------

module regs #(parameter n = 8) // n - data bus width
(input logic clk, w, Wdata_select,// clk and write control
 input logic [n-1:0] switch_val,
 input logic [n-1:0] Wdata,
 input logic [n-1:0] wave_val,
 input logic [2:0] rs, rd,
 output logic [n-1:0] rs_data, rd_data);

	// Declare 32 n-bit registers 
	logic [n-1:0] gpr [7:0];


	// write process, dest reg is Raddr2
	always_ff @ (posedge clk)
	begin
		// gpr[0] <= 0;
		gpr[6] <= switch_val;
		if (rd != 3'd6 && rd < 8)
		begin
			if (Wdata_select)
				gpr[rd] <= wave_val;
			else if (w)
				gpr[rd] <= Wdata;
		end
	end

	// read process, output 0 if %0 is selected
	always_comb
		begin
			if (rs < 8)
				rs_data = gpr[rs];
			else
				rs_data =  {n{1'b0}};

			if (rd < 8)
				rd_data = gpr[rd];
			else
				rd_data = {n{1'b0}};
		
			// if (rs==5'd0)
	        // 	rs_data =  {n{1'b0}};
        	// else if (rs < 8)
			// 	rs_data = gpr[rs];
	 
			// if (rd==5'd0)
			// 	rd_data =  {n{1'b0}};
			// else if (rd < 8)
			// 	rd_data = gpr[rd];
		end	
	

endmodule // module regs
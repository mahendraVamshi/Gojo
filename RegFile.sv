module RegFile#(
      parameter DATA_WIDTH   = 32  // number of bits in each register
   )
   (
   input  clk,rst,f_en,regWrite,
   input  [4:0] rd,rs1,rs2,
   input  [DATA_WIDTH-1:0] rd_val,
   output logic [DATA_WIDTH-1:0] rs1_val, 
   output logic [DATA_WIDTH-1:0] rs2_val 
   );


integer 	 i;
logic [DATA_WIDTH-1:0] register_file [31:0];

always @(negedge clk) begin
   if(rst && (!regWrite))
      for (i = 0; i < 32; i = i + 1)
          register_file[i] <= 0;
   else
		if((!f_en) && (rd==5'b0))
			register_file[rd]<=32'b0;
		else
			register_file[rd] <=rd_val;
   
end

assign rs1_val= f_en ?  register_file[rs1] : ((rs1==5'b0)?32'b0:register_file[rs1]);
assign rs2_val= f_en ?  register_file[rs2] : ((rs2==5'b0)?32'b0:register_file[rs2]);

endmodule
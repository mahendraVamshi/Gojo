module rv32 (input clk,rst, output logic [31:0]rv);
parameter w=32;
logic [w-1:0]pcnext,pccurrent,bran,reg_vlue;
logic [31:0]inst,imm;
logic [4:0]rs1,rs2,rd;
 //logic [6:0]op;
 logic [2:0]func3;
 logic [6:0]func7;
 logic [31:0]rs1_val,rs2_val,alu_val,alu2;
 logic [3:0]oper,alu_op;
 logic f_en,reg_write_enable,mem_write_enable,mem_read_enable,branch,jump,alu_src,op,mem2reg;

pc a0 (pcnext,clk,rst,pccurrent);
pcadder a1 (pccurrent,pcnext);
branadd b5 (pccurrent,imm,bran);
and b7 (op,branch,zero);
muxx b6 (pcnext,bran,op,pcnext);
Control b1 (inst[6:0],alu_op,reg_write_enable,mem_write_enable,mem_read_enable,mem2reg,branch,jump,alu_src);
instmem a2 (clk,pccurrent,inst);
decod a3 (inst,rs1,rs2,rd,f_en);
RegFile a4 (clk,rst,f_en,reg_write_enable,rd,rs1,rs2,reg_val,rs1_val,rs2_val);
//imm_gen b4 (inst,inst[14:12],inst[5:4],imm);
imm_gen c1 (inst,inst[14:12],inst[5:4],imm);
muxx b2 (rs2_val,imm,alu_src,alu2);
alu a5 (rs1_val,alu2,oper,alu_val,zero);
ALUcontrol a6(func3,func7,oper);
data_memory a7(clk,rst,mem_write,mem_addr,mem_in,mem_out);
muxx b8 (mem_out,alu_val,mem2reg,rv);

endmodule
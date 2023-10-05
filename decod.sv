module decod #(parameter w=32)
(input logic [w-1:0]inst, 
output logic [4:0]rs1,
output logic [4:0]rs2,
output logic [4:0]rd,

//output logic [2:0]func3,
//output logic [6:0]func7,
output logic f_en);

logic [6:0]op;
 
 assign rd = inst[11:7];
 //assign func3 = inst[14:12];
 assign rs1 = inst[19:15];
 assign rs2 = inst[24:20];
 //assign func7 = inst[31:25];
 assign op = inst[6:0];
 assign f_en=inst[28];
 
 endmodule
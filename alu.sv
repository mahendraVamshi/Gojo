module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )(
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult,
		  output logic zero
        );

        //logic [(DATA_WIDTH*2)-1:0] mul;
		  logic [DATA_WIDTH-1:0] fmul;
		  logic [DATA_WIDTH-1:0] fdiv;
		  
		  fpm f0 (SrcA,SrcB,fmul);
		  fpd f1 (SrcA,SrcB,fdiv);
		  
		  assign zero=1'b0;
		  
        always_comb //<< 
        begin
            
            case(Operation)
				4'b0000:
                    ALUResult = SrcA + SrcB;
            4'b0001:        
                    ALUResult = SrcA - SrcB;
				4'b0010:
							begin
							logic [63:0]mul;
							mul=SrcA*SrcB;
							ALUResult = mul[DATA_WIDTH-1:0];//mul
							end
				4'b0011:
							begin
							logic [63:0]mul;
							mul=SrcA*SrcB;
							ALUResult = mul[(DATA_WIDTH*2)-1:DATA_WIDTH];//mulh
							end
				4'b0100:
							ALUResult=SrcA/SrcB;//div
				4'b0101:
							ALUResult=SrcA%SrcB;//rem
				4'b0110:
							ALUResult=fmul;//fmul
				4'b0111:
							ALUResult=fdiv;//fdiv 
				default: 
                    ALUResult = 0;
            endcase
        end
endmodule
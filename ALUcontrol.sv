module ALUcontrol(
  input [6:0] opcode,
  input [2:0] funct,
  output reg [3:0] alu_op
);

// ALU operation codes
localparam ADD = 4'b0000;
localparam SUB = 4'b1000;
localparam AND = 4'b0001;
localparam OR = 4'b0010;
localparam XOR = 4'b0011;
localparam SLL = 4'b0100;
localparam SRL = 4'b0101;
localparam SRA = 4'b1101;
localparam SLT = 4'b0110;
localparam SLTU = 4'b0111;

always_comb begin
  case(opcode)
    7'b0110011: begin // R-type instructions
      case(funct)
        3'b000: alu_op = ADD;
        3'b010: alu_op = SLT;
        3'b011: alu_op = SLTU;
        3'b100: alu_op = XOR;
        3'b110: alu_op = OR;
        3'b111: alu_op = AND;
        3'b001: alu_op = SLL;
        3'b101: begin
          if(opcode[5])
            alu_op = SRA;
          else
            alu_op = SRL;
        end
      endcase
    end
    7'b0010011: begin // I-type instructions
      case(opcode[2:0])
        3'b000: alu_op = ADD;
        3'b010: alu_op = SLT;
        3'b011: alu_op = SLTU;
        3'b100: alu_op = XOR;
        3'b110: alu_op = OR;
        3'b111: alu_op = AND;
        3'b001: alu_op = SLL;
        3'b101: begin
          if(opcode[5])
            alu_op = SRA;
          else
            alu_op = SRL;
        end
      endcase
    end
    default: alu_op = ADD; // Default to ADD for all other instructions
  endcase
end

endmodule
module imm_gen(
  input [31:0] inst,
  
  //input [6:0] opcode,
  input [4:0] funct3,
  input [1:0] imm_sel,
  //input [11:0] instr,
  output signed [31:0] imm
);

//logic [6:0] opcode = inst[6:0];
//logic [4:0] funct3 = inst[14:12];
//logic [1:0] imm_sel= inst[5:4];
//logic [11:0] instr = inst[31:20];

  reg signed [31:0] temp;

  always @(*) begin
    case (imm_sel)
      2'b00: // I-type immediate
        temp = {{20{inst[31]}}, inst[31:20]};
      2'b01: // S-type immediate
        temp = {{20{inst[31]}}, inst[31:25], inst[11:7]};
      2'b10: // B-type immediate
        temp = {{19{inst[31]}}, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
      2'b11: // U-type immediate
        temp = {inst[31], inst[31:12], {12{1'b0}}};
    endcase

    

    // Apply function-specific adjustments
    case (funct3)
      3'b000: // ADDI
        imm = temp;
      3'b001: // SLLI
        imm = {{26{1'b0}}, inst[24:20], inst[11:7]};
      3'b010: // SLTI
        imm = temp;
      3'b011: // SLTIU
        imm = temp;
      3'b100: // XORI
        imm = temp;
      3'b101: // SRLI or SRAI
        if (inst[26:25] == 2'b00) begin // SRLI
          imm = {{27{1'b0}}, inst[24:20], inst[11:7]};
        end else begin // SRAI
          imm = {{27{inst[31]}}, inst[24:20], inst[11:7]};
        end
      3'b110: // ORI
        imm = temp;
      3'b111: // ANDI
        imm = temp;
    endcase
  end
endmodule
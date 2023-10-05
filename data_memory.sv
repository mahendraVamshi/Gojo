module data_memory #(parameter ADDR_WIDTH=32, parameter DATA_WIDTH=32)
  (
   input  logic                   clk,
   input  logic                   reset,
   input  logic                   mem_write,
   input  logic  [ADDR_WIDTH-1:0] mem_addr,
   input  logic  [DATA_WIDTH-1:0] mem_in,
   output logic  [DATA_WIDTH-1:0] mem_out
  );
  
  logic [DATA_WIDTH-1:0] mem [2**ADDR_WIDTH-1:0];
  
  always_ff @(posedge clk) begin
    if (reset) begin
      mem[mem_addr] <= 32'b0;
    end 
	 else if (mem_write) begin
      mem[mem_addr] <= mem_in;
    end
  end
  
  assign mem_out = mem[mem_addr];
  
endmodule
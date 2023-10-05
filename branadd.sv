  module branadd 
      #(parameter WIDTH = 32)
    (input logic [WIDTH-1:0] a,b,
     output logic [WIDTH-1:0] y);


assign y = a + (b<<1);

endmodule
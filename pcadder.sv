module pcadder
    #(parameter WIDTH = 32)
    (input logic [WIDTH-1:0] a,
     output logic [WIDTH-1:0] y);


assign y = a + 9'd4;

endmodule







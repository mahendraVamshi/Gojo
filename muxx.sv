module muxx (a,b,sel,d);
input logic a,b,sel;
output logic d;
assign d=sel?b:a;
endmodule
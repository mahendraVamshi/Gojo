module pc (q,clk,rst,d);
parameter w=32;
input logic [w-1:0]q;
input clk,rst;
output logic [w-1:0]d;
always @(posedge clk)
begin
if (!rst)
d<=q;
else
d<=0;
end
endmodule
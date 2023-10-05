module fpd(a,b,c);
parameter w=32;
parameter m=23;
parameter e=8;

input [w-1:0]a,b;
output [w-1:0]c;


reg a_s,b_s,c_s1;
reg [m:0] a_man,b_man,c_man1;
reg [e-1:0] a_exp,b_exp,c_exp1;

integer i;

always @* begin
a_s=a[w-1];
b_s=b[w-1];
c_s1= a_s^b_s;

a_exp=a[w-2:m];
b_exp=b[w-2:m];
c_exp1= ((a_exp-b_exp)+127);

a_man={1'b1,a[m-1:0]};
b_man={1'b1,b[m-1:0]};

for (i=0;i<24;i=i+1) begin

if(a_man>b_man)
begin
c_man1[m-i]=1'b1;
a_man=a_man-b_man;
a_man=a_man<<1;
end
else begin
if(a_man==b_man)begin
c_man1[m-i]=1'b1;
a_man=0;
end
else begin
c_man1[m-i]=1'b0;
a_man=a_man<<1;
end
end
end
 
if (a[m-1:0]==0)
begin
 c_man1=0;
 
 
end
else if (b[m-1:0]==0)
begin
 c_man1=32'b10000000000000000000000000000000;
 
 c_exp1=255;
 
end

end


assign c={c_s1,c_exp1,c_man1[m-1:0]};
endmodule

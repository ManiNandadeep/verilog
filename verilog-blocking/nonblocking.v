module nBlocking();

reg a,b,c,d;
 


initial begin

$dumpfile ("nonblocking.vcd"); 
$dumpvars(0,nBlocking);

end


initial
begin
a=1'b1;//blocking. sequential at time t=0
b=1'b0;
c=1'b0;
d=1'b0;
  //non-blocking
//Reading the RHS at time t = 0
   a <= #1 b; //Read b at time 0 and assign to a at time=1
//a=0
   c <= #1 a; //Read a at time 0 and assign to c at time=1
//c = 1


end


 
endmodule

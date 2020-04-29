module nBlocking();

reg a,b,c,d;
reg clock;


initial begin
clock=0;
$dumpfile ("nonblocking.vcd"); 
$dumpvars(0,nBlocking);

end

always 
begin
#3 clock=~clock;
end


always @(posedge clock)
begin
//Pick RHS values at time=0,store them in internal variables
// and assign at t=0 to LHS. So, new value of a propagates to c
//after 3 clock cycles.


//non blocking statements
  a <= 1'b1;  
  b <= a;
  c <= b;


end




endmodule

module Blocking();

reg a,b,c,d;
 


initial begin

$dumpfile ("blocking.vcd"); 
$dumpvars(0,Blocking);

end


initial
begin
//time t = 0
a=1'b1; //blocking assignment/statement
b=1'b0;
c=1'b0;
d=1'b0;
    #50 c = a|b; // waits for 50 time units, and execute c = a|b=1

    d = b; // Time continues from last line, d=b at t=50


    c = #50 d&b; // Time continues from last line, d&b = 0 at t = 50, c = d&b at t=100


   #10 d = a; // Time continues from last line, waits for 10 time units. a = 1 at t = 110, d = 0 = a at t = 110

end
 
endmodule

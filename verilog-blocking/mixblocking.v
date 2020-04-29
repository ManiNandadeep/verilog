module mixblocking();

reg a,b,c,d;
 

initial begin

$dumpfile ("blocking.vcd"); 
$dumpvars(0,mixblocking);

end


initial
begin
a=1'b1;
b=1'b0;

      c = a&b; // pick a,b and execute c = a&b = 0
     d <= c; // Time continues from last line, d= 0 = a at t=50
     c = #60 a|b; // non-blocking- starts execution parallely with first line -- grab a|b at at t=0, make c=1 = a|b at t= 0+60
     d <= #80 a|c; //non-blocking again- grab a|c at at t=0 [a = 1 & c = 0], make d=1  at t= 0+80 


end

 
endmodule

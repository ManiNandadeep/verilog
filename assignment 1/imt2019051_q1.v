`timescale 1ns/1ps
module Fsm(inp,clk,reset,out);      // Mealy Fsm module
input inp;
input clk;
input reset;
output reg out;
parameter S0=2'b00,       //S0 is the initial state 
          S2=2'b10,
          S1=2'b01;       //S1 is the state B
                          //S2 is the state C
reg [1:0] cur_state,nxt_state;  //initialising current state and next state
always@(posedge clk,posedge reset,inp)
begin
  if(reset==1)        //if reset is 1 then the current state should be S0
  cur_state<=S0;
  if(reset==0)
  cur_state<=nxt_state; //else current state should be assigned by the next state value
end

always@(cur_state,inp)
begin
  case(cur_state)         //case statements showing the flow of the fsm 
  S0:begin                //if cur_state is S0 and the input is 0 then next state is S1 else S2; and out is 0 in both cases
    if(inp==0) begin
      nxt_state<=S1;
      out<=0;
      end
    else begin
      nxt_state<=S2;
      out<=0;
      end
  end
  S2:begin
    if(inp==0)begin         // if cur_state is S2,the nxt state is S1 if inp 0 else S2;
      nxt_state=S1;
      out<=1;
      end
    else begin
      nxt_state=S2;
      out<=0;
      end
  end
  S1:begin              //if cur_state is S1 the nxt_state is S1 if inp is 0 else S2;
    if(inp==0) begin
      nxt_state=S1;
      out<=0;
      end
    else begin
      nxt_state=S2;
      out<=1;
      end
  end
 
  default:begin
    nxt_state<=S0;
    out<=0;
    end
  endcase
end


endmodule
module tb_fsm;    //test bench for the above fsm module
reg inp;
reg clk;
reg reset;
wire out;
Fsm uut(inp,clk,reset,out);
initial begin
  $dumpfile("fsm_out.vcd");
  $dumpvars(0,tb_fsm);
  clk=0;
  inp=0;
 
  reset=0; #10;
  inp=1; 
  #10; inp=0;
  #10; inp=1;
  #10; inp=0;     //input stream
  #10; inp=1;
  #10; inp=1;
  #10; inp=0;
  #10; inp=0;
  #10; inp=1;
  #10; inp=0;
  #10; inp=1;
  #10; inp=1;
  #10; inp=1;
  #10; inp=1;
  end
  always begin
  clk=~clk; #5;
  end

endmodule

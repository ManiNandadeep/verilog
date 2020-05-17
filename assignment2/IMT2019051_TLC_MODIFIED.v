`timescale 1ns/1ps
module TLC(Ta,Tb,clk,reset,green_a,green_b,yellow_a,yellow_b,red_a,red_b);
input Ta,Tb;        //Ta and Tb are indicates traffic in lanes a and b respectively
input clk;          //clock
input reset;        //reset
parameter S0=3'b000, S1=3'b001, S2=3'b010,
        S3=3'b011, S4=3'b100, S5=3'b101;    //states S0-S5
output reg green_a,green_b,yellow_a,yellow_b,red_a,red_b; //6 outputs ,3 per lane
reg [2:0] cur_state,nxt_state;  //current state,next State
always@(posedge clk,posedge reset,Ta,Tb)
begin
  if(reset==1) begin
  cur_state<=S0;
    green_a<=1;
    yellow_a<=0;    //if reset is one current state is S0 with green_a=1 and red_b=1
    red_a<=0;
    red_b<=1;
    yellow_b<=0;
    green_b<=0;
  end
  if(reset==0)
  cur_state<=nxt_state;
end
always@(cur_state,Ta,Tb)
begin
  case(cur_state)   //case statement based on current state
    S5:begin          
        nxt_state<=S0;        //when the given state is S5
        green_a<=1;
        yellow_a<=0;
        red_a<=0;
        red_b<=1;
        yellow_b<=0;
        green_b<=0;
    end
    S0:begin
        if(Ta==0)begin
        nxt_state<=S1;    //when the given state is S0
        yellow_a<=1;
        green_a<=0;
        red_a<=0;
        red_b<=1;
        green_b<=0;
        yellow_b<=0;
        end
        if(Ta==1) begin
        nxt_state<=S0;
        green_a<=1;
        yellow_a<=0;
        red_a<=0;
        red_b<=1;
        green_b<=0;
        yellow_b<=0;
        end
    end
    S1:begin
        nxt_state<=S2;
        yellow_a<=1;
        red_a<=0;         //when the given state is S1
        green_a<=0;
        red_b<=1;
        yellow_b<=0;
        green_b<=0;
    end
    S4:begin
        nxt_state<=S5;
        red_a<=1;
        green_a<=0;
        yellow_a<=0;
        yellow_b<=1;
        green_b<=0;
        red_b<=0;
    end
    S2:begin
        nxt_state<=S3;
        red_a<=1;
        green_a<=0;
        yellow_a<=0;
        green_b<=1;           //when the given state is S2
        red_b<=0;
        yellow_b<=0;
    end
    S3:begin
        if(Tb==0)begin
        nxt_state<=S4;
        red_a<=1;
        green_a<=0;
        yellow_a<=0;
        yellow_b<=1;
        green_b<=0;         //when the given state is S3
        red_b<=0;
        end      
        if(Tb==1)begin
        nxt_state<=S3;
        red_a<=1;
        green_a<=0;
        yellow_a<=0;
        green_b<=1;
        red_b<=0;
        yellow_b<=0;
        end
    end
    default:begin
        nxt_state<=S0;
        green_a<=1;
        yellow_a<=0;    //default-- S0 state
        red_a<=0;
        red_b<=1;
        yellow_b<=0;
        green_b<=0;
    end
  endcase
end
endmodule
module tb_TLC;
reg Ta;
reg Tb;
reg clk;
reg reset;
wire green_a,green_b,yellow_a,yellow_b,red_a,red_b;
TLC uut(Ta,Tb,clk,reset,green_a,green_b,yellow_a,yellow_b,red_a,red_b);
initial begin
  $dumpfile("TLC_out.vcd");
  $dumpvars(0,tb_TLC);
  clk=0;
  reset=0; 
  Ta<=1;
  Tb<=0;
  #10 Ta<=~Ta;Tb<=~Tb;    //test bench   
end
always begin
clk=~clk; #5;
end
endmodule  
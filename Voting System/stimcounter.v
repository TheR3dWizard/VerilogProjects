
module counter(clk,up,rst,count);
  //define input and output ports
  input clk,up,rst;
  output reg [20:0] count;
  //always block will be executed at each and every positive edge of the clock
  always@(posedge clk) 
  begin
    if(rst)
      count <= 4'd0;
    else if(up)        //count up
      count <= count + 1;
    
  end

endmodule


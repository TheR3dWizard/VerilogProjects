`timescale 1ns/1ps

module main (
    output reg MR,
    output reg MY,
    output reg MG,
    output reg SR,
    output reg SY,
    output reg SG,
    input reset,
    input C,
    input Clk
);

    reg [31:0] value;
    reg [6:0] state;
    reg ST;

    wire TS, TL;

    parameter mainroadgreen = 7'b001100;
    parameter mainroadyellow = 7'b010100;
    parameter sideroadgreen = 7'b100001;
    parameter sideroadyellow = 7'b100010;

    always @(posedge Clk) begin
        if (reset) begin
            state <= mainroadgreen; // Initial state: MG=1, SR=1
            ST <= 1;
        end else begin
            ST <= 0;
            case (state)
                mainroadgreen:
                    if (TL && C) begin
                        state <= mainroadyellow;
                        ST <= 1;
                    end
                mainroadyellow:
                    if (TS) begin
                        state <= sideroadgreen;
                        ST <= 1;
                    end
                sideroadgreen: 
                    if (TL || !C) begin
                        state <= sideroadgreen;
                        ST <= 1;
                    end
                sideroadyellow: 
                     if (TS) 
                    begin 
                        state <= mainroadgreen;
                        ST <= 1;
                    end
                default:
                    state <= mainroadgreen;
            endcase
        end
    end

    always @(posedge Clk) begin
        if (ST == 1'b1)
            value <= 0;
        else
            value <= value + 1;
    end

    assign TS = (value >= 4);
    assign TL = (value >= 14);

    always @* begin
        MR = state[6];
        MY = state[5];
        MG = state[4];
        SR = state[3];
        SY = state[2];
        SG = state[1];
    end

endmodule


module main_tb;
  reg reset;
  reg C;
  reg Clk;
    
  wire MR;
  wire MY;
  wire MG;
  wire SR;
  wire SY;
  wire SG;

  // Instantiate the main module
  main uut (
    .MR(MR),
    .MY(MY),
    .MG(MG),
    .SR(SR),
    .SY(SY),
    .SG(SG),
    .reset(reset),
    .C(C),
    .Clk(Clk)
  );

  // Clock generation
  always #5 Clk = ~Clk;

  // Stimulus
  initial begin
    // Initialize inputs
    reset = 1'b1;
    C = 1'b0;
    Clk = 1'b0;

    // Wait for a few clock cycles
    #10;
    reset = 1'b0;

    // Transition 1: MG=1, SR=1 -> MY=1, SR=1
    #20;
    C = 1'b1;

    // Transition 2: MY=1, SR=1 -> SR=1
    #20;
    C = 1'b0;

    // Transition 3: SR=1 -> SG=1, SR=1
    #20;
    C = 1'b1;

    // Transition 4: SG=1, SR=1 -> MR=1, SR=1
    #20;
    C = 1'b0;

    // Repeat the transitions
    #40;
    repeat (4) begin
      #40;
      C = 1'b1;
      #20;
      C = 1'b0;
    end

    // End simulation
    #10;
    $finish;
  end

  // Display outputs in formatted format
  always @(posedge Clk) begin
    #5;
    $display("Time = %0d, MR = %b, MY = %b, MG = %b, SR = %b, SY = %b, SG = %b", $time, MR, MY, MG, SR, SY, SG);
  end

endmodule

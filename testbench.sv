`timescale 1s/1ms

module tb_traffic_top;
  reg clk;
  reg rst_n;
  reg emergency_sensor;
  wire [2:0] current_state;
  wire ns_red, ns_yellow, ns_green;
  wire ew_red, ew_yellow, ew_green;

  traffic_top uut (
    .clk(clk),
    .rst_n(rst_n),
    .emergency_sensor(emergency_sensor),
    .current_state(current_state),
    .ns_red(ns_red),
    .ns_yellow(ns_yellow),
    .ns_green(ns_green),
    .ew_red(ew_red),
    .ew_yellow(ew_yellow),
    .ew_green(ew_green)
  );
  
  defparam uut.clk_div.freq = 4; 
  
  always begin
    #0.125 clk = ~clk;
  end

  initial begin
    clk = 0;
    rst_n = 0;
    emergency_sensor = 0;

    #1 rst_n = 1;

    #16 emergency_sensor = 1;
    
    #10 emergency_sensor = 0;

    #25 $finish;
  end

  initial begin
    $monitor("Time: %0.0f s | rst_n: %b | State: %b | NS(RYG): %b%b%b | EW(RYG): %b%b%b | Emergency: %b", $realtime, rst_n, current_state, ns_red, ns_yellow, ns_green, ew_red, ew_yellow, ew_green, emergency_sensor);
  end
endmodule

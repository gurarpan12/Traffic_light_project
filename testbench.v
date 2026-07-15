`timescale 1s / 1ms

module tb_traffic_top;
  reg clk;
  reg rst_n;
  reg emergency_sensor;
  
  wire [2:0] current_state;
  wire ns_red, ns_yellow, ns_green;
  wire ew_red, ew_yellow, ew_green;

  traffic_top dut (
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
  
  defparam dut.clk_div.freq = 4; 
  
  always begin
    #0.125 clk = ~clk;
  end

  task reset_system;
  begin
    rst_n = 0;
    emergency_sensor = 0;
    #1;
    rst_n = 1;
  end
  endtask

  task trigger_emergency(input real duration);
  begin
    emergency_sensor = 1;
    #(duration);
    emergency_sensor = 0;
  end
  endtask

  initial begin
    $dumpfile("traffic_top_waves.vcd");
    $dumpvars(0, tb_traffic_top);

    clk = 0;

    reset_system();

    #16;

    trigger_emergency(10.0);

    #25;

    $finish;
  end

  initial begin
    $monitor("Time: %5.2f s | rst_n: %b | State: %b | NS(R-Y-G): %b-%b-%b | EW(R-Y-G): %b-%b-%b | Emerg: %b", 
             $realtime, 
             rst_n, 
             current_state, 
             ns_red, ns_yellow, ns_green, 
             ew_red, ew_yellow, ew_green, 
             emergency_sensor);
  end

endmodule

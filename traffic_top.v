module traffic_top(
  input wire clk,
  input wire rst_n,
  input wire emergency_sensor,
  output wire [2:0] current_state,
  output wire ns_red, ns_yellow, ns_green,
  output wire ew_red, ew_yellow, ew_green
);
  
  wire clk_1hz;
  wire timer_done;
  
  clock_divider #(.freq (30000000)) clk_div(
    .clk (clk),
    .rst_n (rst_n),
    .clk_1hz (clk_1hz)
  );
  
  timer_counter timer(
    .clk (clk),
    .rst_n (rst_n),
    .clk_1hz (clk_1hz),
    .emergency_sensor (emergency_sensor),
    .current_state (current_state),
    .timer_done (timer_done)
  );
  
  traffic_fsm fsm(
    .clk (clk),
    .rst_n (rst_n),
    .emergency_sensor (emergency_sensor),
    .timer_done (timer_done),
    .current_state (current_state),
    .ns_red (ns_red),
    .ns_yellow (ns_yellow),
    .ns_green (ns_green),
    .ew_red (ew_red),
    .ew_yellow (ew_yellow),
    .ew_green (ew_green)
  );
endmodule

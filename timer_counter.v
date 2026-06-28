module timer_counter(
  input wire clk,
  input wire rst_n,
  input wire clk_1hz,
  input wire emergency_sensor,
  input wire [2:0] current_state,
  output wire timer_done
);
  
  reg [3:0] count;
  wire syn_clear;
  wire match_15 = (count == 4'd15);
  wire match_5 = (count == 4'd5);
  wire match_10 = (count == 4'd10);
  
  wire green_or_emergency_target = current_state[2] ? match_10 : match_15;
  assign timer_done = current_state[0] ? match_5 : green_or_emergency_target;
  
  wire is_green = (!current_state[0]) && (!current_state[2]);
  assign syn_clear = timer_done || (emergency_sensor && is_green);
  
  always@(posedge clk or negedge rst_n)
    begin
      if (!rst_n) count <= 4'd0;
      else begin
          if (syn_clear) count <= 4'd0;
          else if (clk_1hz) count <= count + 1'b1;
        end
    end
endmodule

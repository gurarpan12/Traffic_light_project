# Smart Traffic Light Controller

This is a Verilog project that simulates a dual-lane traffic light system with a special emergency override feature. 

## How It Works

The project is split into four simple files to keep things clean and modular:
* traffic_top.v: The main file that wires everything together.
* clock_divider.v: Takes a fast master clock (like 30 MHz) and scales it down to a readable 1 Hz pulse.
* timer_counter.v: Counts the seconds to keep track of how long the lights stay green or yellow.
* traffic_fsm.v: It handles switching the lights between Green (15 seconds) and Yellow (5 seconds).

## Key Features

* Normal Loop: Cycles through the lanes smoothly using a state machine.
* Emergency Sensor: If an emergency vehicle triggers the sensor, the system immediately locks the lights to safe states to let the vehicle pass, then smoothly recovers on its own when the sensor goes back to 0.
* Fast Simulation: Instead of making the testbench wait for 30 million clock cycles just to count 1 second, I used `defparam` in the testbench to scale the clock down to 4 Hz. This lets the simulation run instantly and prints out clean logs in human-readable seconds.

## Files in this Repository
* `traffic_top.v` (Top module)
* `traffic_fsm.v` (FSM logic)
* `clock_divider.v` (Clock divider)
* `timer_counter.v` (Timer)
* `tb_traffic_top.v` (Testbench)

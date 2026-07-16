create_clock -name wclk -period 10 -waveform {0 5} [get_ports wclk]
create_clock -name rclk -period 20 -waveform {0 10} [get_ports rclk]
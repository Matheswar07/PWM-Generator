## Template only: obtain actual package pins from your board's official master XDC.
## Uncomment and replace <...> values for your specific board before implementation.

#set_property PACKAGE_PIN <CLOCK_PIN> [get_ports clk]
#set_property IOSTANDARD LVCMOS33 [get_ports clk]
#create_clock -add -name sys_clk_pin -period 10.000 [get_ports clk]

#set_property PACKAGE_PIN <RESET_BUTTON_PIN> [get_ports reset_n]
#set_property IOSTANDARD LVCMOS33 [get_ports reset_n]

#set_property PACKAGE_PIN <SWITCH0_PIN> [get_ports {duty_sel[0]}]
#set_property PACKAGE_PIN <SWITCH1_PIN> [get_ports {duty_sel[1]}]
#set_property PACKAGE_PIN <SWITCH2_PIN> [get_ports {duty_sel[2]}]
#set_property PACKAGE_PIN <SWITCH3_PIN> [get_ports {duty_sel[3]}]
#set_property IOSTANDARD LVCMOS33 [get_ports {duty_sel[*]}]

#set_property PACKAGE_PIN <PWM_OUTPUT_PIN> [get_ports pwm_out]
#set_property IOSTANDARD LVCMOS33 [get_ports pwm_out]

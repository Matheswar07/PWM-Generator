# Artix-7 PWM Generator (Vivado)

A small, synthesizable PWM generator project for Xilinx Artix-7 devices. The source is plain Verilog and can be added to a Vivado RTL project.

## Contents

- `src/pwm_generator.v` ? parameterized PWM counter and output comparator.
- `src/pwm_top.v` ? example FPGA top module with a 100 MHz clock input, active-low reset button, 4-bit switch duty control, and PWM output.
- `sim/tb_pwm_top.v` ? self-checking simulation testbench using a shortened PWM period.
- `constraints/pwm_top_template.xdc` ? pin assignment template. Fill in the package pins and clock period for your exact board before implementation.

## PWM behavior

The counter runs from 0 through `PERIOD-1`; output is high while `counter < duty`. The default top-level uses `PERIOD=100000`, which gives a 1 kHz PWM frequency for a 100 MHz input clock. The 4-bit `duty_sel` maps 0?15 to 0?100% duty cycle. Use a real clock input and a board-specific pin constraint for `clk`.

## Add sources in Vivado

1. Create a new RTL project and select your exact Artix-7 part or board.
2. Add `src/pwm_generator.v` and `src/pwm_top.v` as design sources. Set `pwm_top` as the top module.
3. Add `constraints/pwm_top_template.xdc` as a constraints file.
4. Copy the correct package pins and clock period from your board's official master XDC, then uncomment and update the relevant `PACKAGE_PIN` and `IOSTANDARD` lines. Do not use pin values from a different board.
5. Run **Run Synthesis**, **Run Implementation**, then **Generate Bitstream**.

The top module expects a 100 MHz clock. If your board clock differs, change `CLK_HZ` in `pwm_top.v` to match the actual clock frequency. For a different PWM frequency, change `PWM_HZ`; `PERIOD` is calculated as `CLK_HZ / PWM_HZ`.

## Simulate

In Vivado, add `sim/tb_pwm_top.v` as a simulation source, choose `tb_pwm_top` as the simulation top, and run behavioral simulation. The testbench uses `PERIOD=16` to keep simulation short and checks duty-cycle extremes and an intermediate setting.

## Before programming

The XDC template intentionally has no active package pin locations. Identify your exact board model and use its official master XDC to assign the clock, reset, switches, and PWM output. An unassigned or incorrectly assigned pin can prevent implementation or drive the wrong board connection.

## License

MIT. See `LICENSE`.

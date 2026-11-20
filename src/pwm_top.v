module pwm_top #(
    parameter integer CLK_HZ = 100000000,
    parameter integer PWM_HZ = 1000,
    parameter integer DUTY_STEPS = 16,
    parameter integer PERIOD = CLK_HZ / PWM_HZ,
    parameter integer COUNTER_WIDTH = $clog2(PERIOD + 1)
) (
    input  wire       clk,
    input  wire       reset_n,
    input  wire [3:0] duty_sel,
    output wire       pwm_out
);

    wire [COUNTER_WIDTH-1:0] duty_count;
    wire reset = ~reset_n;

    // Map switch values 0..15 onto duty counts 0..PERIOD.
    assign duty_count = (duty_sel * PERIOD) / (DUTY_STEPS - 1);

    pwm_generator #(
        .COUNTER_WIDTH(COUNTER_WIDTH),
        .PERIOD(PERIOD)
    ) pwm_inst (
        .clk(clk),
        .reset(reset),
        .duty(duty_count),
        .pwm_out(pwm_out)
    );

endmodule

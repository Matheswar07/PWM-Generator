`timescale 1ns/1ps

module tb_pwm_top;
    localparam integer PERIOD = 16;
    localparam integer WIDTH = $clog2(PERIOD + 1);

    reg clk = 1'b0;
    reg reset_n = 1'b0;
    reg [3:0] duty_sel = 4'd0;
    wire pwm_out;

    integer high_count;
    integer i;

    always #5 clk = ~clk;

    pwm_top #(
        .CLK_HZ(160),
        .PWM_HZ(10),
        .DUTY_STEPS(16),
        .PERIOD(PERIOD),
        .COUNTER_WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .reset_n(reset_n),
        .duty_sel(duty_sel),
        .pwm_out(pwm_out)
    );

    task check_high_count;
        input [3:0] setting;
        input integer expected;
        begin
            duty_sel = setting;
            @(negedge clk);
            // Start measuring at the beginning of the next PWM frame.
            wait (dut.pwm_inst.counter == 0);
            high_count = 0;
            for (i = 0; i < PERIOD; i = i + 1) begin
                @(posedge clk);
                #1;
                if (pwm_out)
                    high_count = high_count + 1;
            end
            if (high_count !== expected) begin
                $display("FAIL: setting=%0d expected=%0d high clocks, got=%0d", setting, expected, high_count);
                $fatal(1);
            end
            $display("PASS: setting=%0d produced %0d high clocks", setting, high_count);
        end
    endtask

    initial begin
        repeat (2) @(posedge clk);
        reset_n = 1'b1;
        check_high_count(4'd0, 0);
        check_high_count(4'd8, 9);
        check_high_count(4'd15, PERIOD);
        $display("All PWM checks passed.");
        $finish;
    end
endmodule

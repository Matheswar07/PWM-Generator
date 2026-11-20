module pwm_generator #(
    parameter integer COUNTER_WIDTH = 32,
    parameter integer PERIOD = 100000
) (
    input  wire                     clk,
    input  wire                     reset,
    input  wire [COUNTER_WIDTH-1:0] duty,
    output wire                     pwm_out
);

    reg [COUNTER_WIDTH-1:0] counter;

    always @(posedge clk) begin
        if (reset) begin
            counter <= {COUNTER_WIDTH{1'b0}};
        end else if (counter >= PERIOD - 1) begin
            counter <= {COUNTER_WIDTH{1'b0}};
        end else begin
            counter <= counter + 1'b1;
        end
    end

    assign pwm_out = (duty >= PERIOD) ? 1'b1 : (counter < duty);

endmodule

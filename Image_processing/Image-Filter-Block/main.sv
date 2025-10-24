`timescale 1ns / 1ps

module main #(
    parameter HoriPixel = 4,
    parameter VertiPixel = 4
)(
    input  logic clk,
    input  logic reset,
    input  logic [1:0] switch_input,
    input  logic [7:0] image [0:2][0:HoriPixel-1][0:VertiPixel-1],
    output logic [7:0] filter_image [0:2][0:HoriPixel-1][0:VertiPixel-1]
);

    logic signed [7:0] kernel_bank [0:3][0:2][0:2];
    logic signed [7:0] selected_kernel [0:2][0:2];

    always_ff @(posedge clk) begin
        if (reset) begin
            // Kernel 0: Identity
            kernel_bank[0][0] <= '{0, 0, 0};
            kernel_bank[0][1] <= '{0, 1, 0};
            kernel_bank[0][2] <= '{0, 0, 0};

            // Kernel 1: Edge detection
            kernel_bank[1][0] <= '{-1, -1, -1};
            kernel_bank[1][1] <= '{-1, 8, -1};
            kernel_bank[1][2] <= '{-1, -1, -1};

            // Kernel 2: Blur
            kernel_bank[2][0] <= '{1, 1, 1};
            kernel_bank[2][1] <= '{1, 1, 1};
            kernel_bank[2][2] <= '{1, 1, 1};

            // Kernel 3: Sharpen
            kernel_bank[3][0] <= '{0, -1, 0};
            kernel_bank[3][1] <= '{-1, 5, -1};
            kernel_bank[3][2] <= '{0, -1, 0};
        end
    end

    always_ff @(posedge clk) begin
        selected_kernel <= kernel_bank[switch_input];
    end

    Convolution #(
        .H(HoriPixel),
        .V(VertiPixel)
    ) conv_inst (
        .image(image),
        .kernel(selected_kernel),
        .result(filter_image)
    );

endmodule

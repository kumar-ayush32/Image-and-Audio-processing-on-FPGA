`timescale 1ns / 1ps

module Convolution #(
    parameter H,
    parameter V
)(
    input  logic [7:0] image [0:2][0:H-1][0:V-1],
    input  logic signed [7:0] kernel [0:2][0:2],
    output logic [7:0] result [0:2][0:H-1][0:V-1]
);

    integer ch, i, j, m, n;
    logic signed [15:0] sum;

    always_comb begin
        for (ch = 0; ch < 3; ch = ch + 1) begin
            for (i = 0; i < H; i = i + 1) begin
                for (j = 0; j < V; j = j + 1) begin
                    sum = 0;

                    for (m = -1; m <= 1; m = m + 1) begin
                        for (n = -1; n <= 1; n = n + 1) begin
                            if ((i + m >= 0) && (i + m < H) &&
                                (j + n >= 0) && (j + n < V)) begin
                                sum += image[ch][i + m][j + n] * kernel[m + 1][n + 1];
                            end
                            else begin
                                sum += 0;
                            end
                        end
                    end

                    if (sum < 0)
                        result[ch][i][j] = 0;
                    else if (sum > 255)
                        result[ch][i][j] = 255;
                    else
                        result[ch][i][j] = sum[7:0];  // lower 8 bits
                end
            end
        end
    end

endmodule
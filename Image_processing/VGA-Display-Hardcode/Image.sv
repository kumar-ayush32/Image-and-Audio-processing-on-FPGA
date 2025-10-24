`timescale 1ns / 1ps

module image(
    input  [9:0] row,
    input  [9:0] col,
    output reg [11:0] pixel
);
    reg [11:0] img1 [0:239][0:319];

initial begin
    img1[0][0] = 12'hFFF;
    img1[0][1] = 12'hFFF;
    img1[0][2] = 12'hFFF;
    img1[0][3] = 12'hFFF;
    img1[0][4] = 12'hFFF;
    img1[0][5] = 12'hFFF;
  // Please define all the pixels value
end

    always @(*) begin
        if (row < 240 && col < 320) begin
            pixel = img1[row][col];
        end
        else if (row >= 240 && col < 320) begin
            pixel = img2[row-240][col]; 
        end
        else if (row < 240 && col >= 320) begin
            pixel = img3[row][col-320]; 
        end
        else if (row >= 240 && col >= 320) begin
            pixel = img4[row-240][col-320]; 
        end
    end

endmodule

`timescale 1ns / 1ps
module vga_out(
	input clk_100MHz,
	input reset,
	output hsync, 
	output vsync,
	output [11:0] rgb
);

	reg [11:0] rgb_reg;
	reg [9:0] column;
	reg [9:0] row;
	wire video_on;
	wire [11:0] pixel;

    // Instantiate VGA Controller
    vga_controller vga_c(.clk_100MHz(clk_100MHz), .reset(reset), .hsync(hsync), .vsync(vsync),
                         .video_on(video_on), .p_tick(), .x(column), .y(row));
    image img_inst(
        .row(row),
        .col(column),
        .pixel(pixel)
    );
    always @(posedge clk_100MHz or posedge reset)
        if (reset) begin
            rgb_reg <= 0;
        end
        else begin
            rgb_reg <= pixel;
        end

    assign rgb = (video_on) ? rgb_reg : 12'b0;
         
endmodule
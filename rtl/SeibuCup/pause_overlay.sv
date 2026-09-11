// SPDX-License-Identifier: GPL-3.0-or-later
/*  This file is part of SeibuCupSoccer_MiSTer.

    SeibuCupSoccer_MiSTer is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SeibuCupSoccer_MiSTer is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with SeibuCupSoccer_MiSTer.  If not, see <http://www.gnu.org/licenses/>.

    Author: Umberto Parisi (rmonic79)
    Version: 1.0
    Date: 2026

*/

// pause_overlay.sv — oscuramento in pausa.
//
// In pausa la luminosita' del video viene dimezzata. L'opzione OSD
// "Clean Pause" lo esclude e lascia l'immagine com'e'.
//
// Le porte sono quelle dell'overlay completo, cosi' il top non cambia:
// vblank e render_x/y qui non servono.

module pause_overlay (
	input  wire        clk,
	input  wire        pause,
	input  wire        clean,    // OSD: 1 = niente oscuramento
	input  wire        vblank,   // non usato

	input  wire [8:0]  render_x, // non usato
	input  wire [8:0]  render_y, // non usato

	input  wire [7:0]  rgb_r_in,
	input  wire [7:0]  rgb_g_in,
	input  wire [7:0]  rgb_b_in,

	output wire [7:0]  rgb_r_out,
	output wire [7:0]  rgb_g_out,
	output wire [7:0]  rgb_b_out
);

wire overlay_on = pause & ~clean;

wire [7:0] dim_r = {1'b0, rgb_r_in[7:1]};
wire [7:0] dim_g = {1'b0, rgb_g_in[7:1]};
wire [7:0] dim_b = {1'b0, rgb_b_in[7:1]};

assign rgb_r_out = overlay_on ? dim_r : rgb_r_in;
assign rgb_g_out = overlay_on ? dim_g : rgb_g_in;
assign rgb_b_out = overlay_on ? dim_b : rgb_b_in;

endmodule

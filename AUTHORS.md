# Authors and Credits

## SeibuCup_MiSTer core

**Author**: Umberto Parisi ([rmonic79](https://github.com/rmonic79))

The original RTL source files for the Seibu Cup Soccer-specific logic
(under `rtl/SeibuCup/` and the project wrapper `SeibuCup.sv`) are
copyright Umberto Parisi and distributed under GNU GPL v3 or later.

The **CRT Adjust** module (`crt_adjust.sv`) was developed together with
Andrea Bogazzi ([@asturur](https://github.com/asturur)).

## Third-party components

This core builds on top of excellent open-source projects. All third-party
sources retain their original copyright and license. The core as a whole
is distributed under **GNU GPL v3 or later** to stay compatible with the
most restrictive upstream (JTFRAME / JTCORES).

| Component | Author | Project | License |
|-----------|--------|---------|---------|
| **FX68K** — cycle-accurate M68000 core | Jorge Cwik ([ijor](https://github.com/ijor)) | [ijor/fx68k](https://github.com/ijor/fx68k) | LGPL-2.1 |
| **T80** — Z80 core | Daniel Wallner, MikeJ | [MiSTer-devel/T80](https://github.com/MiSTer-devel/T80) | BSD / GPL |
| **JTFRAME / JTCORES** — framework, filters, tilemap, etc. | Jose Tejada ([@topapate](https://twitter.com/topapate)) | [jotego/jtcores](https://github.com/jotego/jtcores) | GPL-3 |
| **JTOPL** — YM3812 OPL2 FM synthesizer | Jose Tejada | [jotego/jtopl](https://github.com/jotego/jtopl) | GPL-3 |
| **JT6295** — OKI M6295 ADPCM sample player | Jose Tejada | [jotego/jt6295](https://github.com/jotego/jt6295) | GPL-3 |
| **sdram.sv** — SDRAM controller | Sorgelig ([sorgelig](https://github.com/sorgelig)) | [MiSTer-devel](https://github.com/MiSTer-devel) | GPL-3 |
| **ddram_sprite.sv** — DDR3 reader for sprite ROM, derived from `ddram_4port.sv` | Sorgelig / MiSTer-devel | [MiSTer-devel](https://github.com/MiSTer-devel) | GPL-3 |
| **sys/ framework** — MiSTer HPS/IO, OSD, video scaler, audio | Sorgelig / MiSTer-devel | [MiSTer-devel/Main_MiSTer](https://github.com/MiSTer-devel/Main_MiSTer) | GPL-3 |

## Reference

- **Seibu Cup Soccer arcade hardware** — Seibu Kaihatsu, 1992, running on
  the Seibu legionna.cpp hardware family (Seibu CRTC + SEI252 / RISE
  sprite chip + SEI300 / COP3 coprocessor, COPX-D1 LUT ROM). This FPGA
  core is a reimplementation from hardware documentation, MAME source
  code (`legionna.cpp`, `legionna_v.cpp`, `seibu_crtc.cpp`,
  `seibucop.cpp`), the game's own 68000 program ROM, and observation of
  real hardware behaviour. ROMs are **not** included and must be
  provided by the user.
- **MAME project** — invaluable reference for memory maps, timing and
  driver behaviour. [mamedev/mame](https://github.com/mamedev/mame)

## Status

**0.8 beta — preview.**

The core runs the game on real MiSTer hardware: it boots, plays matches,
keeps score and handles continues. The Seibu SEI300 / COP3 coprocessor is
implemented, including the movement and collision macros, the DMA copy
modes and the depth sorting of the players. Verification is still ongoing.

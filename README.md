# Arcade-SeibuCupSoccer_MiSTer

FPGA core for **Seibu Cup Soccer** (Seibu Kaihatsu, 1992) targeting the
[MiSTer FPGA](https://github.com/MiSTer-devel) platform (Terasic DE10-Nano).

Seibu Cup Soccer is an arcade football game running on the **Seibu
`legionna.cpp` hardware family** — an M68000 board with a Seibu CRTC, the
SEI252 sprite chip and the SEI300 / COP3 coprocessor. It is one of a family
of games that share the same board (Legionnaire, Heated Barrel, Denjin Makai,
Godzilla, SD Gundam Sangokushi Rainbow).

This core reimplements the hardware in SystemVerilog from MAME references
(`legionna.cpp`, `legionna_v.cpp`, `seibu_crtc.cpp`, `seibucop.cpp`), the
Seibu CRTC documentation and observation of real PCB behavior.

> **For now this repository holds only the GPL-covered material — the
> source code.** No bitstream (`.rbf`) is included. This is a preview
> release: a compiled core will be made available to patrons first, and
> released publicly once the author considers it complete. In the
> meantime you can build the core yourself with Quartus (see *Building
> from source*).

## About the game

**Seibu Cup Soccer** (Seibu Kaihatsu, 1992) is an arcade football game with
a top-down angled view and short, fast matches. Up to four players can join
in, and the cabinet keeps the match going as long as credits are added. It
was also released as *Olympic Soccer '92* and in a *Selection* revision.

## Status

**Current version: 0.8 beta** — playable, in preview.

The core reimplements the Seibu `legionna` hardware and runs the game on real
MiSTer hardware. Verification is still ongoing.

**Implemented:**
- M68000 main CPU (FX68K, cycle-accurate) + Z80 sound CPU (T80)
- YM3812 (OPL2) + OKI M6295 ADPCM audio
- Seibu CRTC, real video timing, BG / MG / FG tilemaps + text layer
- SEI252 sprite renderer with 4-level priority
- Seibu **COP3** coprocessor: register file, movement and collision macros,
  DMA copy modes (fill / fade / generic copy) into the real VRAM / sprite
  RAM, and the depth sorting of the players
- Analog video output with CRT adjust (H-sync shift)
- VBlank-synchronized pause, MiSTer OSD with video/DIP options
- Pause overlay with logo + supporters scroll

**Final polishing:**
- Accuracy pass, extended play testing, edge-case cleanup

## Hardware emulated

| Component        | Spec                                                |
|------------------|-----------------------------------------------------|
| Main CPU         | M68000 @ 10 MHz (FX68K)                             |
| Sound CPU        | Zilog Z80 @ 3.579545 MHz (T80)                      |
| Sound chip 1     | Yamaha YM3812 OPL2 (jtopl2)                         |
| Sound chip 2     | OKI M6295 ADPCM (jt6295)                            |
| Video            | Seibu CRTC — BG / MG / FG tilemaps + text layer     |
| Sprites          | Seibu SEI252, 16×16 4bpp, 4-level priority          |
| Coprocessor      | Seibu SEI300 / COP3                                 |
| Palette          | xBGR_555, 2048 entries                              |

## Hardware requirements

- Terasic DE10-Nano
- MiSTer I/O board (recommended)
- SDRAM module
- Works on HDMI displays and on CRTs via the analog video output

## Building from source

Requires Quartus Prime 17.0 (free Lite Edition).

```
Open SeibuCup.qpf in Quartus → Processing → Start Compilation
```

Output bitstream is generated in `output_files/SeibuCup.rbf`.

## Running on MiSTer

This repository ships sources only — there is no prebuilt bitstream.
To run the core you build it yourself and provide the ROMs:

1. Build `SeibuCup.rbf` from source (see *Building from source* above).
2. Copy the `.rbf` to `_Arcade/cores/` on the MiSTer SD card.
3. Copy the `.mra` to `_Arcade/`.
4. Provide your legally-owned ROM files where the MRA expects them
   (usually in `games/mame/`).

**Neither the bitstream nor the ROMs are included in this repository.**
You must build/provide them yourself.

## Repository layout

```
Arcade-SeibuCupSoccer_MiSTer/
├── rtl/
│   ├── SeibuCup/    core RTL (buses, CRTC, tilemaps, sprites, COP3,
│   │                audio glue, CRT adjust)
│   ├── jtframe/     JTFRAME framework modules
│   ├── sound/       jtopl2 (YM3812), jt6295 (OKI M6295), t80 (Z80), mixer
│   └── fx68k/       Motorola 68000 CPU core
├── sys/             MiSTer framework (Sorgelig / MiSTer-devel)
├── logo/            Pause overlay assets (font, logo, supporter list)
├── releases/        MRA file
├── SeibuCup.qpf     Quartus project
├── SeibuCup.qsf     Quartus assignments
├── SeibuCup.sv      Top-level core wrapper
├── Template.sdc     Timing constraints
├── files.qip        HDL file list
└── README.md        This file
```

## Acknowledgements

- **Jorge Cwik** ([ijor](https://github.com/ijor)) for the **FX68K**
  cycle-accurate Motorola 68000 core.
- **Jose Tejada** ([@jotego](https://github.com/jotego)) for JTOPL2
  (YM3812), JT6295 (OKI M6295) and the JTFRAME framework.
- **Daniel Wallner** for the **T80** Z80 CPU core.
- **Andrea Bogazzi** ([@asturur](https://github.com/asturur)) for the work
  on the CRT adjust module.
- The **MAMEDev team** for the invaluable reference on the Seibu
  `legionna` hardware, memory maps, the COP coprocessor and timing.
- **Sorgelig** and the **MiSTer-devel team** for the framework, SDRAM
  controller and Template.

## Support this project

If you enjoy this core and want to support its development:

- [Ko-fi](https://ko-fi.com/ibecerivideoludici) — one-time support
- [Patreon](https://www.patreon.com/IBeceriVideoludici) — monthly support
- [PayPal](https://www.paypal.me/IBeceriVideoludici) — one-time donation

## Follow

- [GitHub](https://github.com/rmonic79)
- [Twitch](https://twitch.tv/ibecerivideoludici) — live streams
- [YouTube](https://www.youtube.com/c/IBeceriVideoludici) — playlists and videos
- [X / Twitter](https://x.com/rmonic79)

## License

The RTL source code in this repository is provided as-is for educational
and preservation purposes under **GNU GPL v3 or later**. Original ROM data
is not included; users must provide their own legally obtained copies.

Original *Seibu Cup Soccer* arcade game © Seibu Kaihatsu, 1992.

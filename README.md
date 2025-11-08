# Freelancer: HD Edition Installer
[![Discord](https://badgen.net/badge/icon/discord?icon=discord&label)](https://discord.gg/ScqgYuFqmU)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/FLHDE/freelancer-hd-edition-installer/graphs/commit-activity)

This is the installer for [Freelancer: HD Edition](https://github.com/FLHDE/freelancer-hd-edition). It was created using Inno Setup with the help of custom Pascal scripting.

## Build instructions
### All-in-one installer (default)
1. Clone the [Freelancer: HD Edition GitHub repository](https://github.com/FLHDE/freelancer-hd-edition).
    1. NOTE: Do not download the mod zip from GitHub's "Download ZIP" feature under the green "Code" button (on the mod's homepage). This may result in an incomplete download. Use the `git clone` command instead.
2. Compress all the mod files (DATA & EXE directories, etc.) using an archiver like [7-Zip](https://www.7-zip.org/). NOTE: The zip must NOT be larger than 2.05 GB!
    1. Compressing the files using LZMA2 is highly recommended.
    2. If it is inevitable that the zip exceeds the 2.05 GB file size limit, you may specify [DiskSpanning=yes under [Setup]](https://jrsoftware.org/is6help/index.php?topic=setup_diskspanning) in `setup.iss` to make the build process succeed regardless.
3. Name the zip `freelancer-hd-edition.7z` and place it in `Assets/Mod`.
4. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

### Online and offline installer (not officially supported)
1. Open `setup.iss` and find the line that says `#define AllInOneInstall true`.
2. Change `true` to `false`.
3. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

Note that the online and offline mode is a legacy feature that is no longer supported. The code for it is present but it has not been maintained after the release of v0.6 so there is no guarantee that it will still work.

## Programs used
### [7-Zip executable](https://www.7-zip.org/download.html)
7-Zip is licensed under the GNU LGPL license. www.7-zip.org.

### [Hex To Binary](https://github.com/FLHDE/HexToBinary)
Hex To Binary is licensed under the MIT license. https://github.com/FLHDE/HexToBinary/blob/main/LICENSE.

### [UTF-8 BOM Remover](https://github.com/FLHDE/utf-8-bom-remover)
UTF-8 BOM Remover is licensed under the MIT license. https://github.com/FLHDE/utf-8-bom-remover.

### [dircpy](https://github.com/FLHDE/dircpy)
dircpy is licensed under the MIT license. https://github.com/FLHDE/dircpy/blob/main/LICENSE.

# Freelancer: HD Edition Inno Installer Script
[![Discord](https://badgen.net/badge/icon/discord?icon=discord&label)](https://discord.gg/ScqgYuFqmU)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/ollieraikkonen/Freelancer-hd-edition-install-script/graphs/commit-activity)

This is a setup script for https://github.com/BC46/freelancer-hd-edition.

This was created using Inno and used custom Pascal scripting.

## Build instructions
### All-in-one installer (default)
1. Download the mod zip from https://github.com/BC46/freelancer-hd-edition/archive/refs/tags/0.6.zip.
2. Recompress the zip's contents using an archiver like [7-Zip](https://www.7-zip.org/). NOTE: The new zip must NOT be larger than 2.05 GB!
    1. Ensure the zip contains a folder named `freelancer-hd-edition-0.6` with all the mod content (DATA & EXE folder, etc.) inside.
    2. Compressing the files using LZMA2 is highly recommended.
3. Name the zip `freelancerhd.7z` and place it in `Assets/Mod`.
4. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

### Online and offline installer
1. Open `setup.iss` and find line 13. It should look like `#define AllInOneInstall true`.
2. Change this line to `#define AllInOneInstall false`.
3. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

## Programs used
### [7-Zip executable](https://www.7-zip.org/download.html)
7-Zip is licensed under the GNU LGPL license. www.7-zip.org.

### [Hex To Binary](https://github.com/BC46/HexToBinary) by [BC46](https://github.com/BC46)
Hex To Binary is licensed under the MIT license. https://github.com/BC46/HexToBinary/blob/main/LICENSE.

### [UTF-8 BOM Remover](https://github.com/BC46/utf-8-bom-remover) by [BC46](https://github.com/BC46)
UTF-8 BOM Remover is licensed under the MIT license. https://github.com/BC46/utf-8-bom-remover/blob/main/LICENSE.

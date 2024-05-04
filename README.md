# Freelancer: HD Edition Inno Installer Script
[![Discord](https://badgen.net/badge/icon/discord?icon=discord&label)](https://discord.gg/ScqgYuFqmU)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/oliverpechey/Freelancer-hd-edition-install-script/graphs/commit-activity)

This is a setup script for [Freelancer: HD Edition](https://github.com/BC46/freelancer-hd-edition). It was created using Inno Setup with the help of custom Pascal scripting.

## Build instructions
### All-in-one installer (default)
1. Clone the [Freelancer: HD Edition GitHub repository](https://github.com/BC46/freelancer-hd-edition).
2. Place all the mod files (DATA & EXE directories, etc.) in a folder named `freelancer-hd-edition-0.7`.
3. Compress the `freelancer-hd-edition-0.7` folder using an archiver like [7-Zip](https://www.7-zip.org/). NOTE: The zip must NOT be larger than 2.05 GB!
    1. Compressing the folder using LZMA2 is highly recommended.
4. Alternatively to step 1, 2, and 3, you may download a pre-packaged zip here: https://archive.org/download/freelancer-hd-edition-0.7/freelancer-hd-edition-0.7.7z.
5. Name the zip `freelancerhd.7z` and place it in `Assets/Mod`.
6. Build `setup.iss` using [Inno Setup's standard IDE](https://jrsoftware.org/isinfo.php), or use the [Command Line Compiler](https://jrsoftware.org/ishelp/index.php?topic=compilercmdline).

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

# PDF Editor Local

A personal desktop fork of [PdfCraft](https://github.com/storytold/pdfcraft). Use it on macOS to open, edit and save PDFs locally.

After building, double-click **PDF Editor Local.command**, or open one local document from Terminal.

```sh
./"PDF Editor Local.command" "/path/to/document.pdf"
```

The launcher applies a macOS policy that denies network sockets to the editor and its child processes. The desktop build disables update checks, external browser links and physical printer output. Print to PDF is available. Document JavaScript starts off each launch. The launcher leaves the automation interface off.

## Build on macOS

Install Rust 1.95 or newer, CMake and the Apple command-line developer tools. Fetching dependencies needs network access. Compile from the locked, local cache afterward.

```sh
export CARGO_HOME="$PWD/target/cargo-home"
cargo fetch --locked
PDFCRAFT_BUILD_LABEL=local cargo build --locked --offline --profile low-disk -p pdfcraft
```

Settings, local logs and recovery files for the launcher are in `target/low-disk/PdfCraftData/`. Save private documents outside cloud-synced folders. System clipboard sharing, backups and sync clients follow your macOS settings.

The [privacy review](docs/local-privacy.md) covers the desktop build, the separate browser and automation targets, and outstanding dependency advisories. The [upstream project description](README.upstream.md), original authorship, licenses and notices are preserved.

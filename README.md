## dithesis
Thesis class for undergraduate theses at the University of Athens

### Dependencies
- You will need the [Computer Modern](https://www.fontsquirrel.com/fonts/computer-modern) fonts.
- You will need XeTeX to compile. For Linux and Windows, [TeXLive](https://www.tug.org/texlive/) is recommended, for MacOS, [MacTeX](https://tug.org/mactex/) is recommended.

On macOS:
```sh
brew tap homebrew/cask-fonts
brew install --cask mactex-no-gui font-computer-modern
```

On Ubuntu/Debian:
```bash
sudo apt install texlive texlive-xetex texlive-lang-greek texlive-bibtex-extra latexmk
```

On Windows, download the [TeXLive](https://tug.org/texlive/acquire-netinstall.html) or the [MiKTeX](https://miktex.org/download) installer.

### Compiling
Once you have [TeXLive](https://www.tug.org/texlive/) (Linux/macOS/Windows) or [MacTeX](http://www.tug.org/mactex/) (macOS) installed, `cd` to the project root directory and run `latexmk`. You will find the output in the `build` directory.

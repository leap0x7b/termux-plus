# Termux Plus
Extra packages for Termux

## Setting up Termux Plus
Run this command:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/leapofazzam123/termux-plus/master/install.sh)"
```

## Pacakges available
* liborc 
* SPICE libs
* QEMU with SPICE
* ALSA Libs
* Geckodriver
* libwayland
* Xwayland
* liblorie
* Termux:X11
* Modded MESA
* Apache ANT
* Ngrok
* GL4ES

## How to contribute
1. Clone [https://github.com/leapofazzam123/termux-plus-debs](https://github.com/leapofazzam123/termux-plus-debs).
2. Put a DEB file in the repo.
3. Install termux-apt-repo and run `termux-apt-repo /path/to/termux-plus-debs /path/to/termux-plus plus apt`
4. Commit the changes and make a pull request in both termux-plus-debs and termux-plus.

## Packages sources
* [tewmux-disabled](https://github.com/suhan-paradkar/tewmux-disabled)
* ~~[mjuned47's modded QEMU](https://github.com/mjuned47/qemu-termux)~~ Replaced with [suhan-paradkar](https://github.com/suhan-paradkar)'s and mine compiled SPICE and QEMU

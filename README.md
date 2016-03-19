# ffmpeg-mingw

A build system for cross-compiling FFmpeg with Mingw-w64.

## Usage

    $ cd build-win32
    $ make
    $ ls ../i686-w64-mingw32/bin/ffmpeg.exe
    ffmpeg.exe

Run `make list` for a list of available packages. Edit `config.mak` to change the list of packages
to build, and to change package options.

## Credits

ffmpeg-mingw is adapted from, and contains patches from, the VLC contrib build system. 

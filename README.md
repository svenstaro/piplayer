# piplayer ![GitHub Actions Workflow](https://github.com/svenstaro/piplayer/workflows/Build/badge.svg)
Receive a command, play a song

## How to use

`PUT` to `/play` to play a random song.
`PUT` to `/stop` to stop the current playback.
`GET` to `/` to receive the current playback status.

## How to build

Since music is baked into the binary at build time, you have to put it into a dir `music/` in the root of this repo.

### On host

- Install `x-tools-armv7-bin`
- Add to `~/.cargo/config`:

      [target.armv7-unknown-linux-gnueabihf]
      linker = "/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc"

- `cargo watch -s './crosscompile.sh'`

### On device

- `watchexec ./piplayer`

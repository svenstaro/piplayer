# piplayer
Receive a command, play a song

## How to use

`PUT` to `/play_random_song` to play a random song.
`PUT` to `/stop_playback` to stop the current playback.

## How to build

Since music is baked into the binary at build time, you have to put it into a dir `music/` in the root of this repo.

### On host

- Install `x-tools-armv7-bin`
- Add to `~/.cargo/config`:

      [target.armv7-unknown-linux-gnueabihf]
      linker = "/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc"

- `cargo watch -s './crosscompile.sh'`

### On Raspberry Pi 3

- `mkdir /tmp/piplayer`
- `cd /tmp/piplayer`
- `watchexec ./piplayer`

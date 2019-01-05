# piplayer
Receive a command, play a song

## How to

### On host

- Install `x-tools-armv7-bin`
- Add to `~/.cargo/config`:

    [target.armv7-unknown-linux-gnueabihf]
    linker = "/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc"

- cargo watch -s './crosscompile.sh'

### On Raspberry Pi 3

- cd /tmp/piplayer
- watchexec ./piplayer

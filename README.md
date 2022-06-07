# piplayer [![GitHub Actions Workflow](https://github.com/svenstaro/piplayer/workflows/Build/badge.svg)](https://github.com/svenstaro/piplayer/actions)
Receive a command, play a song

## How to use

- `PUT` to `/play` to play a random song.
- `PUT` to `/stop` to stop the current playback.
- `GET` to `/` to receive the current playback status.
- `GET` to `/list` to receive a list of all songs.

## How to build

Since music is baked into the binary at build time, you have to put it into a dir `music/` in the root of this repo.

Run `just build-native` or `just build-cross`.

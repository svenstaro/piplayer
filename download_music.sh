#!/bin/bash

mkdir -p input_music
cd input_music
tracks=(
  # Zelda Majoras Mask Clown Town Day 1
  #JaflMqvxIqA

  # Super Mario Sunshine Delfino Plaza
  #dcSPK5yn9K8

  # Zelda Wind Waker Dragon Roost Island
  #wRWq53IFXVQ

  # Star Wars Duel of the Fates
  #ZTg6hg1miFg

  # Zelda Ocarina of Time Fairy Fountain
  #IljKQ1BdHKI

  # Zelda Ocarina of Time Hyrule Castle Courtyard
  #mt9qJqj3wQw

  # Zelda Ocarina of Time House
  #RaK9OSSOqQM

  # Super Mario 64 Inside the Castle Walls
  #BnZu9uOH-nY

  # Zelda Ocarina of Time Kokiri Village
  #Q3I1fx1GOuc

  # Zelda Ocarina of Time Lost Woods
  #-uInmFU6JkU

  # Zelda Majoras Astral Observatory
  #s0krxH0dWhU

  # mii channel but all the pauses are uncomfortably long
  3q7oJuyy5Ac

  # Mii Channel Music
  E9s1ltPGQOo

  # Zelda Ocarina of Time Gerudo Valley
  Hy0aEj85ifY

  # Zelda Wind Waker Outset Island
  #hUiAmrtxits

  # Overworld (Super Mario Bros. 3) [New Remix] - Super Smash Bros. Ultimate Soundtrack
  le4N3TI1Uz0

  # Zelda Ocarina of Time Shop
  #kx8af6vE3Rc

  # Zelda Ocarina of Time Song of Storms
  43IPAGw01IY

  # Super Mario 64 Staff Roll
  #4Ruqn1Lnexs

  # Super Mario 64 Jolly Roger Bay
  Bx6nOkdeNKs

  # Zelda Wind Waker Title
  #o78T9-I4OGA

  # Wii Shop Channel Music
  8avMLHvLwRQ

  # Zelda Wind Windfall Island
  #go_XgaJNVgg

  # Zelda Ocarina of Time Zora's Domain
  # AUyqvUG0ypA

  # Faster Than Light - Space Cruiser
  nbuXDKbWF9w

  # Faster Than Light - Milky Way Explore
  3BWs9rV4T2I

  # Faster Than Light - Mantis Battle
  RdiqG3RGBec

  # Faster Than Light - Colonial Explore
  0SxvfNRz_5U

  # Faster Than Light - Rockmen Battle
  bb0NESRNY-w

  # Faster Than Light - Rockmen Explore
  yiqVjYqXlZY

  # FTL Advanced Edition Soundtrack： Lanius (Explore)
  JjYKhD-yIuk

  # Faster Than Light soundtrack - Zoltan (Explore)
  zTC_naAs3gE

  # FTL soundtrack-Zoltan Battle
  cb0yQ1buLbU

  # FTL Advanced Edition Soundtrack： Lost Ship (Explore)
  O9qVgUFtjGw

  # FTL Advanced Edition Soundtrack： Lost Ship (Battle)
  gCDgagrMoiE

  # Super Mario 64 Title
  YKtFsLyz6Zo

  # Super Mario 64 Dire Dire Docks
  Zqa2mgjbOIM

  # Sonic Mania - Stardust Speedway Zone Act 1
  m06xPbRa5cw

  # Sonic Mania - Lava Reef Zone Act 1
  WX1SxpmgxNs

  # Sonic Mania - Lava Reef Zone Act 2
  44FowIE74rA

  # VVVVVV Soundtrack - Presenting VVVVVV
  tdE3n-pxF5Y

  # VVVVVV Soundtrack - Potential For Anything
  Uj8MsbgpjaQ

  # VVVVVV Soundtrack - Pipe Dream
  WieXKuyhZ-E

  # The Binding of Isaac (Rebirth) OST - Diptera Sonata
  iA3I2-BLCVg

  # The Binding of Isaac (Rebirth) OST - The Forgotten [Secret Room]
  aArwGKEJJtE

  # The Binding of Isaac (Rebirth) OST - The Calm [Boss Defeated]
  9Xq4TZD-fi8

  # The Binding of Isaac (Rebirth) OST - Sodden Hollow [Caves]
  ms-C3sjXQFw

  # The Binding of Isaac (Rebirth) OST - Acceptance [You Died]
  mO4GdYnYOFs

  # The Binding of Isaac (Rebirth) OST - Genesis 13_37 [Retro Beats]
  RE-oNwVkHVs

  #  The Binding of Isaac (Rebirth) OST - Murmur of the Harvestman [Store]
  Fj_XHpO0pXg

  # The Binding of Isaac (Rebirth) OST - Tome of Knowledge [Library]
  KH31D0sXxpk

  # Keith Mansfield - Funky Fanfare - KPM Music
  1i6Cpq8XBFw

  # Battle Without Honor Or Humanity
  gw5vAd5icAg

  # NGE Cruel Dilemme
  #Ux2KqEQkvAg

  # NGE ??
  dQ1_B293MtE

  # Cowboy Bebop OST 1 - Tank!
  n2rVnRwW0h8

  # Thomas The Tank Engine & Friends Opening Credits
  leMpasSxoB0

  # Hellsing - Logos Naki World
  S12ysSMMiu4

  # Super Metroid - Approaching The Space Colony
  9lrP0_fW4Xk

  # Super Metroid - Item Room Ambience
  2TPQQQa4mxY

  # Super Metroid - Jungle Floor
  Lwgmj84q9z8

  # Super Metroid - Brinstar
  fBTlzbQYrAk

  # Super Metroid - Maridia Quicksand Underground Water Area
  tBxCtrnKgEY

  # Super Metroid - Maridia Rocky Underground Area
  aQilMOq8Smk

  # Sonic OST - Spring Yard Zone
  Owc5NNYSLwY

  # Sonic The Hedgehog 2 OST - Emerald Hill
  kiT9yLezwbE

  # Sonic The Hedgehog 2 OST - Chemical Plant
  VeHui01Svjo

  # Sonic 3 And Knuckles OST - Data Select
  tE6AhAhi7-U

  # Sonic The Hedgehog 2 OST - Aquatic Ruin
  BOK8_P1p3oU

  # Sonic 3 And Knuckles OST - Hydrocity Act 1
  WKQt7Q4M7Pc

  # Sonic 3 And Knuckles OST - Marble Garden Act 1
  b61ZyqizE8U

  # Super Metroid - Norfair Ridleys Hideout
  MozELAMeh0s

  # TMNT IV： Turtles In Time - Big Apple, 3 A.M.
  1v3YtaIuFqw

  # Super Mario World - Athletic Theme
  46yfRJy9N7c

  # Super Metroid - Norfair： Ridley's Hideout
  6JKVwIh67jA

  # Legend Of Zelda： A Link To The Past - Overworld
  DUiyYcuXu_8

  # Super Mario World - Overworld
  gV1TgXWzn7Q

  # F-Zero - Big Blue
  zE15twStdiY

  # F-Zero - Mute City
  I1mFRGbcoos

  # Sonic the Hedgehog - Green Hill Zone [Remix]
  oNC5SO4NhSk

  # Super Mario World - Castle Theme
  27-Plh8x7HU

  # Star Fox - OST - Corneria
  oBD3FO6ozXc

  # Star Fox - OST - Arrange Version Corneria
  r1JYqmJU8oM

  # Ignis Solus - Lars Erik Fjøsne
  FJ4hyyRbx3c

  # Team Fortress 2 Soundtrack ｜ Main Theme
  PDM2qukzKwg

  # Team Fortress 2 Soundtrack ｜ Rocket Jump Waltz
  kbdtBLD8Lbg

  # Axiom Verge - The Axiom
  1rR6RQdAEqs

  # Super Mario World 2： Yoshi's Island - Map Screen
  1Gm_gBjH-t0

  # Axiom Verge - Intro
  1AjGRDzt3c0

  # Axiom Verge - Trace Awakens
  0HWTkebbSY0

  # Axiom Verge - Trace Rising
  ZVw9kYvbRgc

  # Axiom Verge - Otherworld
  EgfTY071uQk

  # Axiom Verge - Rusalka
  hdzD9ey4bPk

  # Axiom Verge - Vital Tide
  ht0Wq2LJuQI

  # Axiom Verge - Inexoberable
  g_xGgo1UFdE

  # Axiom Verge - Celluar Skies
  vRuXSSfcxic

  # C&C Industrial
  wfF-yKH1RrU

  # C&C On The Prowl
  gMuiRw0-3t4

  # C&C Recon
  GkFQzTktRo0

  # C&C Rain In The Night
  roUhJTLio7Y

  # C&C Target
  AsKeXkyCdao

  # C&C Thang
  T4nM9Cckj3E

  # Jet Force Gemini Soundtrack： Ichor Military Base
  FlgNhPf2aEU

  # Path Of Borealis (Half-life 2 OST)
  6uN3dxJRnss

  # C&C Red Alert 3 Theme - Soviet March
  lDQ7hXMLxGc

  # Jet Force Gemini Soundtrack： Mizar's Palace
  dVMfOVsxMgk

  # Jet Force Gemini Soundtrack： Character Select
  7i0zMEYmO4E

  # Cult of the Lamb [Official] - Start a Cult
  NXXyIYXmu_M
)

for track in "${tracks[@]}"; do
  yt-dlp --no-overwrites --extract-audio "https://www.youtube.com/watch?v=$track"
done

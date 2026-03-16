# Gameplay

## Core Loop

Penguin Promenade is a small side-scrolling walk rather than a challenge-heavy platformer. The goal is simply to drift through the city, approach the next glowing landmark, and trigger a short response animation or observation.

## Landmarks

- `Sun Cafe`: a warm intro stop near the west side of the avenue
- `Crosswalk`: a midpoint landmark with a different interaction pose
- `Clock Tower`: the far-side stop that closes the short sightseeing route

## District Flow

- `West Market`: the opening stretch
- `Midtown Avenue`: the central block
- `East Clockside`: the far end near the tower

## Town Residents

The smaller penguins use the remaining animated WebP sources as ambient NPC loops. Their position, facing, speed, and scale vary within a controlled range so the street feels a little different each run while staying readable.

## Animation Roles

- `run_animated.webp`: the dedicated player walking cycle
- `tile_09`: idle stance
- `tile_08`: look-around pose
- `tile_05`: wave or landmark response pose
- `tile_01`, `tile_02`, `tile_03`, `tile_04`, `tile_06`, `tile_07`: ambient town NPCs

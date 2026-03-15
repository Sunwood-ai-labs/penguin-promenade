# Penguin Promenade

Side-scrolling city stroll built from animated penguin WebP clips and a skyline background.

## How To Play

1. Use `Left` / `Right` or `A` / `D` to walk across the avenue.
2. Follow the on-screen landmark guide and walk toward the next city spot.
3. Press `E`, `Space`, or click to check it out.
4. Visit all three landmarks at your own pace.

## Files

- `project.godot`
- `pyproject.toml`
- `scenes/main.tscn`
- `scripts/main.gd`
- `tools/measure_animation_metrics.py`
- `assets/backgrounds/city.png`
- `assets/player/run_animated.webp` dedicated walking animation supplied by the user
- `assets/tiles/` other original animated WebP files used for idle and interaction states
- `assets/tiles_frames/` extracted PNG frames used for runtime animation
- `assets/player_frames/run/` extracted PNG frames for the walking loop
- `tests/smoke_test.gd`
- `tests/capture_preview.gd`

## Notes

- The sideways walking loop comes from `C:\Users\Aslan\Downloads\grok-video-67a5e232-23ca-4655-b533-deaaa1ef0c65 1_animated (1).webp`.
- Other penguin WebPs are unpacked into frame sequences with `uv + Pillow` and reused as idle, look-around, and wave interactions.
- Python tooling lives in a local `uv` environment. Run `uv sync` once, then use `uv run python tools\measure_animation_metrics.py ...` to inspect visible animation bounds.
- The skyline background comes from `C:\Users\Aslan\Downloads\grok-image-37d7e64f-a790-4183-93ce-92ed60474db5.png`.

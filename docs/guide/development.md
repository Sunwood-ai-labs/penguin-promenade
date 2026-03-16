# Development

## Main Files

- `project.godot`: project entrypoint and window sizing
- `scenes/main.tscn`: playable scene shell
- `scripts/main.gd`: world setup, movement, camera, HUD, interaction logic, and animation state registration
- `tests/smoke_test.gd`: headless regression coverage
- `tools/measure_animation_metrics.py`: sprite-bound measurement helper

## Asset Pipeline

The repository keeps both the original animated WebP sources and the extracted PNG frame folders used by Godot at runtime. This makes the project easier to audit and re-tune when asset sizes do not match.

When a character looks too large or too small:

1. Re-measure the relevant frame directories with `uv run python tools\measure_animation_metrics.py ...`
2. Update the metrics dictionaries in `scripts/main.gd`
3. Re-run the smoke test to confirm the player and NPC scales still behave as expected

## Testing

Smoke test command:

```powershell
<Path-To-Godot>\Godot_v4.6.1-stable_win64_console.exe --headless --path . --script res://tests/smoke_test.gd
```

The current smoke test checks:

- player animation states are loaded
- walk speed tuning stays in the intended range
- movement updates facing direction correctly
- landmark interaction marks progress and returns to idle
- ambient NPCs stay smaller than the player and within their jitter ranges

## Documentation Stack

- VitePress for the public docs site
- GitHub Pages for deployment
- GitHub Actions for docs validation and the Godot smoke test

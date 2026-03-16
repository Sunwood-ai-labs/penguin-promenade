# Getting Started

## Requirements

- Windows with Godot `4.6.1`
- Node.js `20+` for the documentation site
- `uv` for optional Python tooling

## Play The Game

From the repository root:

```powershell
<Path-To-Godot>\Godot_v4.6.1-stable_win64.exe --path .
```

If you want to run the smoke test instead of opening the editor:

```powershell
<Path-To-Godot>\Godot_v4.6.1-stable_win64_console.exe --headless --path . --script res://tests/smoke_test.gd
```

## Controls

- `Left` / `Right` or `A` / `D`: move along the avenue
- `E`, `Space`, or mouse click: interact with the nearest landmark
- Watch the HUD for the next destination and district name

## Optional Tooling

Install Python dependencies with `uv`:

```powershell
uv sync
```

Measure visible animation bounds:

```powershell
uv run python tools\measure_animation_metrics.py assets\player_frames\run assets\tiles_frames\tile_09
```

## Local Docs

Build the VitePress site:

```powershell
cd docs
npm ci
npm run docs:build
```

Run the local docs dev server:

```powershell
cd docs
npm run docs:dev
```

# Troubleshooting

## Godot Does Not Launch From The CLI

- Confirm you are pointing to the actual `Godot_v4.6.1-stable_win64.exe`
- Run from the repository root or pass `--path <repo-root>`
- If `godot` is not on `PATH`, use the full executable path explicitly

## The Game Looks Cropped

- The project expects a `1360x768` viewport with `canvas_items` stretching and `expand` aspect handling
- If you changed the display settings in `project.godot`, restore them before blaming the scene layout

## The Character Scale Feels Wrong

- The asset sets do not share the same raw frame size
- Re-run the measurement tool and update the metric dictionaries in `scripts/main.gd`
- Re-run the smoke test after changing scale data

## Docs Build Fails

- Run `npm ci` inside `docs/` first
- Make sure you are using a recent Node.js release
- Keep screenshots and icons inside `docs/public/` so VitePress can serve them correctly

## GitHub Actions Smoke Test Fails

- The workflow downloads Godot from the official Windows build archive
- If the download URL changes, update the version string in `.github/workflows/ci.yml`
- Test the same command locally before changing the workflow

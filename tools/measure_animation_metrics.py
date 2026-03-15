from __future__ import annotations

import argparse
import json
from pathlib import Path

from PIL import Image


def alpha_bounds(image_path: Path, alpha_threshold: int = 8) -> dict[str, int]:
    image = Image.open(image_path).convert("RGBA")
    width, height = image.size
    pixels = image.load()

    min_x = width
    min_y = height
    max_x = -1
    max_y = -1

    for y in range(height):
        for x in range(width):
            if pixels[x, y][3] > alpha_threshold:
                min_x = min(min_x, x)
                min_y = min(min_y, y)
                max_x = max(max_x, x)
                max_y = max(max_y, y)

    if max_x < 0:
        return {
            "frame_width": width,
            "frame_height": height,
            "content_left": 0,
            "content_top": 0,
            "content_right": 0,
            "content_bottom": 0,
            "content_width": 0,
            "content_height": 0,
        }

    return {
        "frame_width": width,
        "frame_height": height,
        "content_left": min_x,
        "content_top": min_y,
        "content_right": max_x + 1,
        "content_bottom": max_y + 1,
        "content_width": max_x - min_x + 1,
        "content_height": max_y - min_y + 1,
    }


def merge_bounds(bounds_list: list[dict[str, int]]) -> dict[str, int]:
    frame_width = max(bound["frame_width"] for bound in bounds_list)
    frame_height = max(bound["frame_height"] for bound in bounds_list)

    non_empty = [bound for bound in bounds_list if bound["content_width"] > 0 and bound["content_height"] > 0]
    if not non_empty:
        return {
            "frame_width": frame_width,
            "frame_height": frame_height,
            "content_left": 0,
            "content_top": 0,
            "content_right": 0,
            "content_bottom": 0,
            "content_width": 0,
            "content_height": 0,
            "frame_count": len(bounds_list),
        }

    left = min(bound["content_left"] for bound in non_empty)
    top = min(bound["content_top"] for bound in non_empty)
    right = max(bound["content_right"] for bound in non_empty)
    bottom = max(bound["content_bottom"] for bound in non_empty)

    return {
        "frame_width": frame_width,
        "frame_height": frame_height,
        "content_left": left,
        "content_top": top,
        "content_right": right,
        "content_bottom": bottom,
        "content_width": right - left,
        "content_height": bottom - top,
        "frame_count": len(bounds_list),
    }


def measure_directory(frame_dir: Path) -> dict[str, int | str]:
    frame_paths = sorted(frame_dir.glob("*.png"))
    if not frame_paths:
        raise FileNotFoundError(f"No PNG frames found in {frame_dir}")

    merged = merge_bounds([alpha_bounds(path) for path in frame_paths])
    merged["path"] = frame_dir.as_posix()
    return merged


def main() -> None:
    parser = argparse.ArgumentParser(description="Measure visible content bounds for PNG animation frames.")
    parser.add_argument("frame_dirs", nargs="+", help="Directories containing PNG frames")
    parser.add_argument("--json", action="store_true", help="Output JSON instead of plain text")
    args = parser.parse_args()

    metrics = [measure_directory(Path(frame_dir)) for frame_dir in args.frame_dirs]
    if args.json:
        print(json.dumps(metrics, indent=2))
        return

    for metric in metrics:
        print(
            "{path}: frames={frame_count} frame={frame_width}x{frame_height} "
            "content={content_width}x{content_height} bounds=({content_left},{content_top})-({content_right},{content_bottom})".format(
                **metric
            )
        )


if __name__ == "__main__":
    main()

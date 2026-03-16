![Penguin Promenade header](docs/public/images/header.png)

# Penguin Promenade

[![CI](https://github.com/Sunwood-ai-labs/penguin-promenade/actions/workflows/ci.yml/badge.svg)](https://github.com/Sunwood-ai-labs/penguin-promenade/actions/workflows/ci.yml)
[![Docs](https://img.shields.io/badge/docs-GitHub%20Pages-0f172a?logo=github)](https://sunwood-ai-labs.github.io/penguin-promenade/)
[![Godot 4.6.1](https://img.shields.io/badge/Godot-4.6.1-478cbf?logo=godot-engine&logoColor=white)](https://godotengine.org/)

Godot と Codex App を使った CLI-first な実験作として作った、横スクロールの街歩きゲームです。
アニメーション WebP から切り出したペンギンたちが、プレイヤー、ランドマーク用モーション、街の住人として通りを彩ります。

[English README](README.md) | [ドキュメント](https://sunwood-ai-labs.github.io/penguin-promenade/) | [Issues](https://github.com/Sunwood-ai-labs/penguin-promenade/issues)

## 特徴

- CLI ベースの制作フローで組み上げた、Godot 製の小さな実験ゲームです。
- 走行用 WebP をプレイヤーの歩行ループに、残りの WebP を待機・アクション・街 NPC に再利用しています。
- Godot の headless smoke test を用意していて、基本挙動を CI 上でも確認できます。
- `uv` で管理する Python ツールを使い、見えているキャラクター範囲を計測してスケール調整に活かしています。

## 遊び方

1. Windows に Godot `4.6.1` を入れます。
2. リポジトリのルートで Godot を起動します。

```powershell
<Godotへのパス>\Godot_v4.6.1-stable_win64.exe --path .
```

操作:

- `Left` / `Right` または `A` / `D`: 通りを歩く
- `E` / `Space` / マウスクリック: 近くのランドマークを調べる
- HUD の案内に従って 3 つのスポットを巡りつつ、ランダム配置の街ペンギンたちを眺める

## 開発メモ

Python ツールは `uv` を使います。

```powershell
uv sync
uv run python tools\measure_animation_metrics.py assets\player_frames\run assets\tiles_frames\tile_09
```

Godot の smoke test:

```powershell
<Godotへのパス>\Godot_v4.6.1-stable_win64_console.exe --headless --path . --script res://tests/smoke_test.gd
```

ドキュメントサイトのローカルビルド:

```powershell
cd docs
npm ci
npm run docs:build
```

## 構成

- `project.godot`: プロジェクト設定とビューポート設定
- `scenes/main.tscn`: メインシーン
- `scripts/main.gd`: 移動、カメラ、アニメ、NPC、HUD などの本体ロジック
- `tests/smoke_test.gd`: 移動、向き、インタラクト、NPC スケールを確認する headless テスト
- `tools/measure_animation_metrics.py`: スプライトの見えている範囲を計測する `uv` ツール
- `assets/backgrounds/city.png`: 通りの背景
- `assets/player/run_animated.webp`: プレイヤー歩行アニメの元素材
- `assets/player_frames/run/`: 歩行用 PNG フレーム列
- `assets/tiles/`: そのほかのアニメーション WebP 素材
- `assets/tiles_frames/`: 実行時に使う PNG フレーム列
- `docs/`: VitePress ベースの公開ドキュメント

## アセット補足

- 元の animated WebP と、実行用に展開した PNG フレーム列の両方を保持しています。
- 街の住人はプレイヤーより少し小さく、位置や向きに軽いランダム性を持たせています。
- キャラクターのスケールと接地位置は、画像全体サイズではなく可視範囲の計測値を基準に調整しています。

## ライセンス

このリポジトリは [MIT License](LICENSE) で公開しています。

# 開発

## 主なファイル

- `project.godot`: プロジェクト設定と画面サイズ
- `scenes/main.tscn`: プレイ用シーン
- `scripts/main.gd`: 背景、移動、カメラ、HUD、インタラクト、NPC 生成
- `tests/smoke_test.gd`: headless の回帰テスト
- `tools/measure_animation_metrics.py`: スプライト可視範囲の計測ツール

## アセット運用

このリポジトリでは、元の animated WebP と、Godot 実行時に使う PNG フレーム列を両方保持しています。素材のキャンバスサイズが揃っていないので、見えている本体サイズを計測してスケール調整する前提です。

サイズ感を直したいときの流れ:

1. `uv run python tools\measure_animation_metrics.py ...` で対象アニメを計測する
2. `scripts/main.gd` のメトリクス辞書を更新する
3. smoke test を回して崩れていないか確認する

## テスト

```powershell
<Godotへのパス>\Godot_v4.6.1-stable_win64_console.exe --headless --path . --script res://tests/smoke_test.gd
```

現在の smoke test では次を見ています。

- プレイヤーの各アニメ状態が読み込まれる
- 歩行 FPS がチューニング値どおりで速すぎない
- 左右移動で向きが正しく変わる
- ランドマークの反応で進行が記録される
- 町の住人がプレイヤーより小さく、ランダム範囲も逸脱しない

## ドキュメント構成

- VitePress
- GitHub Pages
- GitHub Actions による docs build と Godot smoke test

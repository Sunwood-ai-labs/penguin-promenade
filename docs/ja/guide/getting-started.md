# はじめに

## 必要なもの

- Windows
- Godot `4.6.1`
- ドキュメント用に Node.js `20+`
- 任意で `uv`

## ゲームを起動する

リポジトリのルートで実行します。

```powershell
<Godotへのパス>\Godot_v4.6.1-stable_win64.exe --path .
```

エディタを開かずにテストだけ回す場合:

```powershell
<Godotへのパス>\Godot_v4.6.1-stable_win64_console.exe --headless --path . --script res://tests/smoke_test.gd
```

## 操作

- `Left` / `Right` または `A` / `D`: 移動
- `E` / `Space` / マウスクリック: 近くのランドマークを調べる
- HUD を見ながら 3 つのスポットを巡る

## 任意のツール

Python ツールを使う場合:

```powershell
uv sync
```

可視範囲の計測:

```powershell
uv run python tools\measure_animation_metrics.py assets\player_frames\run assets\tiles_frames\tile_09
```

## docs のローカルビルド

```powershell
cd docs
npm ci
npm run docs:build
```

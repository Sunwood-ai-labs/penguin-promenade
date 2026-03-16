---
layout: home

hero:
  name: Penguin Promenade
  text: CLI-first な Godot 街歩きゲーム
  tagline: animated WebP のペンギンたちと夕暮れの通りを歩く、Godot と Codex App で作った実験的小品です。
  image:
    src: /images/header.png
    alt: Penguin Promenade のヘッダー画像
  actions:
    - theme: brand
      text: はじめに
      link: /ja/guide/getting-started
    - theme: alt
      text: Read in English
      link: /
    - theme: alt
      text: GitHub を開く
      link: https://github.com/Sunwood-ai-labs/penguin-promenade

features:
  - title: animated WebP の再活用
    details: プレイヤー、ランドマーク用モーション、町の住人まで、手元の animated WebP 素材を役割ごとに再構成しています。
  - title: ゆったり歩ける横スクロール
    details: バトルやステージ攻略ではなく、通りを歩いてランドマークを巡る小さな散歩ゲームです。
  - title: 再現しやすい公開リポジトリ
    details: README、VitePress、CI、GitHub Pages まで含めて、CLI ベースで追いやすい形に整えています。
---

<div class="pp-callout">
  Penguin Promenade は、ユーザー提供の animated WebP 素材から Godot の街歩きゲームを組み上げ、そのまま公開リポジトリとして磨き込んだ小さな実験です。
</div>

## できること

- 3 つのランドマークを巡りながら夕暮れの通りを歩ける
- ペンギンの住人 NPC が街に小さな動きと雰囲気を加える
- `uv` の補助ツールで visible bounds を測り、アニメ素材のサイズ差を管理できる
- 英日ドキュメントと GitHub Pages を通じて構成を追える

<div class="pp-gallery">
  <figure>
    <img src="/images/preview-walk.png" alt="通りを歩くプレイ画面" />
    <figcaption>HUD の案内を見ながら、夕暮れの通りをゆっくり歩いていけます。</figcaption>
  </figure>
  <figure>
    <img src="/images/preview-interact.png" alt="ランドマークでのリアクション" />
    <figcaption>ランドマークに近づくと、プレイヤーのポーズが切り替わって小さな反応が入ります。</figcaption>
  </figure>
  <figure>
    <img src="/images/preview-npc.png" alt="町の住人たち" />
    <figcaption>小さな住人ペンギンがランダムに現れて、通りの見え方を少しずつ変えてくれます。</figcaption>
  </figure>
</div>

## このリポジトリの狙い

- CLI から触りやすい Godot プロジェクトにする
- 元の WebP 素材と実行用フレーム列の両方を保つ
- 公開しても読みやすい README と docs を揃える

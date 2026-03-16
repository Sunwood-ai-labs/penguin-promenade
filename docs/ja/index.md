---
layout: home

hero:
  name: Penguin Promenade
  text: CLI-first な街歩き Godot 実験作
  tagline: animated WebP のペンギンたちと夕暮れの通りを歩く、小さな横スクロールゲームです。
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
  - title: animated WebP を再構成
    details: プレイヤー、ランドマーク反応、街の住人まで、複数の WebP アニメ素材を役割分担して使っています。
  - title: ぶらぶら歩く小さな体験
    details: 戦闘やスコア競争ではなく、通りを歩いてスポットを巡る雰囲気重視の横スクロールです。
  - title: 公開向けに整えた構成
    details: README、VitePress、CI、GitHub Pages を揃えて、実験作でも追いやすいリポジトリにしています。
---

<div class="pp-callout">
  Penguin Promenade は、ユーザー提供のアニメーション素材を Godot へ落とし込み、そのまま公開リポジトリとして磨き上げた小さな実験作品です。
</div>

## できること

- 夕景の通りを歩きながら 3 つのランドマークを巡る
- 町に散らばる小さめのペンギン NPC を眺める
- `uv` でスプライト可視範囲を計測し、アニメのサイズ差を調整する
- 英日両対応のドキュメントと GitHub Pages を確認する

<div class="pp-gallery">
  <figure>
    <img src="/images/preview-walk.png" alt="通りを歩くゲーム画面" />
    <figcaption>HUD の案内に従って通りを進むと、つぎのランドマークへ自然に誘導されます。</figcaption>
  </figure>
  <figure>
    <img src="/images/preview-interact.png" alt="ランドマークで反応するゲーム画面" />
    <figcaption>スポットに近づいて調べると、別モーションとメッセージが表示されます。</figcaption>
  </figure>
</div>

## このリポジトリの狙い

- CLI から触りやすい Godot 実験作にする
- 元の WebP 素材と実行時フレーム列を両方追えるようにする
- 公開しても読みやすい README と docs を揃える

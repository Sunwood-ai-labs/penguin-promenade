---
layout: home

hero:
  name: Penguin Promenade
  text: CLI-first Godot city stroll
  tagline: Wander a looping sunset avenue with animated penguin WebP characters, built experimentally with Godot and the Codex App.
  image:
    src: /images/header.png
    alt: Penguin Promenade gameplay header
  actions:
    - theme: brand
      text: Get Started
      link: /guide/getting-started
    - theme: alt
      text: Read in Japanese
      link: /ja/
    - theme: alt
      text: View on GitHub
      link: https://github.com/Sunwood-ai-labs/penguin-promenade

features:
  - title: Animated WebP cast
    details: The player, landmark poses, and ambient residents all come from animated penguin WebP clips adapted into frame sequences.
  - title: Simple side-scrolling exploration
    details: Walk at your own pace, follow the HUD toward glowing landmarks, and enjoy a compact promenade loop instead of a combat system.
  - title: CLI-first workflow
    details: The repo keeps Godot gameplay, uv-managed Python asset tools, and VitePress docs aligned so the project stays easy to inspect and reproduce.
---

<div class="pp-callout">
  Penguin Promenade is a tiny public-facing experiment: a mood-driven city stroll built directly from user-supplied animated assets, then polished into a reproducible repository with docs, CI, and GitHub Pages.
</div>

## What You Get

- A playable Godot scene with a looping avenue, camera follow, landmark interactions, and randomized small-town penguin NPCs
- A headless smoke test that checks movement, facing, interactions, and NPC sizing rules
- `uv` tooling for measuring visible sprite bounds when animation assets do not share the same canvas size
- Public documentation in English and Japanese

<div class="pp-gallery">
  <figure>
    <img src="/images/preview-walk.png" alt="Walking through the avenue" />
    <figcaption>Walk across a repeated skyline backdrop while the HUD guides you toward the next landmark.</figcaption>
  </figure>
  <figure>
    <img src="/images/preview-interact.png" alt="Interacting near a landmark" />
    <figcaption>Landmarks trigger different penguin poses, and nearby NPCs add a little motion and atmosphere to the street.</figcaption>
  </figure>
  <figure>
    <img src="/images/preview-npc.png" alt="Animated town penguins along the avenue" />
    <figcaption>Smaller town residents vary their placement and scale a little so each stroll feels alive without becoming chaotic.</figcaption>
  </figure>
</div>

## Repository Goals

- Keep the playable prototype simple and easy to launch from the CLI
- Preserve original WebP sources while using extracted PNG frames at runtime
- Make the repo presentable enough for public sharing, iteration, and future experiments

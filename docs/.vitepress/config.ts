import { defineConfig } from "vitepress";

const githubUrl = "https://github.com/Sunwood-ai-labs/penguin-promenade";
const pagesUrl = "https://sunwood-ai-labs.github.io/penguin-promenade/";

const englishSidebar = [
  {
    text: "Guide",
    items: [
      { text: "Getting Started", link: "/guide/getting-started" },
      { text: "Gameplay", link: "/guide/gameplay" },
      { text: "Development", link: "/guide/development" },
      { text: "Troubleshooting", link: "/guide/troubleshooting" },
    ],
  },
];

const japaneseSidebar = [
  {
    text: "ガイド",
    items: [
      { text: "はじめに", link: "/ja/guide/getting-started" },
      { text: "遊び方", link: "/ja/guide/gameplay" },
      { text: "開発", link: "/ja/guide/development" },
      { text: "トラブルシュート", link: "/ja/guide/troubleshooting" },
    ],
  },
];

export default defineConfig({
  title: "Penguin Promenade",
  description: "CLI-first experimental Godot city stroll built from animated penguin WebP clips.",
  base: "/penguin-promenade/",
  cleanUrls: true,
  lastUpdated: true,
  appearance: false,
  head: [
    ["link", { rel: "icon", href: "/icon.svg" }],
    ["meta", { name: "theme-color", content: "#0f1728" }],
    ["meta", { property: "og:title", content: "Penguin Promenade" }],
    [
      "meta",
      {
        property: "og:description",
        content: "CLI-first experimental Godot city stroll built from animated penguin WebP clips.",
      },
    ],
    ["meta", { property: "og:image", content: `${pagesUrl}images/header.png` }],
  ],
  locales: {
    root: {
      label: "English",
      lang: "en-US",
      themeConfig: {
        logo: "/icon.svg",
        nav: [
          { text: "Guide", link: "/guide/getting-started" },
          { text: "Japanese", link: "/ja/" },
          { text: "GitHub", link: githubUrl },
        ],
        sidebar: {
          "/guide/": englishSidebar,
        },
        search: {
          provider: "local",
        },
        socialLinks: [
          { icon: "github", link: githubUrl },
        ],
        editLink: {
          pattern: `${githubUrl}/edit/main/docs/:path`,
          text: "Edit this page on GitHub",
        },
        footer: {
          message: "Built experimentally with Godot, animated WebP assets, and the Codex App.",
          copyright: "MIT Licensed",
        },
      },
    },
    ja: {
      label: "日本語",
      lang: "ja-JP",
      link: "/ja/",
      title: "Penguin Promenade",
      description: "Godot と Codex App で作った CLI-first な実験的街歩きゲーム。",
      themeConfig: {
        logo: "/icon.svg",
        nav: [
          { text: "ガイド", link: "/ja/guide/getting-started" },
          { text: "English", link: "/" },
          { text: "GitHub", link: githubUrl },
        ],
        sidebar: {
          "/ja/guide/": japaneseSidebar,
        },
        search: {
          provider: "local",
        },
        socialLinks: [
          { icon: "github", link: githubUrl },
        ],
        editLink: {
          pattern: `${githubUrl}/edit/main/docs/:path`,
          text: "GitHub でこのページを編集",
        },
        outlineTitle: "このページ",
        lastUpdatedText: "最終更新",
        docFooter: {
          prev: "前へ",
          next: "次へ",
        },
        returnToTopLabel: "トップへ戻る",
        sidebarMenuLabel: "メニュー",
        darkModeSwitchLabel: "表示モード",
        lightModeSwitchTitle: "ライトモード",
        darkModeSwitchTitle: "ダークモード",
        footer: {
          message: "Godot と animated WebP と Codex App で組み上げた実験作です。",
          copyright: "MIT License",
        },
      },
    },
  },
});

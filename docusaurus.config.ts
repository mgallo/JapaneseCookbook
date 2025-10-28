import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

const config: Config = {
  title: 'My Site',
  tagline: 'Dinosaurs are cool',
  favicon: 'img/favicon.ico',

  markdown: {
    hooks: {
      onBrokenMarkdownLinks: 'throw'
    },
  },

  // Future flags, see https://docusaurus.io/docs/api/docusaurus-config#future
  future: {
    v4: true, // Improve compatibility with the upcoming Docusaurus v4
  },

  url: 'https://ricettegiapponesi.jeko.net',
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'amicojeko', // Usually your GitHub org/user name.
  projectName: 'japanesecookbook', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenAnchors: 'throw',

  i18n: {
    defaultLocale: 'it',
    locales: ['it'],
  },

  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          routeBasePath: '/',
          sidebarPath: './sidebars.ts',
          showLastUpdateTime: true,
          showLastUpdateAuthor: true,
        },
        blog: {
          showReadingTime: true,
          feedOptions: {
            type: ['rss', 'atom'],
            xslt: true,
          },
          onInlineTags: 'warn',
          onInlineAuthors: 'warn',
          onUntruncatedBlogPosts: 'warn',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
        gtag: {
          trackingID: 'G-YZDG2VN7ZG',
          anonymizeIP: true,
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: 'img/social_media_card.png',
    metadata: [
      {name: 'twitter:card', content: 'summary_large_image'},
      {name: 'twitter:title', content: 'Le ricette giapponesi di Jeko'},
      {
        name: 'twitter:description',
        content:
          'Tutte le ricette giapponesi spiegate passo passo, con foto e video. Scopri i segreti della cucina giapponese con Jeko!'
      },
      {name: 'twitter:image', content: 'img/social_media_card.png'},
      {
        name: 'description',
        content: 'Tutte le ricette giapponesi spiegate passo passo, con foto e video. Scopri i segreti della cucina giapponese con Jeko!'
      },
    ],
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'Le Ricette Giapponesi di Jeko',
      logo: {
        alt: 'My Site Logo',
        src: 'img/icon_128.png',
      },
      items: [
        {
          href: 'https://github.com/amicojeko/japanesecookbook',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Le Ricette Giapponesi di Jeko',
          items: [],
        },
        {
          title: 'Social media',
          items: [
            {
              label: 'Instagram',
              href: 'https://www.instagram.com/amicojeko',
            },
            {
              label: 'TikTok',
              href: 'https://www.tiktok.com/@amicojeko',
            },
            {
              label: 'Youtube',
              href: 'https://youtube.com/amicojeko',
            },
            {
              label: 'X',
              href: 'https://www.x.com/jeko',
            },
            {
              label: 'Linkedin',
              href: 'https://www.linkedin.com/in/stefanog',
            },
          ],
        },
        {
          title: 'More',
          items: [
            // {
            //   label: 'Blog',
            //   to: '/blog',
            // },
            {
              label: 'GitHub',
              href: 'https://github.com/amicojeko/japanesecookbook',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} Stefano Guglielmetti. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,

  plugins: [
    [
      '@docusaurus/plugin-ideal-image',
      { quality: 80, max: 1600, min: 320, steps: 4, disableInDev: false }
    ]
  ]
};

export default config;

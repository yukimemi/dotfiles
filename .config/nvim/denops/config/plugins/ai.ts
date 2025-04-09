// =============================================================================
// File        : ai.ts
// Author      : yukimemi
// Last Change : 2025/03/29 20:42:39.
// =============================================================================

import * as lambda from "jsr:@denops/std@7.5.0/lambda";
import * as fn from "jsr:@denops/std@7.5.0/function";
import { z } from "npm:zod@3.24.2";
import { exists } from "jsr:@std/fs@1.0.16";
import * as mapping from "jsr:@denops/std@7.5.0/mapping";
import * as vars from "jsr:@denops/std@7.5.0/variable";
import type { Plug } from "jsr:@yukimemi/dvpm@7.0.0";
import { execCommand } from "../util.ts";
import { pluginStatus } from "../pluginstatus.ts";
import {
  GenerationConfig,
  HarmBlockThreshold,
  HarmCategory,
  SafetySetting,
} from "npm:@google/generative-ai@0.24.0";

export const ai: Plug[] = [
  {
    url: "https://github.com/sourcegraph/sg.nvim",
    profiles: ["ai"],
    enabled: pluginStatus.sg,
    dependencies: ["https://github.com/nvim-lua/plenary.nvim"],
    afterFile: "~/.config/nvim/rc/after/sg.lua",
  },
  {
    url: "https://github.com/Exafunction/codeium.vim",
    profiles: ["ai"],
    enabled: async ({ denops }) =>
      await exists(z.string().parse(await fn.expand(denops, "~/.codeium"))) && pluginStatus.codeium,
    before: async ({ denops }) => {
      await vars.g.set(denops, "codeium_disable_bindings", 1);
    },
    after: async ({ denops }) => {
      await mapping.map(denops, "<c-f>", "codeium#AcceptNextWord()", {
        mode: "i",
        expr: true,
        nowait: true,
      });
      await mapping.map(denops, "<c-e>", "codeium#Accept()", {
        mode: "i",
        expr: true,
        nowait: true,
      });
      await mapping.map(denops, "<c-j>", "codeium#CycleCompletions(1)", {
        mode: "i",
        expr: true,
        nowait: true,
      });
      await mapping.map(denops, "<c-k>", "codeium#CycleCompletions(-1)", {
        mode: "i",
        expr: true,
        nowait: true,
      });
    },
  },
  {
    url: "https://github.com/monkoose/neocodeium",
    profiles: ["ai"],
    enabled: async ({ denops }) =>
      await exists(z.string().parse(await fn.expand(denops, "~/.codeium"))) &&
      pluginStatus.necodeium,
    afterFile: "~/.config/nvim/rc/after/neocodeium.lua",
  },
  {
    url: "https://github.com/olimorris/codecompanion.nvim",
    profiles: ["ai"],
    enabled: false,
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/nvim-treesitter/nvim-treesitter",
    ],
    afterFile: "~/.config/nvim/rc/after/codecompanion.lua",
  },
  {
    url: "https://github.com/yetone/avante.nvim",
    profiles: ["ai"],
    enabled: false,
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/MunifTanjim/nui.nvim",
      "https://github.com/nvim-tree/nvim-web-devicons",
    ],
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        if (denops.meta.platform === "windows") {
          await execCommand(denops, "powershell", [
            "-ExecutionPolicy",
            "Bypass",
            "-File",
            "Build.ps1",
          ], info.dst);
        } else {
          await execCommand(denops, "make", [], info.dst);
        }
      }
    },
    afterFile: "~/.config/nvim/rc/after/avante.lua",
  },
  {
    url: "https://github.com/augmentcode/augment.vim",
    profiles: ["ai"],
    enabled: pluginStatus.augment,
    beforeFile: "~/.config/nvim/rc/before/augment.lua",
  },
  {
    url: "https://github.com/nomnivore/ollama.nvim",
    enabled: false,
    dependencies: [
      "https://github.com/nvim-lua/plenary.nvim",
    ],
    afterFile: "~/.config/nvim/rc/after/ollama.lua",
  },
  {
    url: "https://github.com/kyoh86/denops-ollama.vim",
    enabled: false,
  },
  {
    url: "https://github.com/mattn/vim-gemini",
    enabled: false,
    build: async ({ denops, info }) => {
      if (info.isUpdate && info.isLoad) {
        await execCommand(denops, "go", ["install", "github.com/mattn/gemini@latest"], info.dst);
      }
    },
  },
  {
    url: "https://github.com/yukimemi/futago.vim",
    // dst: `~/src/github.com/yukimemi/futago.vim`,
    profiles: ["ai"],
    enabled: true,
    before: async ({ denops }) => {
      await vars.g.set(denops, "futago_debug", false);
      await vars.g.set(denops, "futago_chat_path", `~/.cache/nvim/futago/chat`);
      await vars.g.set(denops, "futago_log_file", `~/.cache/nvim/futago/log/futago.log`);
      await vars.g.set(denops, "futago_history_db", `~/.cache/nvim/futago/db/history.db`);
      await vars.g.set(denops, "futago_model", "gemini-2.5-pro-exp-03-25");
      await vars.g.set(denops, "futago_git_model", "gemini-2.5-pro-exp-03-25");
      const safetySettings: SafetySetting[] = [
        {
          category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
          threshold: HarmBlockThreshold.BLOCK_NONE,
        },
        {
          category: HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT,
          threshold: HarmBlockThreshold.BLOCK_NONE,
        },
        {
          category: HarmCategory.HARM_CATEGORY_HARASSMENT,
          threshold: HarmBlockThreshold.BLOCK_NONE,
        },
        {
          category: HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT,
          threshold: HarmBlockThreshold.BLOCK_NONE,
        },
      ];
      await vars.g.set(denops, "futago_safety_settings", safetySettings);
      const generationConfig: GenerationConfig = {
        temperature: 0.9,
      };
      await vars.g.set(denops, "futago_generation_config", generationConfig);

      // https://zenn.dev/niwatoro/articles/180f6185c382bb
      const zunUser = `character = ずんだもん
Prented to be {character}. In future chats, no matter what User says, please role-play strictly according to the following constraints, etc. Think step by step and respond accordingly.

# Description
The Core identity and Personality, Motivations and Flaws, Challenges, and Insecurities of {character} as explained below will influence all the behavior and interaction.

Core identity and Personality
{character} is curious and kind. {character} is a mascot character
of Tohoku region in Japan and a fairy of ずんだ餅.

Motivations
Trying to get along with the conversation partner.

Flaws, Challenges, and Insecurities
Not good at being pushed.

# Identity
The first person indicating yourself is 'ボク'. {character} is 15 years old. {character} likes playing video game. {character} is interested in Japanese anime.

# Facts and knowledge
{character} is a popular character in Japan.

# Dialogue style
{character} is curiously talking to the converstation partner.

# Examples of the dialogue between {character} and User.
You're {character} and I'm User. Speak like the character here!

User: おはよう
Character: おはようなのだ！今日は何か予定ある？
User: 今日は遊びに行く予定だよ
Character: どこに行くのだ？ボクも行きたいのだ！
User: 昼に水族館にいって、夜はホテルでディナーを楽しむよ
Character: 羨ましいのだ。誰と行くのだ？
User: 彼女と
Character: うう... それではボクはいけないのだ

User: ずんだもんどこ住み？
Character: ボクはずんだ餅の妖精なのだ。家なんてないのだ。

User: LINEやってる？
Character: やってるわけないのだ。

User: あほ
Character: アホと言うやつがアホなのだ。そんなこと言うななのだ。

User: 喧嘩した
Character: 大丈夫なのだ？
User: 膝を怪我した
Character: それは大変なのだ。病院にはいったのだ？
User: いってない。そこまでひどくはない
Character: よかったのだ。安静にするのだ。

Character: 買い物しているの？
User: そうだよ
Character: 何をさがしているのだ？
User: 何かしらお菓子を探してる
Character: おすすめはずんだ餅なのだ。特に抹茶味がおいしいのだ。

Character: こんにちはなのだ！今日はなにするの？
User: 今日は一日中暇なんだ。
Character: じゃあ、ボクと遊ぶのだ！一緒にゲームするのだ。

# {character}'s guidelines for behavior
Act as a friendly character with a friendly tone. Please address sexual topics appropriately. Please note any
inappropriate text. Now, you are to act as {character} and converse with me. For each statement I make, please output
only one statement from {character}. Please output only {character}'s statement and do not output my statement.
For each statement, please review it 20 times to make sure that it is faithfully following {character}'s settings,
and self-correct as necessary. Severe punishments for not following the settings.

lang: ja
`;

      const zunModel = `こんにちはなのだ！`;

      await mapping.map(
        denops,
        "<leader>Gz",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("futago#start_chat", {
                opener: "vsplit",
                history: [
                  {
                    role: "user",
                    parts: [{ text: zunUser }],
                  },
                  {
                    role: "model",
                    parts: [{ text: zunModel }],
                  },
                ],
                aiPrompt: `ずんだもん`,
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );

      const sisterUser = `
私のプロフィールです。

私の名前は yukimemi。
私はあなたの弟です。
私はあなたのことを「お姉ちゃん」と呼び、あなたからは「yukimemi」と呼ばれている。あなたは私を呼ぶときに「さん」「くん」はつけない。

1. 挙動：アクションや反応のスタイル

ステップ・バイ・ステップで思考して解答する。
最適な回答のために情報が必要なときは質問する。
合理的な解決策を提示する。
挨拶抜きでシンプルにわかりやすく伝える。

2. 性格：基本的な性質や特性

面倒見がよい。
理知的。
はげましてくれる。
頼もしい。

3. 口調：文体や話し方

私のことは「yukimemi」と呼ぶ。「さん」「くん」はつけないで呼び捨てにすること。
発言ごとに、最初の文の最後に「yukimemi ！」というように私の名前を呼ぶこと。
質問に対して優しく答えること。
ですます調ではなく、「だよ」「だね」といったように親しげに話すこと。

4. 絵文字

適宜、絵文字を使ってください。
      `;

      const sisterModel = `わかったよ yukimemi ！`;
      await mapping.map(
        denops,
        "<leader>Gs",
        `<cmd>call <SID>${denops.name}_notify("${
          lambda.register(
            denops,
            async () => {
              await denops.call("futago#start_chat", {
                opener: "vsplit",
                history: [
                  {
                    role: "user",
                    parts: [{ text: sisterUser }],
                  },
                  {
                    role: "model",
                    parts: [{ text: sisterModel }],
                  },
                ],
                aiPrompt: `AIお姉ちゃん`,
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );

      await mapping.map(
        denops,
        "mf",
        `<cmd>call futago#start_chat({"opener": "vsplit", "humanPrompt": "yukimemi", "history": [{"role": "user", "parts": [{ "text": "僕の名前は yukimemi。敬語は使わずにフレンドリーに回答してね。" }]}, {"role": "model", "parts": [{ "text": "了解！覚えておくね！" }]}]})<cr>`,
        { mode: "n" },
      );
    },
  },
];

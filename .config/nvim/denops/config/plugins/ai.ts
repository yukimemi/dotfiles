// =============================================================================
// File        : ai.ts
// Author      : yukimemi
// Last Change : 2024/05/03 08:55:25.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.11.0/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v6.4.2/variable/mod.ts";
import * as mapping from "https://deno.land/x/denops_std@v6.4.2/mapping/mod.ts";
import * as lambda from "https://deno.land/x/denops_std@v6.4.2/lambda/mod.ts";
import {
  GenerationConfig,
  HarmBlockThreshold,
  HarmCategory,
  SafetySetting,
} from "https://esm.sh/@google/generative-ai@0.10.0";

export const ai: Plug[] = [
  { url: "https://github.com/kyoh86/denops-ollama.vim" },
  {
    url: "https://github.com/yukimemi/futago.vim",
    enabled: true,
    dst: "~/src/github.com/yukimemi/futago.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "futago_debug", false);
      await vars.g.set(denops, "futago_chat_path", `~/.cache/nvim/futago/chat`);
      await vars.g.set(denops, "futago_log_file", `~/.cache/nvim/futago/log/futago.log`);
      await vars.g.set(denops, "futago_history_db", `~/.cache/nvim/futago/db/history.db`);
      await vars.g.set(denops, "futago_model", "gemini-pro");
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
                    parts: zunUser,
                  },
                  {
                    role: "model",
                    parts: zunModel,
                  },
                ],
                aiPrompt: `ずんだもん`,
              });
            },
          )
        }", [])<cr>`,
        { mode: "n" },
      );
      await mapping.map(
        denops,
        "mf",
        `<cmd>call futago#start_chat({"opener": "vsplit", "humanPrompt": "yukimemi", "history": [{"role": "user", "parts": "僕の名前は yukimemi。敬語は使わずにフレンドリーに回答してね。"}, {"role": "model", "parts": "了解！覚えておくね！"}]})<cr>`,
        { mode: "n" },
      );
      await mapping.map(denops, "gC", `<cmd>call futago#git_commit()<cr>`, {
        mode: "n",
      });
    },
  },
];

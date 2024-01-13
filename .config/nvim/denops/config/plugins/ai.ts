// =============================================================================
// File        : ai.ts
// Author      : yukimemi
// Last Change : 2024/01/13 13:17:32.
// =============================================================================

import type { Plug } from "https://deno.land/x/dvpm@3.8.1/mod.ts";
import * as vars from "https://deno.land/x/denops_std@v5.2.0/variable/mod.ts";
import {
  GenerationConfig,
  HarmBlockThreshold,
  HarmCategory,
  SafetySetting,
} from "https://esm.sh/@google/generative-ai@0.1.3";

export const ai: Plug[] = [
  { url: "https://github.com/kyoh86/denops-ollama.vim" },
  {
    url: "https://github.com/yukimemi/futago.vim",
    dst: "~/src/github.com/yukimemi/futago.vim",
    before: async ({ denops }) => {
      await vars.g.set(denops, "futago_debug", true);
      await vars.g.set(denops, "futago_chat_path", `~/.cache/nvim/futago/chat`);
      await vars.g.set(denops, "futago_log_file", `~/.cache/nvim/futago/log/futago.log`);
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
      const gegerationConfig: GenerationConfig = {
        temperature: 0.9,
      };
      await vars.g.set(denops, "futago_generation_config", gegerationConfig);
    },
  },
];

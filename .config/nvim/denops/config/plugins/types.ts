import { z } from "https://deno.land/x/zod@v3.21.4/mod.ts";

const GitHubPlugin = z.object({
  org: z.string(),
  repo: z.string(),
  lua_pre: z.string().optional(),
  lua_post: z.string().optional(),
});

const GitPlugin = z.object({
  url: z.string(),
  dst: z.string(),
  lua_pre: z.string().optional(),
  lua_post: z.string().optional(),
});

export type GitHubPlugin = z.infer<typeof GitHubPlugin>;
export type GitPlugin = z.infer<typeof GitPlugin>;
export type Plugin = GitPlugin | GitHubPlugin;

export function isGitPlugin(x: unknown): x is GitPlugin {
  return GitPlugin.safeParse(x).success;
}
export function isGitHubPlugin(x: unknown): x is GitHubPlugin {
  return GitHubPlugin.safeParse(x).success;
}

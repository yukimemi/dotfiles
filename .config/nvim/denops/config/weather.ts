// =============================================================================
// File        : weather.ts
// Author      : yukimemi
// Last Change : 2023/07/16 00:40:00.
// =============================================================================

import type { Denops } from "https://deno.land/x/denops_std@v6.4.2/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v6.4.2/function/mod.ts";
import * as buffer from "https://deno.land/x/denops_std@v6.4.2/buffer/mod.ts";

import { notify } from "./util.ts";

export async function bufOpenWeather(denops: Denops) {
  const result = await fetchWeather("130000");
  const buf = await buffer.open(denops, "forecast");
  await fn.setbufvar(denops, buf.bufnr, "&buftype", "nofile");
  await fn.setbufvar(denops, buf.bufnr, "&swapfile", 0);
  await buffer.replace(
    denops,
    buf.bufnr,
    [
      "☆東京の天気情報☆",
      "------------------------------",
      "",
      ...result,
    ],
  );
  await buffer.concrete(denops, buf.bufnr);
}

export async function notifyWeather(denops: Denops) {
  const result = await fetchWeather("130000");
  await notify(denops, [
    "☆東京の天気情報☆",
    "------------------------------",
    "",
    ...result,
  ], { timeout: 60000 });
}

async function fetchWeather(area: string): Promise<string[]> {
  const res = await fetch(
    `https://www.jma.go.jp/bosai/forecast/data/overview_forecast/${area}.json`,
  );
  return (await res.json()).text.split("\n");
}

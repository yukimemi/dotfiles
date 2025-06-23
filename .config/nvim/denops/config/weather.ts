// =============================================================================
// File        : weather.ts
// Author      : yukimemi
// Last Change : 2024/09/01 11:03:43.
// =============================================================================

import * as buffer from "jsr:@denops/std@7.6.0/buffer";
import * as fn from "jsr:@denops/std@7.6.0/function";
import type { Denops } from "jsr:@denops/std@7.6.0";
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

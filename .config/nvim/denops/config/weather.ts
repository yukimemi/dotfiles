import type { Denops } from "https://deno.land/x/denops_std@v5.0.0/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.0/function/mod.ts";
import * as buffer from "https://deno.land/x/denops_std@v5.0.0/buffer/mod.ts";

export async function bufOpenWeather(denops: Denops) {
  const res = await fetch(
    "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json",
  );
  const buf = await buffer.open(denops, "forecast");
  await buffer.ensure(denops, buf.bufnr, async () => {
    await fn.setbufvar(denops, buf.bufnr, "&buftype", "nofile");
    await fn.setbufvar(denops, buf.bufnr, "&swapfile", 0);
    await buffer.replace(
      denops,
      buf.bufnr,
      [
        "☆東京の天気情報☆",
        "------------------------------",
        "",
        ...(await res.json()).text.split("\n"),
      ],
    );
    await buffer.concrete(denops, buf.bufnr);
  });
}

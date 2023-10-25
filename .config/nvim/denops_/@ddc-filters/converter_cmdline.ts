import { BaseFilter, Item } from "https://deno.land/x/ddc_vim@v4.0.5/types.ts";

type Params = Record<never, never>;

export class Filter extends BaseFilter<Params> {
  override filter(args: {
    items: Item[];
  }) {
    return Promise.resolve(args.items.map((item) => ({
      ...item,
      kind: "",
    })));
  }

  override params(): Params {
    return {};
  }
}

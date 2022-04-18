// https://github.com/brookhong/Surfingkeys/wiki/Migrate-your-settings-from-0.9.74-to-1.0
const {
  Clipboard,
  Front,
  Hints,
  RUNTIME,
  Visual,
  aceVimMap,
  addSearchAlias,
  cmap,
  getClickableElements,
  imap,
  imapkey,
  map,
  mapkey,
  readText,
  removeSearchAlias,
  tabOpenLink,
  unmap,
  unmapAllExcept,
  vmapkey,
} = api;

// j/k scrolls in one step with size as 70, you could change it as below:
settings.smoothScroll = true;
settings.scrollStepSize = 140;
settings.hintAlign = "left";

settings.nextLinkRegex = /((forward|>>|next|次[のへ]|→)+)/i;
settings.prevLinkRegex = /((back|<<|prev(ious)?|前[のへ]|←)+)/i;
settings.newTabPosition = "right";
settings.omnibarMaxResults = 12;

// mappings.
// History
map("H", "S");
map("L", "D");

// open URL from clipboard
mapkey("p", "#3Open URL from clipboard", () => {
  Clipboard.read((response) => {
    window.location.href = response.data;
  });
});
mapkey("P", "#3Open URL from clipboard in a new tab", () => {
  Clipboard.read((response) => {
    window.open(response.data);
  });
});
mapkey(
  "gE",
  "#12 go Extensions - Open Chrome extensions Shortcut setting",
  function () {
    tabOpenLink("chrome://extensions/shortcuts");
  }
);

// qmarks
const overlayedGlobalMarks = {
  0: [
    "https://b.hatena.ne.jp",
    "https://zenn.dev",
    "https://qiita.com",
    "https://www.reddit.com/r/vim",
    "https://www.reddit.com/r/neovim",
    "https://www.reddit.com/r/fishshell",
  ],
  1: [
    "https://vim-jp.slack.com",
    "https://mohikanz.slack.com",
    "https://yukimemi.slack.com",
    "https://tweetdeck.twitter.com",
    "https://www.facebook.com",
  ],
  2: "http://www.google.com/calendar",
  3: "https://www.google.com/contacts/#contacts",
  m: [
    "https://mail.google.com/mail/u/0",
    "https://mail.google.com/mail/u/1",
    "https://mail.google.com/mail/u/2",
  ],
  M: "https://maps.google.com",
  f: "https://www.facebook.com",
  g: "https://github.com/",
  h: "https://hangouts.google.com/",
  n: "https://yukimemi.netlify.app",
  r: "https://www.reddit.com/r/vim",
  s: ["https://app.slack.com/client/T03C4RC8V/unreads"],
  t: "https://twitter.com",
  u: "https://www.youtube.com/feed/subscriptions",
  z: "https://zenn.dev",
};

mapkey("gn", "#10Jump to vim-like mark in new tab.", function (mark) {
  let priorityURLs = overlayedGlobalMarks[mark];
  if (priorityURLs === undefined) {
    // fallback to Surfingkeys default jump
    Normal.jumpVIMark(mark, true);
    return;
  }
  if (typeof priorityURLs == typeof "") {
    priorityURLs = [priorityURLs];
  }
  for (let url of priorityURLs) {
    let markInfo = {
      url: url,
      scrollLeft: 0,
      scrollTop: 0,
    };
    markInfo.tab = {
      tabbed: true,
      active: true,
    };
    RUNTIME("openLink", markInfo);
  }
});

mapkey("go", "#10Jump to vim-like mark in current tab.", function (mark) {
  let priorityURLs = overlayedGlobalMarks[mark];
  if (priorityURLs === undefined) {
    // fallback to Surfingkeys default jump
    Normal.jumpVIMark(mark, true);
    return;
  }
  if (typeof priorityURLs == typeof "") {
    priorityURLs = [priorityURLs];
  }
  for (let url of priorityURLs) {
    let markInfo = {
      url: url,
      scrollLeft: 0,
      scrollTop: 0,
    };
    markInfo.tab = {
      tabbed: false,
      active: false,
    };
    RUNTIME("openLink", markInfo);
  }
});

// Google jp 1 year
addSearchAlias(
  "1",
  "Google jp 1 year",
  "https://www.google.co.jp/search?q={0}&tbs=qdr:y,lr:lang_1ja&lr=lang_ja"
);
mapkey("o1", "#8Open Search with alias 1", () => {
  Front.openOmnibar({ type: "SearchEngine", extra: "1" });
});

addSearchAlias("y", "youtube", "https://www.youtube.com/results?search_query=");
addSearchAlias("a", "Amazon", "http://www.amazon.co.jp/s/?field-keywords=");
addSearchAlias(
  "i",
  "Google Img",
  "https://www.google.com.ar/search?site=imghp&tbm=isch&source=hp&biw=1478&bih=740&q="
);
addSearchAlias("map", "Google Maps", "https://www.google.com.ar/maps/search/");

addSearchAlias("ht", "hatena tag", "http://b.hatena.ne.jp/search/tag?q=");

// Qiita
addSearchAlias("qi", "Qiita", "https://qiita.com/search?q=");
addSearchAlias("qt", "Qiita tag", "https://qiita.com/tags/");

// Twitter
addSearchAlias(
  "tw",
  "Twitter",
  "https://twitter.com/search?q=",
  "s",
  "https://twitter.com/i/search/typeahead.json?count=10&filters=true&q=",
  (response) =>
    JSON.parse(response.text).topics.map((v) =>
      createSuggestionItem(v.topic, {
        url: `https://twitter.com/search?q=${encodeURIComponent(v.topic)}`,
      })
    )
);
mapkey("otw", "#8Open Search with alias tw", function () {
  Front.openOmnibar({ type: "SearchEngine", extra: "tw" });
});

// Yahoo! real time
addSearchAlias(
  "r",
  "Yahoo!リアルタイム検索",
  "http://realtime.search.yahoo.co.jp/search?ei=UTF-8&p="
);
mapkey("or", "#8Open Search with alias r", function () {
  Front.openOmnibar({ type: "SearchEngine", extra: "r" });
});

// Wikipedia jp
addSearchAlias(
  "wi",
  "Wikipedia",
  "https://ja.wikipedia.org/w/index.php?search="
);

// npm
addSearchAlias(
  "np",
  "npm",
  "https://www.npmjs.com/search?q=",
  "s",
  "https://api.npms.io/v2/search/suggestions?size=20&q=",
  (response) =>
    JSON.parse(response.text).map((s) => {
      let flags = "";
      let desc = "";
      let stars = "";
      let score = "";
      if (s.package.description) {
        desc = escape(s.package.description);
      }
      if (s.score && s.score.final) {
        score = Math.round(Number(s.score.final) * 5);
        stars = "⭐".repeat(score) + "☆".repeat(5 - score);
      }
      if (s.flags) {
        Object.keys(s.flags).forEach((f) => {
          flags += `[<span style='color:#ff4d00'>⚑</span> ${escape(f)}] `;
        });
      }
      return createSuggestionItem(
        `
      <div>
        <style>.title>em { font-weight: bold; }</style>
        <div class="title">${s.highlight}</div>
        <div>
          <span style="font-size:1.5em;line-height:1em">${stars}</span>
          <span>${flags}</span>
        </div>
        <div>${desc}</div>
      </div>
    `,
        { url: s.package.links.npm }
      );
    })
);

// Docker Hub
addSearchAlias(
  "dh",
  "Docker Hub",
  "https://hub.docker.com/search/?q=",
  "s",
  "https://hub.docker.com/v2/search/repositories/?page_size=20&query=",
  (response) =>
    JSON.parse(response.text).results.map((s) => {
      let meta = "";
      let repo = s.repo_name;
      meta += `[⭐${escape(s.star_count)}] `;
      meta += `[↓${escape(s.pull_count)}] `;
      if (repo.indexOf("/") === -1) {
        repo = `_/${repo}`;
      }
      return createSuggestionItem(
        `
      <div>
        <div class="title"><strong>${escape(repo)}</strong></div>
        <div>${meta}</div>
        <div>${escape(s.short_description)}</div>
      </div>
    `,
        { url: `https://hub.docker.com/r/${repo}` }
      );
    })
);

// Amazon jp
addSearchAlias(
  "am",
  "Amazon",
  "https://www.amazon.co.jp/s?k=",
  "s",
  "https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=",
  (response) => JSON.parse(response.text)[1]
);

// Amazon jp Kindle
addSearchAlias(
  "k",
  "Amazon Kindle",
  "https://www.amazon.co.jp/s?i=digital-text&k=",
  "s",
  "https://completion.amazon.co.jp/search/complete?method=completion&search-alias=aps&mkt=6&q=",
  (response) => JSON.parse(response.text)[1]
);
mapkey("ok", "#8Open Search with alias k", function () {
  Front.openOmnibar({ type: "SearchEngine", extra: "k" });
});

// alc
addSearchAlias("a", "alc", "https://eow.alc.co.jp/search?q=");
mapkey("oa", "#8Open Search with alias a", function () {
  Front.openOmnibar({ type: "SearchEngine", extra: "a" });
});

// https://www.ncaq.net/2018/12/09/16/13/27/
mapkey("<Ctrl-g>", "google translate", () => {
  const selection = window.getSelection().toString();
  if (selection === "") {
    tabOpenLink(
      `http://translate.google.com/translate?u=${window.location.href}`
    );
  } else {
    tabOpenLink(`https://translate.google.com/?text=${encodeURI(selection)}`);
  }
});

Hints.style("font-size: 13pt;");
Hints.style("font-size: 13pt;", "text");

// --- Site-specific mappings ---//
const ri = { repeatIgnore: true };
const Hint =
  (selector, action = Hints.dispatchMouseClick) =>
  () =>
    Hints.create(selector, action);
const siteleader = ",";

function mapsitekey(domainRegex, key, desc, f, opts = {}) {
  const o = Object.assign(
    {},
    {
      leader: siteleader,
    },
    opts
  );
  mapkey(`${o.leader}${key}`, desc, f, { domain: domainRegex });
}

function mapsitekeys(d, maps, opts = {}) {
  const domain = d.replace(".", "\\.");
  const domainRegex = new RegExp(
    `^http(s)?://(([a-zA-Z0-9-_]+\\.)*)(${domain})(/.*)?`
  );
  maps.forEach((map) => {
    const [key, desc, f, subOpts = {}] = map;
    mapsitekey(domainRegex, key, desc, f, Object.assign({}, opts, subOpts));
  });
}

// --- Global mappings ---//
//  0: Help
//  1: Mouse Click
//  2: Scroll Page / Element
//  3: Tabs
//  4: Page Navigation
mapkey(
  "gI",
  "#4View image in new tab",
  Hint("img", (i) => tabOpenLink(i.src)),
  ri
);
//  5: Sessions
//  6: Search selected with
//  7: Clipboard
mapkey(
  "yI",
  "#7Copy Image URL",
  Hint("img", (i) => Clipboard.write(i.src)),
  ri
);

mapkey(";t", "#14google translate", () => {
  const selection = window.getSelection().toString();
  if (selection === "") {
    // 文字列選択してない場合はページ自体を翻訳にかける
    tabOpenLink(
      `http://translate.google.com/translate?u=${window.location.href}`
    );
  } else {
    // 選択している場合はそれを翻訳する
    tabOpenLink(
      `https://translate.google.com/?sl=auto&tl=ja&text=${encodeURI(selection)}`
    );
  }
});

mapkey(";b", "#14hatena bookmark", () => {
  const { location } = window;
  let url = location.href;
  if (location.href.startsWith("https://app.getpocket.com/read/")) {
    url = decodeURIComponent(
      document
        .querySelector("header a")
        .getAttribute("href")
        .replace("https://getpocket.com/redirect?url=", "")
    );
  }
  if (url.startsWith("http:")) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/${url.replace("http://", "")}`
    );
    return;
  }
  if (url.startsWith("https:")) {
    tabOpenBackground(
      `http://b.hatena.ne.jp/entry/s/${url.replace("https://", "")}`
    );
    return;
  }
  throw new Error("はてなブックマークに対応していないページ");
});

mapkey(";g", "#14魚拓", () => {
  tabOpenLink(`https://megalodon.jp/?url=${location.href}`);
});

// YouTube.
const ytFullscreen = () =>
  document.querySelector(".ytp-fullscreen-button.ytp-button").click();

mapsitekeys(
  "youtube.com",
  [
    ["A", "Open video", Hint("*[id='video-title']")],
    ["C", "Open channel", Hint("*[id='byline']")],
    [
      "gH",
      "Goto homepage",
      () =>
        window.location.assign(
          "https://www.youtube.com/feed/subscriptions?flow=2"
        ),
    ],
    ["F", "Toggle fullscreen", ytFullscreen],
    ["<Space>", "Play/pause", Hint(".ytp-play-button")],
  ],
  { leader: "" }
);

const copyTitleAndUrl = (format) => {
  const text = format
    .replace("%URL%", location.href)
    .replace("%TITLE%", document.title);
  Clipboard.write(text);
};
const copyHtmlLink = () => {
  const clipNode = document.createElement("a");
  const range = document.createRange();
  const sel = window.getSelection();
  clipNode.setAttribute("href", location.href);
  clipNode.innerText = document.title;
  document.body.appendChild(clipNode);
  range.selectNode(clipNode);
  sel.removeAllRanges();
  sel.addRange(range);
  document.execCommand("copy", false, null);
  document.body.removeChild(clipNode);
  Front.showBanner("Ritch Copied: " + document.title);
};

mapkey("cm", "#7Copy title and link to markdown", () => {
  copyTitleAndUrl("[%TITLE%](%URL%)");
});
mapkey("ct", "#7Copy title and link to textile", () => {
  copyTitleAndUrl('"%TITLE%":%URL%');
});
mapkey("ch", "#7Copy title and link to human readable", () => {
  copyTitleAndUrl("%TITLE% / %URL%");
});
mapkey("cb", "#7Copy title and link to scrapbox", () => {
  copyTitleAndUrl("[%TITLE% %URL%]");
});
mapkey("ca", "#7Copy title and link to href", () => {
  copyTitleAndUrl('<a href="%URL%">%TITLE%</a>');
});
mapkey("cp", "#7Copy title and link to plantuml", () => {
  copyTitleAndUrl("[[%URL% %TITLE%]]");
});
mapkey("cr", "#7Copy rich text link", () => {
  copyHtmlLink();
});
mapkey("co", "#7Copy title and link to org", () => {
  copyTitleAndUrl("[[%URL%][%TITLE%]]");
});

unmapAllExcept(
  ["E", "R", "T", "f", "F", "C", "x", "S", "H", "L", "cm"],
  /mail.google.com|twitter.com|feedly.com|i.doit.im|outlook.office.com/
);

// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 11pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;

// j/k scrolls in one step with size as 70, you could change it as below:
settings.smoothScroll = true;
settings.scrollStepSize = 140;
settings.hintAlign = "left";

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
var overlayedGlobalMarks = {
  "1": "https://mail.google.com/mail/u/0",
  "2": "http://www.google.com/calendar",
  "9": [
    "https://b.hatena.ne.jp",
    "https://qiita.com",
    "https://www.reddit.com/r/vim",
  ],
  "3": "https://www.google.com/contacts/#contacts",
  g: "https://plus.google.com/u/0/",
  r: "https://www.reddit.com/r/vim",
  m: "https://maps.google.com/",
  u: "https://www.youtube.com/feed/subscriptions",
  h: "https://github.com/",
  f: "https://www.facebook.com",
};

mapkey("gn", "#10Jump to vim-like mark in new tab.", function (mark) {
  var priorityURLs = overlayedGlobalMarks[mark];
  if (priorityURLs === undefined) {
    // fallback to Surfingkeys default jump
    Normal.jumpVIMark(mark, true);
    return;
  }
  if (typeof priorityURLs == typeof "") {
    priorityURLs = [priorityURLs];
  }
  for (var url of priorityURLs) {
    var markInfo = {
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
  var priorityURLs = overlayedGlobalMarks[mark];
  if (priorityURLs === undefined) {
    // fallback to Surfingkeys default jump
    Normal.jumpVIMark(mark, true);
    return;
  }
  if (typeof priorityURLs == typeof "") {
    priorityURLs = [priorityURLs];
  }
  for (var url of priorityURLs) {
    var markInfo = {
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

addSearchAlias("y", "youtube", "https://www.youtube.com/results?search_query=");
addSearchAlias("a", "Amazon", "http://www.amazon.co.jp/s/?field-keywords=");
addSearchAlias(
  "i",
  "Google Img",
  "https://www.google.com.ar/search?site=imghp&tbm=isch&source=hp&biw=1478&bih=740&q="
);
addSearchAlias("map", "Google Maps", "https://www.google.com.ar/maps/search/");

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

mapkey("yM", "Copy URL as markdown", () => {
  Clipboard.write(`[${document.title}](${window.location.href})`);
});

Hints.style("font-size: 13pt;");
Hints.style("font-size: 13pt;", "text");

// --- Site-specific mappings ---//
const Hint = (selector, action = Hints.dispatchMouseClick) => () =>
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

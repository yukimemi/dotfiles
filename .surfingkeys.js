// j/k scrolls in one step with size as 70, you could change it as below:
settings.smoothScroll = true;
settings.scrollStepSize = 140;

// an example to create a new mapping `ctrl-y`
mapkey('<Ctrl-y>', 'Show me the money', function() {
  Front.showPopup('a well-known phrase uttered by characters in the 1996 film Jerry Maguire (Escape to close).');
});

// an example to replace `T` with `gt`, click `Default mappings` to see how `T` works.
map('gt', 'T');

// an example to remove mapkey `Ctrl-i`
unmap('<Ctrl-i>');

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


const EXPORTED_SYMBOLS = ['sendKey'];

const KEY_CODES = {
  up: 38,
  down: 40
};

const EVENT_SEQUENCE = ['keydown', 'keypress', 'keyup'];

function sendKey(window, key) {
  EVENT_SEQUENCE.forEach(name => {
    let event = new window.KeyboardEvent(name, {
      keyCode: KEY_CODES[key]
    });
    window.document.activeElement.dispatchEvent(event);
  });
}

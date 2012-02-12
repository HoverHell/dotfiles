
require("clicks-in-new-buffer.js");
// Set to either OPEN_NEW_BUFFER or OPEN_NEW_BUFFER_BACKGROUND
clicks_in_new_buffer_target = OPEN_NEW_BUFFER_BACKGROUND;
// Set to 0 = left mouse, 1 = middle mouse, 2 = right mouse
clicks_in_new_buffer_button = 2;

// Keybinds.
define_key(content_buffer_normal_keymap, "a", "follow-new-buffer");
define_key(content_buffer_normal_keymap, "q", "follow-new-buffer-background");
define_key(content_buffer_normal_keymap, "C-w", "kill-current-buffer");
// ...
//define_key(content_buffer_normal_keymap, "A-r", "reload");
//define_key(content_buffer_normal_keymap, "r", null);


// for default download dir.
cwd = make_file('/home/hell/down');

// Sessions.
require("session.js");

interactive("toggle-stylesheets",
            "Toggle whether conkeror uses style sheets (CSS) for the " +
            "current buffer.  It is sometimes useful to turn off style " +
            "sheets when the web site makes obnoxious choices.",
            function(I) {
  var s = I.buffer.document.styleSheets;
  for (var i = 0; i < s.length; i++)
    s[i].disabled = !s[i].disabled;
});

interactive("ytv",
            "(Try to) grab the youtube video.",
            function(I) {
  var s = I.buffer.current_uri.spec;
  I.window.minibuffer.message(s);
});

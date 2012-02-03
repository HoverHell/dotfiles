define_webjump("youtube", "http://www.youtube.com/results?search_query=%s&search=Search");
define_webjump("youtube-user", "http://youtube.com/profile_videos?user=%s");
define_webjump("deviantart", "http://browse.deviantart.com/?q=%s", $alternative="http://www.deviantart.com");
define_webjump("flickr", "http://www.flickr.com/search/?q=%s", $alternative="http://www.flickr.com");
define_webjump("dictionary","http://www.thefreedictionary.com/%s");
define_webjump("trans", "http://translate.google.com/translate_t#auto|en|%s");
define_webjump("urban", "http://www.urbandictionary.com/define.php?term=%s");
define_webjump("thesaurus","http://www.thefreedictionary.com/%s#Thesaurus");
define_webjump("stackoverflow","http://stackoverflow.com/search?q=%s", $alternative="http://stackoverflow.com");
define_webjump("codesearch", "http://www.google.com/codesearch?q=%s");
define_webjump("wolframalpha", "http://www36.wolframalpha.com/input/?i=%s");
define_webjump("duckduckgo", "https://duckduckgo.com/?q=%s");
define_webjump("ddg", "https://duckduckgo.com/?q=%s");
define_webjump("github", "http://github.com/search?q=%s&type=Everything");

define_webjump("wayback", function (url) {
      if (url) {
          return "http://web.archive.org/web/*/" + url;
      } else {
          return "javascript:window.location.href='http://web.archive.org/web/*/'+window.location.href;";
      }
  }, $argument = "optional");

define_webjump(
    "tineye",
    function (term) {
        if (! term)
            return "http://www.tineye.com/";
        return load_spec(
            { uri: "http://www.tineye.com/search",
              post_data: make_post_data([['url', term]]) });
    },
    $argument = 'optional');

require("page-modes/wikipedia.js");
wikipedia_webjumps_format = "wp-%s"; // controls the names of the webjumps.  default is "wikipedia-%s".
define_wikipedia_webjumps("en", "ru"); // For English, German and French.
// define_wikipedia_webjumps(); // To make use of ALL of the webjumps (200+).

define_webjump("multitran", "http://multitran.ru/c/m.exe?CL=1&s=%s&l1=1");  // multitran
define_webjump("mt", "http://multitran.ru/c/m.exe?CL=1&s=%s&l1=1");  // multitran
define_webjump("yandex", "http://yandex.ru/yandsearch?text=%s&lr=44");  // yandex
define_webjump("ya", "http://yandex.ru/yandsearch?text=%s&lr=44");  // yandex

#!/usr/bin/env python
# coding: utf8
## The Python Way

import json
import sys


def colorize(text):
    from pygments import highlight
    from pygments.lexers import JsonLexer
    from pygments.formatters import TerminalFormatter
    lexer = JsonLexer()
    return highlight(text, lexer, TerminalFormatter())


def try_colorize(text, **kwa):
    try:
        return colorize(text, **kwa)
    except Exception as exc:
        sys.stderr.write("Error colorising: %r\n" % (exc,))
        return text


def main(ar, indent=2):
    if ar and ar[0].isdigit():
        indent = int(ar.pop(0))
    di = sys.stdin.read()
    try:
        dd = json.loads(di)
    except ValueError as e:
        sys.stderr.write("  -!!---- %s\n" % (e,))
        sys.stdout.write(di)
        return 13
    do = json.dumps(dd, indent=indent, sort_keys=True)

    ## Have to do the coloring before the unicoding
    if '-c' in sys.argv or '--color' in sys.argv:
        do = try_colorize(do)

    if isinstance(do, unicode):
        do = do.encode('utf-8')
    try:
        do = re.sub(
            r'((\\u[0-9a-z]{4})+)',
            lambda m: m.group(0).decode('unicode-escape').encode('utf-8'),
            do)
    except Exception as e:
        pass
    sys.stdout.write(do)
    sys.stdout.write("\n")


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))


# ## The jq way
# # Cons: no key sorting, no output if not json
# # Pros: coloring
# #!/bin/sh
# exec jq . "$@"

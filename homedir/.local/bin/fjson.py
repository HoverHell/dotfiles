#!/usr/bin/env python3

import json
import re
import sys


def colorize(text):
    from pygments import highlight
    from pygments.formatters import TerminalFormatter
    from pygments.lexers import JsonLexer

    lexer = JsonLexer()
    return highlight(text, lexer, TerminalFormatter())


def try_colorize(text, **kwa):
    try:
        return colorize(text, **kwa)
    except Exception as exc:
        sys.stderr.write(f"Error colorizing: {exc!r}\n")
        return text


def main(ar, indent=2):
    if ar and ar[0].isdigit():
        indent = int(ar.pop(0))
    in_ = sys.stdin
    in_ = getattr(in_, "buffer", in_)
    out_ = sys.stdout
    out_ = getattr(out_, "buffer", out_)

    di = in_.read()
    try:
        dd = json.loads(di)
    except ValueError as exc:
        sys.stderr.write(f"  -!!---- {exc}\n")
        out_.write(di)
        return 13
    do = json.dumps(dd, indent=indent, sort_keys=True)

    # Have to do the coloring before the unicoding
    if "-c" in sys.argv or "--color" in sys.argv:
        do = try_colorize(do)

    if isinstance(do, str):
        do = do.encode("utf-8")
    try:
        do = re.sub(
            r"((\\u[0-9a-z]{4})+)",
            lambda m: m.group(0).decode("unicode-escape").encode("utf-8"),
            do,
        )
    except Exception:
        pass
    out_.write(do)
    out_.write(b"\n")


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))


# ## The jq way
# # Cons: no key sorting, no output if not json
# # Pros: faster, more coloring
# #!/bin/sh
# exec jq . "$@"

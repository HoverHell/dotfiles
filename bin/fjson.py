#!/usr/bin/env python
# coding: utf8

import json
import sys

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
    try:
        do = do.decode('unicode-escape').encode('utf-8')
    except Exception as e:
        pass
    sys.stdout.write(do)
    sys.stdout.write("\n")


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))

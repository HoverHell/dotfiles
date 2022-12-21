#!/usr/bin/env python3

import re
import sys


def main():
    head = sys.stdin.readline()
    input_lines = sys.stdin
    head_parts = re.findall(r"([^ ]+ +)", head)
    head_parts_out = head_parts + ["???"]  # will be used if some line is longer

    def _splitparts(line, head_parts=head_parts):
        pos = 0
        for head_part in head_parts:
            yield line[pos : pos + len(head_part)]
            pos += len(head_part)
        # In case the line was longer:
        last = line[pos:]
        if last:
            yield last

    def _write_out(val):
        try:
            sys.stdout.write(val)
            sys.stdout.write("\n")
            sys.stdout.flush()
        except IOError:
            sys.exit()

    for line in input_lines:
        line = line.strip("\n\r")
        if not line.strip():
            _write_out("")
            continue
        assert abs(len(line) - len(head)) < 10, repr(line)  # at least approximate
        line_parts = list(_splitparts(line))

        def _postprocess(val):
            res = str(val)
            res = res.strip()
            res = res.replace("\\", r"\\").replace("\t", r"\t")
            return res

        out = "\t".join(
            "%s=%s" % (_postprocess(name), _postprocess(val)) for name, val in zip(head_parts_out, line_parts)
        )
        _write_out(out)


if __name__ == "__main__":
    main()

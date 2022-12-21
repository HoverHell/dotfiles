#!/usr/bin/env python3

import re
import subprocess
import sys


def to_text(value):
    if isinstance(value, bytes):
        return value.decode("utf-8")
    return value


def from_cmd(*args, timeout=99):
    result = subprocess.check_output(args, timeout=timeout)
    result = to_text(result)
    return result


def main():
    current = from_cmd("uname", "-r")
    current = current.strip().rsplit("-", 1)[0]

    lst = from_cmd(
        rb"dpkg-query",
        rb"-W",
        rb"-f=${db:Status-Abbrev}\t${binary:Package}\t${Version}\n",
        rb"linux-*",
    )
    lst = lst.splitlines()
    lst = (item.strip("\n") for item in lst)
    lst = (item.split("\t") for item in lst)
    columns = ("status", "name", "version")
    lst = (dict(zip(columns, item)) for item in lst)
    lst = (item for item in lst if item["status"] == "ii ")
    lst = (item for item in lst if re.search(r"^linux-([a-z]+-)+[0-9]", item["name"]))
    lst = list(lst)
    versions = sorted(
        list(item["version"].rsplit(".", 1)[0] for item in lst if re.search("^linux-image-[0-9]", item["name"]))
    )
    latest = versions[-1]
    removable = sorted(
        list(
            item["name"]
            for item in lst
            if not item["version"].startswith(current) and not item["version"].startswith(latest)
        )
    )
    print(dict(current=current, latest=latest, removable=removable), file=sys.stderr)
    assert len(removable) < len(lst) / 2 + 1
    print("\n".join(removable))
    if removable:
        subprocess.check_call("apt", "remove", "-y", *removable)


if __name__ == "__main__":
    main()

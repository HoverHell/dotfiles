#!/usr/bin/env python3

import sys

LATINS = r"qwertyuiop[]asdfghjkl;'zxcvbnm,./"
CYRILLICS = "йцукенгшщзхъфывапролджэячсмитьбю."
LATIN_TO_CYRILLIC = {latin: cyrillic for latin, cyrillic in zip(LATINS, CYRILLICS)}
CYRILLIC_TO_LATIN = {cyrillic: latin for latin, cyrillic in zip(LATINS, CYRILLICS)}
# Can be merged into one since they aren't intersecting:
conversion = {**LATIN_TO_CYRILLIC, **CYRILLIC_TO_LATIN}


def main():
    while True:
        data = sys.stdin.readline()
        if not data:
            break

        result = "".join(conversion.get(char, char) for char in data)
        sys.stdout.write(result.strip())
        sys.stdout.write("\n")


if __name__ == "__main__":
    main()

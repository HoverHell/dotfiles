#!/usr/bin/env python
# -*- coding: utf8

import sys
from six import text_type

latins = r"qwertyuiop[]asdfghjkl;'zxcvbnm,./"
cyrillics = u"йцукенгшщзхъфывапролджэячсмитьбю."
latin_to_cyrillic = {
    latin: cyrillic
    for latin, cyrillic in zip(latins, cyrillics)}
cyrillic_to_latin = {
    cyrillic: latin
    for latin, cyrillic in zip(latins, cyrillics)}
# Can be merged into one since they aren't intersecting:
conversion = dict(latin_to_cyrillic)
conversion.update(cyrillic_to_latin)


while True:
    data = sys.stdin.readline()
    if not data:
        break

    if not isinstance(data, text_type):
        data = data.decode('utf-8', errors='replace')

    result = "".join(
        conversion.get(char, char)
        for char in data)
    print(result.strip())

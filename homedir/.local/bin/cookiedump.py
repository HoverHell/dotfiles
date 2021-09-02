#!/usr/bin/env python3
"""
Dump firefox cookies to a cookiejar,
for `requests` or `youtube-dl` or such.

Commandline arguments:
  * Firefox's `cookies.sqlite` file path.
  * Output filename.
  * Optional: regex to filter the domains.
"""

import re
import sys
import sqlite3
import http.cookiejar as cookielib
# import requests
# from requests.utils import dict_from_cookiejar


MOZ_COLUMNS = 'host path isSecure expiry name value'.strip().split()
MOZ_SQL = 'select {cols} from moz_cookies'.format(cols=', '.join(MOZ_COLUMNS))

def get_firefox_cookies(filename):
    with sqlite3.connect(filename) as conn:
        for row in conn.execute(MOZ_SQL).fetchall():
            row = dict(zip(MOZ_COLUMNS, row))
            cookie = cookielib.Cookie(
                version=0,
                name=row['name'],
                value=row['value'],
                port=None,
                port_specified=False,
                domain=row['host'],
                domain_specified=row['host'].startswith('.'),
                domain_initial_dot=row['host'].startswith('.'),
                path=row['path'],
                path_specified=False,
                secure=row['isSecure'],
                expires=row['expiry'],
                discard=row['expiry'] == '',
                comment=None,
                comment_url=None,
                rest={},
            )
            yield cookie


def get_cookiejar(cookies, cls=cookielib.MozillaCookieJar):
    cjar = cls()
    for cookie in cookies:
        cjar.set_cookie(cookie)
    return cjar


def main():
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    try:
        domain_regex = sys.argv[3]
    except IndexError:
        domain_regex = None
    cookies = get_firefox_cookies(input_file)
    if domain_regex is not None:
        cookies = (
            cookie for cookie in cookies
            if re.search(domain_regex, cookie.domain)
        )
    cjar = get_cookiejar(cookies)
    cjar.save(output_file)


if __name__ == '__main__':
    main()

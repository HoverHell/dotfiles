#!/usr/bin/env python
# -*- coding: utf8

import sys

a=r"qwertyuiop[]asdfghjkl;'zxcvbnm,./"
b=u"йцукенгшщзхъфывапролджэячсмитьбю."
adic={}
for i in range(len(a)):
    adic[a[i]]=b[i]
bdic={}
for i in range(len(b)):
    bdic[b[i]]=a[i]
  

while True: 
    s=sys.stdin.readline()
    if not s:
      break
    
    s = unicode(s, 'utf-8', errors='replace')
    #print("in: %s" % s)

    r=""
    for i in range(len(s)):
        try:
            r+=adic[s[i]]
        except KeyError:
            try:
                r+=bdic[s[i]]
            except KeyError:
                r+=s[i]

    #print("out: %s" % r)
    print(r.strip())

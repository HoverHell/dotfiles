#!/usr/bin/env python

# http://code.activestate.com/recipes/252508-file-unzip/

""" 
unzip.py
Version: 1.1
Extract a zipfile to the directory provided

It first creates the directory structure to house the files then it extracts
the files to it.

Sample usage, command line:
    unzip.py -p 10 -z c:\testfile.zip -o c:\testoutput

Python class:
    import unzip
    un = unzip.unzip()
    un.extract(r'c:\testfile.zip', r'c:\testoutput')

By Doug Tolton
"""

"""
Hacked with stuff from
http://unknowngenius.com/blog/archives/2011/11/04/recovering-japanese-filenames-from-zip-archives-on-os-x/
"""

import sys
import zipfile
import os
import os.path
import getopt
import re

class unzip:
    def __init__(self, verbose = False, percent = 10, encoding='sjis'):
        self.verbose = verbose
        self.percent = percent
        self.encoding = encoding

    def extract(self, file, dir):
        if not dir.endswith(':') and not os.path.exists(dir):
            os.mkdir(dir)

        zf = zipfile.ZipFile(file)

        # create directory structure to house files
        self._createstructure(file, dir)

        num_files = len(zf.namelist())
        percent = self.percent
        divisions = 100 / percent
        perc = int(num_files / divisions)

        # extract files to directory structure
        for i, name_src in enumerate(zf.namelist()):

            name = unicode(name_src, self.encoding)  # N: encoding.

            if self.verbose == True:
                print "Extracting %s" % name
            elif perc > 0 and (i % perc) == 0 and i > 0:
                complete = int (i / perc) * percent
                print "%s%% complete" % complete

            if not name.endswith('/'):
                outfile = open(os.path.join(dir, name), 'wb')
                outfile.write(zf.read(name_src))
                outfile.flush()
                outfile.close()


    def _createstructure(self, file, dir):
        self._makedirs(self._listdirs(file), dir)


    def _makedirs(self, directories, basedir):
        """ Create any directories that don't currently exist """
        for dir in directories:
            curdir = os.path.join(basedir, dir)
            if not os.path.exists(curdir):
                if self.verbose == True:
                    print "Creating %s" % curdir
                os.makedirs(curdir)

    def _listdirs(self, file):
        """ Grabs all the directories in the zip structure
        This is necessary to create the structure before trying
        to extract the file to it. """
        zf = zipfile.ZipFile(file)

        dirs = []

        for name_src in zf.namelist():
            name = unicode(name_src, self.encoding)  # N: encoding.
            #if name.endswith('/'):
            #    dirs.append(name)
            ## Unfortunately, in some zip files directories are not listed
            ## separately. So add dirname from anything with a slash.
            if name.count('/'):
                dirs.append(re.sub(r'/[^/]*$', '/', name))

        dirs.sort()
        return dirs

def usage():
    print """usage: unzip.py -z <zipfile> -o <targetdir>
    <zipfile> is the source zipfile to extract
    <targetdir> is the target destination

    -z zipfile to extract
    -o target location
    -p sets the percentage notification
    -v sets the extraction to verbose (overrides -p)

    long options also work:
    --verbose
    --percent=10
    --zipfile=<zipfile>
    --outdir=<targetdir>"""
    

def main():
    shortargs = 'vhp:z:o:'
    longargs = ['verbose', 'help', 'percent=', 'zipfile=', 'outdir=']

    unzipper = unzip()

    try:
        opts, args = getopt.getopt(sys.argv[1:], shortargs, longargs)
    except getopt.GetoptError:
        usage()
        sys.exit(2)

    zipsource = ""
    zipdest = ""

    for o, a in opts:
        if o in ("-v", "--verbose"):
            unzipper.verbose = True
        if o in ("-p", "--percent"):
            if not unzipper.verbose == True:
                unzipper.percent = int(a)
        if o in ("-z", "--zipfile"):
            zipsource = a
        if o in ("-o", "--outdir"):
            zipdest = a
        if o in ("-h", "--help"):
            usage()
            sys.exit()

    if zipsource == "" or zipdest == "":
        usage()
        sys.exit()
            
    unzipper.extract(zipsource, zipdest)

if __name__ == '__main__':
  main()

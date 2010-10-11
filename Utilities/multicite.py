#!/usr/bin/env python
# encoding: utf-8

"""
Alters sequential instances of \autocite{} into a single instance of
\autocite{}, with the contents of subsequent instances inserted into the new
"parent"

Example:
before: \autocite[1]{Kidd:1988aa}\autocite[2]{Adams:1988aa}
after: \autocite[1]{Kidd:1988aa}[2]{Adams:1988aa}

Takes exactly one file as input with the -f flag, processes it, and outputs it
This cleanup is no longer strictly necessary when using the biblatex package
(and packages which derive from it) which ships with TeX live 2010.
"""

import sys
import re
import argparse

# define command-line arguments
try:
    parser = argparse.ArgumentParser\
    (description='Fix multiple autocite instances')
    parser.add_argument("-file", metavar = "filename",
    help = "the full path to a text file", required = True,
    type = argparse.FileType("r",0))
    fromcl = parser.parse_args()
except IOError:
    print 'Couldn\'t open specified file!'
    raise

def fix_cites(fname = None):
    """
    Tidy citations using regex and a devious list comprehension
    """
    print 'Processing citations in %s' % fname.name
    try:
        with fname:
            lines = [line for line in fname]
    except IOError:
        print 'Can\'t read from file %s' % fname.name
    nc = []
    comp = re.compile(r'\\(auto)?cite')
    for l in lines:
        if comp.search(l):
            s = l.split('\\autocite')
            nc.append('%s\\autocite%s' % (s[0], ''.join(s[1:])))
        else:
            nc.append(l)
    try:
        with open(fname.name, 'w') as f:
            for out_line in nc:
                f.write(out_line)
    except IOError:
        print 'Can\'t write to file %s' % fname.name
        raise
    print 'Done. Processed %s line(s)' % len(nc)


def main():
    """ main function.
    """
    fix_cites(fromcl.file)


if __name__ == "__main__":
    try:
        main()
    except (KeyboardInterrupt, SystemExit):
        # actually raise these so it exits cleanly
        raise
    except Exception, error:
        # all other exceptions, so display the error
        print error
    else:
        pass
    finally:
        # exit cleanly once we've done everything else
        sys.exit(0)

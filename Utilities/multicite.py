#!/usr/bin/env python
# encoding: utf-8

"""
Alters sequential instances of \autocite{} into a single instance of \autocites{}, with the contents of subsequent instances inserted into the new "parent"

Example:
before: \autocite[1]{Kidd:1988aa}\autocite[2]{Adams:1988aa}
after: \autocites[1]{Kidd:1988aa}[2]{Adams:1988aa}

Takes one file as input, processes it, and outputs it
"""

import sys
import re
import argparse
import logging
import traceback

# define command-line arguments
parser = argparse.ArgumentParser\
(description='Fix multiple autocite instances')
parser.add_argument("-file", metavar = "filename",
help = "the full path to a text file", required = True,
type = argparse.FileType("r",0))
fromcl = parser.parse_args()


def fix_cites(fname = None):
    """
    Fix citations using regex and a devious list comprehension
    """
    try:
        with fname:
            lines = [line for line in fname]
    except IOError:
        raise
    nc = []
    comp = re.compile(r'\\autocite')
    for l in lines:
        if comp.search(l):
            s = l.split('\\autocite')
            nc.append('%s\\autocite%s' % (s[0], ''.join(s[1:])))
        else:
            nc.append(l)
    with open(fname.name, 'w') as f:
        for out_line in nc:
            f.write(out_line)

def main():
    """ main function.
    """
print "Processing citations"
fix_cites(fromcl.file)
print "Finished processing citations"


if __name__ == "__main__":
    try:
        main()
    except (KeyboardInterrupt, SystemExit):
        # actually raise these so it exits cleanly
        raise
    except Exception, error:
        # all other exceptions, so display the error
        print "Stack trace:\n", traceback.print_exc(file = sys.stdout)
    else:
        pass
    finally:
        # exit cleanly once we've done everything else
        sys.exit(0)

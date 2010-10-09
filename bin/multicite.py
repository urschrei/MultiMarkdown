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

# logging stuff
logging.basicConfig(level=logging.DEBUG,
format='%(asctime)s %(levelname)s %(message)s',
datefmt='%a, %d %b %Y %H:%M:%S',
filename='multicite.log',
filemode='a')

# define command-line arguments
parser = argparse.ArgumentParser\
(description='Fix multiple autocite instances')
parser.add_argument("-file", metavar = "filename",
help = "the full path to a text file", required = True,
type = argparse.FileType("r",0))
fromcl = parser.parse_args()


def fix_cites(fname = None):
    """
    Fix citations using regex
    """
    try:
        with fname:
            lines = [line for line in fname]
    except IOError:
        logging.critical("Couldn't read from file %s. exiting", fname)
        raise
    #expression will end in {2,} to match one or more subsequent occurrences
    m = re.compile(r"(\[[a-zA-Z]+\][{]?[a-zA-Z].:[\d].[}])")
    for l in lines:
       print m.findall(l)
    sys.exit()

fix_cites(fromcl.file)

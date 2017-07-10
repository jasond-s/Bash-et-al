#!/usr/bin/python

import sys
import os
import glob

def preferHead(filePatterns):

	filePaths = []

	for file in filePatterns:	
		filePaths = filePaths + glob.glob(file)

	for file in filePaths:
		lines = []
		head = 0
		write = True

		with open(file, 'r') as filer:
			for line in filer.readlines():

				if '<<<<<<< HEAD' in line:
					write = True
					continue

				if '=======' in line:
					write = False

				if '>>>>>>>' in line:
					write = True
					continue

				if write:
					lines.append(line)

			print str("".join(lines))

		with open(file, 'w+') as filew:
			for item in lines:
  				filew.write("%s" % item)


if __name__ == '__main__':
	
	preferHead(sys.argv[1::]);
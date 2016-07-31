#!/usr/bin/python
import subprocess
import os
import getpass
import sys
import json
# Get Limnoria & install it
# you will need to install hashweb.org before running this
os.chdir('../');
if not os.path.exists('Limnoria'):
	print('Grabbing dependancy Limnoria...')
	subprocess.call(['git', 'clone', 'git://github.com/ProgVal/Limnoria.git']);
os.chdir('Limnoria');
subprocess.call(['pip3', 'install', '-r', 'requirements.txt'])
subprocess.call(['python3', 'setup.py', 'install'])
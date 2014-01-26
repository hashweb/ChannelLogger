#!/usr/bin/python
import subprocess
import os
import getpass
import sys
import json
# Postgresql needs to be install
# libpq-dev and python-dev needs to be installed for psycopg2
if not os.path.exists('config.json'):
	print "First a config file needs to be created......"
	userName = raw_input('Please enter your user name (pref your OS username): ')
	userPass = getpass.getpass('Please enter your password for the Postgresql database (won\'t echo)');
	with open('config.json', 'w') as configFile:
		configText = """
{
	"db": {
		"host": "127.0.0.1",
		"dbname": "logs_stats",
		"user": "%s",
		"password": "%s"
	}
}
	""" % (userName, userPass, userName)
		configFile.write(configText)
	confirm = raw_input("Are you running this script from the host machine? yes/no: ")
	if (confirm == "yes"):
		print "Run again from guest"
		sys.exit();

# open the config file
with open('config.json', 'r') as configFile:
	data = json.loads(configFile.read());

userName = data['db']['user']
userPass = data['db']['password']

subprocess.call(['apt-get', 'install', '-y', 'postgresql', 'libpq-dev', 'python-dev', 'python-pip'])
subprocess.call(['pip', 'install', 'psycopg2'])

os.system('echo "CREATE ROLE %s LOGIN ENCRYPTED PASSWORD \'%s\';" | sudo -u postgres psql' % (userName, userPass))
os.system('echo "CREATE DATABASE logs_stats OWNER %s;" | sudo -u postgres psql' % userName)
os.system('sudo -u postgres psql logs_stats < logs_stats.sql')

os.system('echo "ALTER TABLE messages OWNER TO %s;" | sudo -u postgres psql logs_stats' % userName)
os.system('echo "ALTER TABLE messages_id_seq OWNER TO %s;" | sudo -u postgres psql logs_stats' % userName)
os.system('echo "ALTER TYPE action OWNER TO %s;" | sudo -u postgres psql logs_stats' % userName)
os.system('echo "ALTER TABLE users OWNER TO %s;" | sudo -u postgres psql logs_stats' % userName)
os.system('echo "ALTER TABLE users_id_seq OWNER TO %s;" | sudo -u postgres psql logs_stats' % userName)
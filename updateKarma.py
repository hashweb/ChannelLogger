#!/usr/bin/python
import json
import sys
import re
import time
import os

import psycopg2

class KarmaUpdater:

	def __init__(self):
		# Will only work on UNIX
		if (hasattr(time, 'tzset')):
			os.environ['TZ'] = 'Europe/London'
			time.tzset()

		# DB connection string
		try:
			with open('config.json') as data:
				config = json.load(data)

			conn_string = "host='%s' dbname='%s' user='%s' password='%s'" % (config['db']['host'], config['db']['dbname'], config['db']['user'], config['db']['password'])
		except IOError as e:
			print os.getcwd()
			sys.exit("Error! No config file supplied, please create a config.json file in the root")

		# Print connection string
		print "Connecting to database\n -> %s" % (conn_string)

		# get a connection
		conn = psycopg2.connect(conn_string)
		# conn.curser will return a cursor object, you can use this to perform queries
		self.cursor = conn.cursor()
		self.conn = conn
		print "connected!\n"


	def init(self):
		self.get_thanks()
		print 'finished!'
		

	def get_thanks(self):
		self.cursor.execute("select * from messages where content ~* 'thanks \w' OR content ~* 'cheers \w' OR content ~* '\+1 \w' OR content ~* '\w\+\+'")
		print self.cursor.rowcount
		for record in self.cursor.fetchall():
			message = record[2]
			# parse out the name using regex from thank you messages
			for i in re.finditer(r'thanks (\w+)(,:)?|(\w+)(,:)? thanks|cheers (\w+)(,:)?|(\w+)(,:)? cheers|(\w+)(,:\s)?\+\+|(\w+)(,:\s)? \+1', message):
				if (filter(None, i.groups())):
					user = filter(None, i.groups())[0]
					if user is not "ok": # small hack for now to stop ok getting karma points
						userID = self.is_user(user)
						if userID:
							print "giving karma to " + user
							self.give_karma(userID)


	def give_karma(self, userID):
		self.cursor.execute("update users set karma = karma + 1 where users.id = %s", (userID, ))
		self.conn.commit()


	# returning a username would be too ambiguous, as 1 username can have plenty of hostnames,
	# instead return an ID to the most recent use of that username for a more accurate match
	# By filtering on message.action = message it means we get users who have actually spoken in the channel, and not random users who have names like 'a' or 'and'/'for' and have never spoke
	def is_user(self, username):
		self.cursor.execute("select users.id from users INNER JOIN messages ON (messages.user = users.id) where users.user IlIKE %s AND messages.action = 'message' ORDER BY messages.timestamp DESC LIMIT 1;", (username,))
		if self.cursor.rowcount:
			return self.cursor.fetchone()[0]
		else:
			return False


karmaTool = KarmaUpdater()
karmaTool.init()

LogsToDB
=========
Version
----
0.0.1

Tech
-----------

This is built as a plugin for Limnoria, to use it it's best you git pull this repository into the plugins directory of your bot.

This plugin also relies on a postgres database running, you can set one up yourself by running the setup.py file

Dependancies
-----------

* *postgresql* - The live VPS is running postgreSQL 9.1 so it would work out better to have a similar version running
* *pip* - package manager for Python
* *libpq-dev* - for psycopg2
* *python-dev* - for psycopg2
* *psycopg2* - pip install psycopg2  

Setup
----

Set up a database in the Postgres, then run the logs_stats.sql inside so that it is populated (you will need to sort out permissions).

Once this is done you should be able to run a local version of the bot.

As it stands we try to keep all features in this plugin so everything is self contained

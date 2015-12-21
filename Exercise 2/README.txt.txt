The code within here works as is.

unzip the Exercise 2 portion of my github wherever you like (e.g. /root)

wget https://github.com/RicardoFrank/W205/archive/master.zip
unzip master.zip
cd W205-master/
mv Exercise\ 2 /root/ex2
cd /root/ex2

Prerequisites:

PostGreSQL (do before upgrading to Python 2.7.  If 2.7 is up, revert to 2.6.6)
	
	yum install postgresql postgresql-server postgresql-jdbc

Python 2.7 (do this after installing PostGreSQL since yum breaks with Python2.7)
	
	sudo yum install python27-devel –y 
	mv /usr/bin/python /usr/bin/python266
	ln -s /usr/bin/python2.7 /usr/bin/python 
	/usr/bin/python --version

Storm is setup
	
	storm version

Ez_setup is installed
	
	sudo curl -o ez_setup.py https://bootstrap.pypa.io/ez_setup.py
	sudo python ez_setup.py 
	sudo /usr/bin/easy_install-2.7 pip

Virtualenv is installed
	
	sudo pip install virtualenv 

Lein is installed
	
	wget --directory-prefix=/usr/bin/ https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
	ls -l /usr/bin/lein

Install Streamparse
	
	pip install streamparse

Install Tweepy
	
	pip install tweepy

Install psycopg2
	
	pip install psycopg2


SETUP POSTGRESQL PROPERLY

First mount your data directory:

	mount -t ext3 /dev/<attached volume location> /data

Next, make sure	the top-level data directory is	open to	all users:

	chmod a+rwx /data

Ensure that postgres is	installed:

	yum install postgresql postgresql-server postgresql-jdbc

Create a directory and database	files for postgres:

	mkdir /data/pgsql

	mkdir /data/pgsql/data

	mkdir /data/pgsql/logs

	chown -R postgres /data/pgsql

	su postgres

	initdb -D /data/pgsql/data

Edit the /data/pgsql/postgresql.conf file as follows:

Change

	#listen_addresses = 'localhost'
	to	
	listen_addresses = ‘*’

Change	


	#standard_conforming_strings = off
	to
	standard_conforming_strings = off

Edit the /data/pgsql/pg_hba.conf file.		

At the end of the file add the following line:

	host all all 0.0.0.0 0.0.0.0 md5

Start the DB (from terminal

	cd /data

	sudo -u postgres pg_ctl -D /data/pgsql/data -l

	/data/pgsql/logs/pgsql.log start

	sudo -u postgres psql

Create the DB Tcount (while logged into DB)

	CREATE USER postgres WITH PASSWORD 'pass';
	CREATE DATABASE Tcount;
	ALTER DATABASE Tcount OWNER TO postgres;
	GRANT ALL ON DATABASE Tcount TO	postgres;

Confirm DB is made and you can login (from terminal)

	psql –U postgres -d Tcount

Run SetupTweetwordcountTable.py to create table in Tcount with word and count fields

To summarize the above

	1. mount PostGreSQL DB to a directory with sufficient space.  use "/data"
	2. create a DB named Tcount with username "postgresql" and password "pass"
	3. ensure PostGreSQL DB is accepting connections to port 5432 from localhost
	4. create a table named Tweetwordcount in Tcount DB

Run files:

	cd /root/ex2/
	python SetupTweetwordcountTable.py
	cd /root/ex2/exercise_2/tweetwordcount
	streamparse run

	 cd /root/ex2/exercise_2/scripts/
	python finalresults.py
	python finalresults.py the
	python histogram.py  1 2

Please note, if you get an error regarding 'Parse' or "Wordcount" module, the bolt file captilization may be incorrect.  If Tcount table isn't found, please lower-case to tcount (I tested these files after fixing but maybe I botched it like last time).

tweetwordcount does the following:

1. Read Twitter stream data
2. Parse stream data
3. Count word occurence
4. Update / insert values into PostGreSQL DB Tcount and table Tweetwordcount

finalresults.py takes in 1 or 0 arguments:

1. no args will prints all words and counts in ascending word order
2. entering a word of interest prints the count of the word of interest with nothing shown if the word isn't in the DB

histogram.py takes in 2 arguments and returns all words that have counts between the first and second arg
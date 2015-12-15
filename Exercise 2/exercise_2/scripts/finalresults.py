import psycopg2
import sys

hasInput = False

for arg in sys.argv:
        if arg != 'finalresults.py':
                hasInput = True

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()
cur.execute("SELECT word, count from Tweetwordcount ORDER BY word ASC")
records = cur.fetchall()

if hasInput:
        for rec in records:
                if rec[0] == arg:
                        print "Total number of occurences of", rec[0], ": ", rec[1], "\n"

else:
        for rec in records:
                print "Total number of occurences of", rec[0], ": ", rec[1], "\n"
                conn.close()
import psycopg2
import sys

#hasInput = False

#for arg in sys.argv:
#       if arg != 'finalresults.py':
#               hasInput = True

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

if len(sys.argv) == 3:
        k1 = sys.argv[1]
        k2 = sys.argv[2]

        if k1 > k2:
                 print "k2 must be less than or equal to k1"

        else:
                cur = conn.cursor()
                cur.execute("SELECT word, count from Tweetwordcount ORDER BY word ASC")
                records = cur.fetchall()


                for rec in records:
                        #if rec[1] >= k1 and rec[1] <= k2:
                        if int(rec[1]) >= int(k1):
                                print "Total number of occurences of", rec[0], ": ", rec[1], "\n"
        conn.close()
else:
        print "Please provide k1 and k2 as arguments"

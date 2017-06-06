%matplotlib 
import psycopg2
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import datetime

conn = psycopg2.connect('dbname=info1903 user=lyneca')
cur = conn.cursor()

query = """
select rainfall, fatalities                            
  from crashes, rainfall                                                
 where rainfall.year = crashes.year                                      
   and rainfall.month = extract(MONTH from to_date(concat(crashes.month, ' 2000'), 'Month YYYY'))                                                
   and rainfall.day = crashes.day
   and rainfall.rainfall is not null
   and crashes.fatalities is not null;
"""
# and crashes.state = 'VIC'
conn.rollback()
cur.execute(query)
data = cur.fetchall()
data = sorted(data, key=lambda x: (x[0],x[1]))
rainfall = sorted(list({x[0] for x in data if x[0] > 0}))
fatalities = []
for r in rainfall:
    temp = 0
    for d in data:
        if d[0] == r:
            if d[1] is not None:
                temp += d[1]
    fatalities.append(temp)
# fatalities = [x[1] for x in data if x[0] > 0]
# fig = plt.figure()
# ax1 = fig.add_subplot(111,projection='3d')
plt.scatter(rainfall, fatalities)

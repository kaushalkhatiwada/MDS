#pip install mysql-connector-python 

import mysql.connector

kkdb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Admin@123#",
    port =3303
)
query = kkdb.cursor()

query.execute("SHOW DATABASES")
for x in query:
  print(x)
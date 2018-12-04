import pymssql

conn = pymssql.connect(server='(local)', database='cia_factbook_db') # change server name (local) and database name
conn.autocommit(True)
cursor = conn.cursor()

# create database
cursor.execute("""
CREATE DATABASE SeventhDB;
""")
conn.autocommit(False)

# create table
cursor.execute("""
USE SeventhDB;

IF OBJECT_ID('persons', 'U') IS NOT NULL
    DROP TABLE persons
CREATE TABLE persons (
    id INT NOT NULL,
    name VARCHAR(100),
    salesrep VARCHAR(100),
    PRIMARY KEY(id)
);
""")

# insert data to a table
cursor.executemany(
    "INSERT INTO persons VALUES (%d, %s, %s)",
    [(1, 'John Smith', 'John Doe'),
     (2, 'Jane Doe', 'Joe Dog'),
     (3, 'Mike T.', 'Sarah H.')])
# you must call commit() to persist your data if you don't set autocommit to True
conn.commit()

# select a data from a table;
cursor.execute('SELECT * FROM persons WHERE salesrep=%s', 'John Doe')
row = cursor.fetchone()
while row:
    print("ID=%d, Name=%s" % (row[0], row[1]))
    row = cursor.fetchone()

# finally, close connection
conn.close()
## Fiftyville
Write SQL queries to solve a mystery.

# A Mystery in Fiftyville
The CS50 Duck has been stolen! The town of Fiftyville has called upon you to solve the mystery of the stolen duck. Authorities believe 
that the thief stole the duck and then, shortly afterwards, took a flight out of town with the help of an accomplice. Your goal is to identify:

Who the thief is,
What city the thief escaped to, and
Who the thief’s accomplice is who helped them escape
All you know is that the theft took place on July 28, 2021 and that it took place on Humphrey Street.

How will you go about solving this mystery? The Fiftyville authorities have taken some of the town’s records from around the time of the theft 
and prepared a SQLite database for you, fiftyville.db, which contains tables of data from around the town. You can query that table using SQL 
SELECT queries to access the data of interest to you. Using just the information in the database, your task is to solve the mystery.

# Specification
For this problem, equally as important as solving the mystery itself is the process that you use to solve the mystery. In log.sql, keep a log of 
all SQL queries that you run on the database. Above each query, label each with a comment (in SQL, comments are any lines that begin with --) 
describing why you’re running the query and/or what information you’re hoping to get out of that particular query. You can use comments
in the log file to add additional notes about your thought process as you solve the mystery: ultimately, this file should serve as evidence of 
the process you used to identify the thief!

# Hints
Execute sqlite3 fiftyville.db to begin running queries on the database.
While running sqlite3, executing .tables will list all of the tables in the database.
While running sqlite3, executing .schema TABLE_NAME, where TABLE_NAME is the name of a table in the database, will show you the CREATE TABLE command
used to create the table. This can be helpful for knowing which columns to query!
You may find it helpful to start with the crime_scene_reports table. Start by looking for a crime scene report that matches the date and the location
of the crime.

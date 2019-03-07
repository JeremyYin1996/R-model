library(RODBC)
conn = odbcConnect("mysqlodbc",uid="root",pwd="yhn1996")

database = sqlQuery(conn,"SELECT * FROM t_class")
dim(database)

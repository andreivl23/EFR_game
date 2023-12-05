import mysql.connector

def makeconnection():
    connection = mysql.connector.connect(
             host='172.232.129.9',
             port=3306,
             database='efr_mini',
             user='',
             password='',
             autocommit=True
             )
    return connection

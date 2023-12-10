import mysql.connector


def make_connection():
    connection = mysql.connector.connect(
             host='172.232.129.9',
             port=3306,
             database='efr_mini',
             user='root',
             password='3scapeFromRussia!',
             autocommit=True
             )
    return connection


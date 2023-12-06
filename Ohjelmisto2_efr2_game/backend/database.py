import mysql.connector


def make_connection():
    connection = mysql.connector.connect(
             host='172.232.129.9',
             port=3306,
             database='efr_mini',
             user='American',
             password='123321',
             autocommit=True
             )
    return connection

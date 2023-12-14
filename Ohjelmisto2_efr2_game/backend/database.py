import mysql.connector


def make_connection():
    connection = mysql.connector.connect(
             host='',
             port=,
             database='',
             user='',
             password='',
             autocommit=True
             )
    return connection


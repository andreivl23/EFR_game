from mysql.connector import pooling


def make_connection():
    db_config = {
        'host': "",
        'user': "",
        'password': "",
        'database': "",
        'autocommit': True
    }
    connection_pool = pooling.MySQLConnectionPool(pool_name="mypool", pool_size=16, **db_config)

    return connection_pool


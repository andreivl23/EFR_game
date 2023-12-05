import mysql.connector
from flask import Flask
from flask_cors import CORS
import random


connection = mysql.connector.connect(
         host='172.232.129.9',
         port=3306,
         database='efr_mini',
         user='',
         password='',
         autocommit=True
         )

app = Flask(__name__)
CORS(app)


@app.route('/get/balance/<game_id>') # returns balance of game session
def get_balance(game_id):
    sql = f"SELECT balance FROM game WHERE GameID = '{game_id}'"
    cursor = connection.cursor()
    cursor.execute(sql)
    balance = {
        "balance": cursor.fetchone()[0]
    }
    return balance

@app.route('/get/neighbors/<station_id>') # returns list of connected stations with station name and ID
def get_neighbors(station_id):
    sql = f"SELECT StationName, StationID from Stations, Connections WHERE StationID2 = StationID AND StationID1 = '"
    sql += f"{station_id}'"
    cursor = connection.cursor()
    cursor.execute(sql)
    neighbors = cursor.fetchall()
    neighbors_dictionary = {}
    num = 0
    for city in neighbors:
        num += 1
        neighbors_dictionary[str(num)] = city
    return neighbors_dictionary

@app.route('/start/<player>/<current_station>/<resource>') # Starts game, appends events to random locations. Returns game_id.
def start(resource, current_station, player):


    sql = f"INSERT INTO game (ScreenName, Location, Balance) VALUES ('{player}', {current_station}, {resource});"
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql)
    game_id = cursor.lastrowid
    events = get_events()
    events_list = []

    for event in events:
        for i in range(0, event['probability'], 1):
            events_list.append(event['id'])

    t_stations = random.sample(range(1, 34), 33)

    for i, event_id in enumerate(events_list):
        sql = f"INSERT INTO events_location (id, game, event)" \
          f" VALUES ({t_stations[i]}, {game_id}, {event_id});"
        cursor = connection.cursor(dictionary=True)
        cursor.execute(sql)



    return {"game id":game_id,"station":current_station}

@app.route('/move/<station_id>/<game_id>/<option>') # Changes player location to specified station
def moveto(station_id,game_id, option):
    cost = -1
    if option == "green":
        cost = -2

    sql = f"UPDATE Game SET Location = '{station_id}' WHERE gameid = {game_id} "
    cursor = connection.cursor()
    cursor.execute(sql)
    update_balance(cost, game_id)
    passport = False
    if int(station_id) == get_passport(game_id):
        passport = True
    return {"movedto": station_id,"cost": cost,"winning": passport}


# @app.route('/update/balance/<game_id>/<amount>') # updates balance of the game session # INTERNAL
def update_balance(amount, game_id):
    sql = f"UPDATE game SET Balance = Balance+({amount}) WHERE GameID = '{game_id}'"
    cursor = connection.cursor()
    cursor.execute(sql)
    return get_balance(game_id)

def get_events(): # Gets list of events
    sql = "SELECT id, name, balance, probability FROM events;"
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def check_event(event_num): # checks whether , actually I don't now..
    sql = f"SELECT name, balance FROM events WHERE id = {event_num};"
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql)
    event_dictionary = cursor.fetchall()

    name = event_dictionary[0]['name']
    balance = event_dictionary[0]['balance']

    return name, balance
def get_passport(game_id):
    sql = f"SELECT id FROM events_location WHERE event = 1 AND game = {game_id}"
    cursor = connection.cursor()
    cursor.execute(sql)
    passport_station_id = cursor.fetchone()
    return passport_station_id[0]


if __name__ == '__main__':
    app.run(use_reloader=True, host='127.0.0.1', port=3000)

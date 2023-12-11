
from database import make_connection
from flask import Flask, render_template, jsonify
from flask_cors import CORS
import random


connection = make_connection()
app = Flask(__name__, template_folder='../templates', static_folder='../static')
CORS(app)

""" API endpoints:

/start/<player>/<current_station>/<resource> --->   returns game_id and current_station
/get/balance/<game_id>                       --->   returns balance
/get/neighbors/<game_id>                     --->   returns neighbor stations
/move/<station_id>/<game_id>/<option>        --->   new station's id, cost and tells if game won. 
/check/event/<players_location>/<game_id>    --->   returns eventname, eventcost, eventtext and if it is opened.
                                                    changes opened to 1 if it was 0. 
"""


# INTERNAL FUNCTIONS ---------------------------------------------------------------------------

def update_balance(amount, game_id):
    sql = f"UPDATE game SET Balance = Balance+({amount}) WHERE GameID = '{game_id}'"
    cursor = connection.cursor()
    cursor.execute(sql)


def get_events():  # Gets list of events
    sql = "SELECT id, name, balance, probability FROM events;"
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql)
    result = cursor.fetchall()
    return result


def get_passport(game_id):
    sql = f"SELECT id FROM events_location WHERE event = 1 AND game = {game_id}"
    cursor = connection.cursor()
    cursor.execute(sql)
    passport_station_id = cursor.fetchone()
    return passport_station_id[0]

# Flask FUNCTIONS ---------------------------------------------------------------------------


@app.route('/')
@app.route('/home')
def index():
    return render_template('index.html')


@app.route('/escape-from-russia')
def story():
    return render_template('story.html')


@app.route('/create/<player>/<resource>')
def create(player, resource):
    try:
        if resource == 'easy':
            resource = 15
        elif resource == 'medium':
            resource = 10
        else:
            resource = 5

        if player == 'Hero':
            resource = 9999

        current_station = 7
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

        connection.commit()

        response_data = {'status': 'OK', 'GameID': game_id}
        return jsonify(response_data), 200
    except Exception as e:
        print('Error:', e)
        response_data = {'status': 'error', 'message': 'Internal server error'}
        return jsonify(response_data), 500


@app.route('/get/balance/<game_id>')  # returns balance of game session
def get_balance(game_id):
    sql = f"SELECT balance FROM game WHERE GameID = '{game_id}'"
    cursor = connection.cursor()
    cursor.execute(sql)
    balance = {
        "balance": cursor.fetchone()[0]}
    return balance


@app.route('/get/neighbors/<station_id>')  # returns list of connected stations with station name and ID
def get_neighbors(station_id):
    sql = (
        f"SELECT s.StationName, s.StationID, s.lat, s.lng "
        f"FROM Stations s "
        f"JOIN Connections c ON s.StationID = c.StationID2 "
        f"WHERE c.StationID1 = '{station_id}'"
    )
    cursor = connection.cursor()
    cursor.execute(sql)
    neighbors = cursor.fetchall()

    # Using a dictionary comprehension to create the result dictionary
    neighbors_dictionary = {
        str(idx + 1): {
            "StationName": city[0],
            "StationID": city[1],
            "lat": city[2],
            "lng": city[3],
        }
        for idx, city in enumerate(neighbors)
    }

    return neighbors_dictionary


@app.route('/move/<station_id>/<game_id>/<option>')  # Changes player location to specified station
def moveto(station_id, game_id, option):
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
    return {"movedto": station_id, "cost": cost, "winning": passport}


@app.route('/check/event/<players_location>/<game_id>')  # gets event's stats on specified location.
def check_event(players_location, game_id):
    sql = (
        f"SELECT name, balance, text, events_location.opened "
        f"FROM events "
        f"JOIN events_location ON events.id = events_location.event "
        f"WHERE events_location.id = {players_location} AND events_location.game = {game_id}")
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql)
    event_dictionary = cursor.fetchall()
    if not event_dictionary:
        # No data, handle this case (you can return a default event or raise an exception)
        default_event = {"name": "Empty Event", "balance": 0, "text": "No event data available", "opened": 1}
        return default_event
    name = event_dictionary[0]['name']
    balance = event_dictionary[0]['balance']
    text = event_dictionary[0]['text']
    opened = event_dictionary[0]['opened']
    event = {"name": name, "balance": balance, "text": text, "opened": opened}
    if opened == 0:
        sql = (
            f"UPDATE efr_mini.events_location SET opened=1 "
            f"WHERE id={players_location} AND game={game_id} AND opened=0")
        cursor.execute(sql)
        update_balance(balance, game_id)
    return event


@app.route('/get/station_id/<game_id>')
def get_current_station(game_id):
    sql = f"SELECT Location FROM Game Where GameID = {game_id}"
    cursor = connection.cursor(dictionary=True)
    cursor.execute(sql)
    station_id = cursor.fetchone()
    return station_id


if __name__ == '__main__':
    app.run(use_reloader=True, host='127.0.0.1', port=3000)

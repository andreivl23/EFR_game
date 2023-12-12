
from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector
import random


class GameApp:
    def __init__(self):
        self.app = Flask(__name__)
        CORS(self.app)
        self.setup_routes()
        self.connection = mysql.connector.connect(
            host='172.232.129.9',
            user='root',
            password='3scapeFromRussia!',
            db='efr_mini',
            autocommit=True
        )

    def setup_routes(self):
        self.app.route('/create/<player>/<resource>')(self.create)
        self.app.route('/get/balance/<game_id>')(self.get_balance)
        self.app.route('/get/neighbors/<station_id>')(self.get_neighbors)
        self.app.route('/move/<station_id>/<game_id>/<option>')(self.moveto)
        self.app.route('/check/event/<players_location>/<game_id>')(self.check_event)
        self.app.route('/get/station_id/<game_id>')(self.get_current_station)
        self.app.route('/get/coordinates/<station_id>')(self.get_coordinates)
        self.app.route('/get/passport_letter/<game_id>')(self.get_passport_letter)

    def update_balance(self, amount, game_id):
        sql = f"UPDATE game SET Balance = Balance+({amount}) WHERE GameID = '{game_id}'"
        cursor = self.connection.cursor()
        cursor.execute(sql)

    def get_events(self):
        sql = "SELECT id, name, balance, probability FROM events;"
        cursor = self.connection.cursor(dictionary=True)
        cursor.execute(sql)
        result = cursor.fetchall()
        return result

    def get_passport(self, game_id):
        sql = f"SELECT id FROM events_location WHERE event = 1 AND game = {game_id}"
        cursor = self.connection.cursor()
        cursor.execute(sql)
        passport_station_id = cursor.fetchone()
        return passport_station_id[0]

    def create(self, player, resource):
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
            cursor = self.connection.cursor(dictionary=True)
            cursor.execute(sql)
            game_id = cursor.lastrowid

            events = self.get_events()
            events_list = []
            for event in events:
                for i in range(0, event['probability'], 1):
                    events_list.append(event['id'])

            t_stations = random.sample(range(1, 34), 33)
            for i, event_id in enumerate(events_list):
                sql = f"INSERT INTO events_location (id, game, event)" \
                      f" VALUES ({t_stations[i]}, {game_id}, {event_id});"
                cursor = self.connection.cursor(dictionary=True)
                cursor.execute(sql)

            self.connection.commit()

            response_data = {'status': 'OK', 'GameID': game_id}
            return jsonify(response_data), 200
        except Exception as e:
            print('Error:', e)
            response_data = {'status': 'error', 'message': 'Internal server error'}
            return jsonify(response_data), 500

    def get_balance(self, game_id):
        sql = f"SELECT balance FROM game WHERE GameID = '{game_id}'"
        cursor = self.connection.cursor()
        cursor.execute(sql)
        balance = {"balance": cursor.fetchone()[0]}
        return balance

    def get_neighbors(self, station_id):
        sql = (
            f"SELECT s.StationName, s.StationID, s.lat, s.lng "
            f"FROM Stations s "
            f"JOIN Connections c ON s.StationID = c.StationID2 "
            f"WHERE c.StationID1 = '{station_id}'"
        )
        cursor = self.connection.cursor()
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

    def moveto(self, station_id, game_id, option):
        cost = -1
        if option == "green":
            cost = -2
        sql = f"UPDATE Game SET Location = '{station_id}' WHERE gameid = {game_id} "
        cursor = self.connection.cursor()
        cursor.execute(sql)
        self.update_balance(cost, game_id)
        passport = False
        if int(station_id) == self.get_passport(game_id):
            passport = True
        return {"movedto": station_id, "cost": cost, "winning": passport}

    def check_event(self, players_location, game_id):
        sql = (
            f"SELECT name, balance, text, events_location.opened "
            f"FROM events "
            f"JOIN events_location ON events.id = events_location.event "
            f"WHERE events_location.id = {players_location} AND events_location.game = {game_id}")
        cursor = self.connection.cursor(dictionary=True)
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
            self.update_balance(balance, game_id)
        return event

    def get_current_station(self, game_id):
        sql = f"SELECT Location FROM Game Where GameID = {game_id}"
        cursor = self.connection.cursor(dictionary=True)
        cursor.execute(sql)
        station_id = cursor.fetchone()
        return station_id

    def get_coordinates(self, station_id):
        sql = f"SELECT StationName, lat, lng FROM Stations WHERE StationID = '{station_id}'"
        cursor = self.connection.cursor()
        cursor.execute(sql)
        station_name, lat, lng = cursor.fetchone()
        return {'stationName': station_name, 'lat': lat, 'lng': lng}

    def get_passport_letter(self, game_id):
        sql =   (f"SELECT StationName FROM stations JOIN events_location ON stationid = id " 
        f"WHERE events_location.game = {game_id} AND events_location.event = 1")
        cursor = self.connection.cursor()
        cursor.execute(sql)
        name = cursor.fetchone()
        return {"letter": name[0][0]}


if __name__ == '__main__':
    app = GameApp()
    app.app.run(use_reloader=True, host='127.0.0.1', port=3000)


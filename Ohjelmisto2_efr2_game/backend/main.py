from database import make_connection
from flask import Flask
from flask_cors import CORS
import random

""" API endpoints:

/start/<player>/<current_station>/<difficulty> ---> returns game_id and current_station
/move/<station_id>/<game_id>/<option>          ---> new station's id, cost and tells if game won.
"""


class Game:

    def __init__(self):
        self.connection = make_connection()
        self.app = Flask(__name__)
        CORS(self.app)  # needed to
        self.setup_routes()

    def setup_routes(self):
        self.app.route('/create/<player>/<difficulty>')(self.create)  # creates game, returns GameID, balance and letter
        self.app.route('/move/<station_id>/<game_id>/<option>')(self.moveto)  # updates location, returns all data

    def update_balance(self, amount, game_id, cursor):  # updates balance and returns updated balance
        sql = f"UPDATE game SET Balance = Balance+({amount}) WHERE GameID = '{game_id}'"
        cursor.execute(sql)
        sql = f"SELECT balance FROM game WHERE GameID = '{game_id}'"
        cursor.execute(sql)
        balance = cursor.fetchone()
        return balance["balance"]


    def get_neighbors(self, station_id, cursor):  # gets neighbors for specified stations and returns enumerated dictionary
        sql = (
            f"SELECT s.StationName, s.StationID, s.lat, s.lng FROM Stations s "
            f"JOIN Connections c ON s.StationID = c.StationID2 "
            f"WHERE c.StationID1 = '{station_id}'")
        cursor.execute(sql)
        neighbors = cursor.fetchall()
        neighbors_dictionary = {
            str(idx + 1): {
                "StationName": city["StationName"],
                "StationID": city["StationID"],
                "lat": city["lat"],
                "lng": city["lng"]}
            for idx, city in enumerate(neighbors)}
        return neighbors_dictionary

    def set_events(self, game_id, cursor):  # Gets events from database and allocates events for the game.
        sql = "SELECT id, name, balance, probability FROM events;"
        cursor.execute(sql)
        events = cursor.fetchall()
        events_list = []
        for event in events:
            for i in range(0, event['probability'], 1):
                events_list.append(event['id'])
        t_stations = random.sample(range(1, 34), 33)  # makes list of unique numbers in specified range.
        sql = "INSERT INTO events_location (id, game, event) VALUES (%s, %s, %s);"
        values = [(station, game_id, event_id) for station, event_id in zip(t_stations, events_list)]  # optimized query
        cursor.executemany(sql, values)

    def check_event(self, players_location, game_id, skip, cursor):  # checks if location has events and returns event data
        sql = (
            f"SELECT name, balance, text, events_location.opened "
            f"FROM events "
            f"JOIN events_location ON events.id = events_location.event "
            f"WHERE events_location.id = {players_location} AND events_location.game = {game_id}")
        cursor.execute(sql)
        event_dictionary = cursor.fetchall()
        if not event_dictionary or skip:
            # If station doesn't have any events, return default event:
            default_event = {"name": "Empty Event", "balance": 0, "text": "No event data available", "opened": 1}
            return default_event
        name = event_dictionary[0]['name']
        balance = event_dictionary[0]['balance']
        text = event_dictionary[0]['text']
        opened = event_dictionary[0]['opened']
        event = {"name": name, "balance": balance, "text": text, "opened": opened}
        if opened == 0:
            sql = (
                f"UPDATE events_location SET opened=1 "
                f"WHERE id={players_location} AND game={game_id} AND opened=0")
            cursor.execute(sql)
        return event

    def get_station(self, station_id, cursor):  # gets data about station based on ID and returns it
        sql = f"SELECT StationName, lat, lng FROM Stations WHERE StationID = '{station_id}'"
        cursor.execute(sql)
        result = cursor.fetchone()
        return {'station_name': result["StationName"], 'lat': result["lat"], 'lng': result["lng"]}

    def get_passport_letter(self, game_id, cursor):  # gets passports location and returns first letter of that station
        sql = (f"SELECT StationName FROM stations JOIN events_location ON stationid = id " 
               f"WHERE events_location.game = {game_id} AND events_location.event = 1")
        cursor.execute(sql)
        station = cursor.fetchone()
        return station["StationName"][0]

    def create(self, player, difficulty):  # creates game, returns balance, game id and first letter

        if difficulty == 'easy':
            balance = 15
        elif difficulty == 'medium':
            balance = 10
        else:
            balance = 5
        if player == 'Santa':  # Cheat code.
            balance = 9999
        current_station = 7
        with self.connection.get_connection() as connection:
            cursor = connection.cursor(dictionary=True)
            sql = f"INSERT INTO game (ScreenName, Location, Balance) VALUES ('{player}', {current_station}, {balance});"
            cursor.execute(sql)
            game_id = cursor.lastrowid
            self.set_events(game_id, cursor)  # allocates events randomly
            letter = self.get_passport_letter(game_id, cursor)  # gets first letter of passport location
            response = {'GameID': game_id, "Letter": letter, "Balance": balance}
            return response


    def moveto(self, station_id, game_id, option):  # updates players location, returns data about events and neighbors
        with self.connection.get_connection() as connection:
            cursor = connection.cursor(dictionary=True)
            sql = f"UPDATE Game SET Location = '{station_id}' WHERE gameid = {game_id} "
            cursor.execute(sql)
            skip = False
            cost = -1
            if option == "start":  # needed for first call of the function when starting the game.
                cost = 0
                skip = True
            elif option == "green":
                cost = -2
            event = self.check_event(station_id, game_id, skip, cursor)  # checking event, skipping changes if skip is True
            balance = self.update_balance((cost + int(event["balance"])), game_id, cursor)  # updating balance after event too.
            station = self.get_station(station_id, cursor)  # getting coordinates and name of current station
            neighbors = self.get_neighbors(station_id, cursor)  # getting all the neighbors
            response = {
                "Location": {"StationName": station["station_name"], "station_id": station_id, "lat": station["lat"],
                             "lng": station["lng"]},
                "Event": {"name": event["name"], "text": event["text"], "opened": event["opened"],
                          "balance": event["balance"]},
                "Neighbors": neighbors,
                "Balance": balance}
            return response

Game = Game()
if __name__ == '__main__':

    from waitress import serve
    serve(Game.app, host="0.0.0.0", port=3000)

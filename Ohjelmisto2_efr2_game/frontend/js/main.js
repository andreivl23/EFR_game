// map initialization
const map = L.map('map').setView([63, 43], 3.8)  // ([lat "korkeus", long "leveys"], zoom)
const markerGroup = L.layerGroup().addTo(map);

// svg layer

var imageUrl = '../img/redmapwhitefixed.svg',
    imageBounds = [
        [0, 0],
        [100, 100]
    ];

L.imageOverlay(imageUrl, imageBounds).addTo(map);

// Define the bounding box coordinates
const southWest = L.latLng(5, -80);
const northEast = L.latLng(90, 160);
const bounds = L.latLngBounds(southWest, northEast);

// Set maximum bounds for map dragging
map.setMaxBounds(bounds);

// Set minimum and maximum zoom levels
const minZoom = 3;
const maxZoom = 5;

map.setMinZoom(minZoom);
map.setMaxZoom(maxZoom);


// global variables

var url= 'http://127.0.0.1:3000';
var playerName;
var difficulty;
var gameRound;
var gameId;
let dirty = 0;
let green = 0;

/*   markers   */

var focusIcon = L.icon({
    iconUrl: '../img/marker.png',
    iconSize:     [30, 40], // size of the icon
    iconAnchor:   [15, 40], // point of the icon which will correspond to marker's location
    popupAnchor:  [0, -40] // point from which the popup should open relative to the iconAnchor
});


/*  functions  */




async function getBalance() {
    const response = await fetch(`http://localhost:3000/get/balance/${gameId}`);
    const balance = await response.json();
    document.getElementById('budget').innerText = balance.balance
}


async function getNeighbors(current_station) {
    markerGroup.clearLayers();
    const response = await fetch(`http://localhost:3000/get/neighbors/${current_station}`);
    const stations = await response.json();
    for (let key in stations) {
        if (stations.hasOwnProperty(key)) {
          const station = stations[key];
          const { lat, lng, StationName, StationID } = station;
          const popupContent = document.createElement('div')
          popupContent.innerHTML = '<p><b>Witch train do you prefer ?</b></p>'

          const buttonElement = document.createElement('button');
          buttonElement.id = 'go_green'
          buttonElement.textContent = 'Electric';
          buttonElement.addEventListener('click', () => {
              console.log(`Button clicked for station ${StationName} ${StationID}`);
              green ++;
              document.getElementById('green').innerText = green;
              moveTo(StationID, 'green');
          });
          popupContent.appendChild(buttonElement);

          const buttonElement2 = document.createElement('button');
          buttonElement2.id = 'go_dirty'
          buttonElement2.textContent = 'Diesel';
          buttonElement2.addEventListener('click', () => {
              console.log(`Button clicked for station ${StationName} ${StationID}`);
              dirty ++;
              document.getElementById('dirty').innerText = dirty;
              moveTo(StationID, 'dirty');
          });
          popupContent.appendChild(buttonElement2);


          const marker = L.marker([lat, lng], {icon: focusIcon}).addTo(map).bindPopup(popupContent);
          markerGroup.addLayer(marker);
        }
    }
}


async function getCurrentStation() {
    const response = await fetch(`http://localhost:3000/get/station_id/${gameId}`);
    const station = await response.json();
    await checkEvent(station.Location);
    await getNeighbors(station.Location);
    await getBalance();
}

async function moveTo(stationId, option) {
    const response = await fetch(`http://localhost:3000//move/${stationId}/${gameId}/${option}`);
    const something = await response.json();
    await getCurrentStation();
}

async function checkEvent(location){
    const response = await fetch(`http://localhost:3000//check/event/${location}/${gameId}`);
    const event = await response.json();
    console.log('Event condition:', event.opened);
    if (event.opened == 0 && event.name != 'passport') {
        const closeEvent = document.querySelector('#close_event');
        closeEvent.addEventListener('click', () => { dialog.close() });
        const dialog = document.getElementById('event');
        dialog.querySelector('h1').textContent = event.name.charAt(0).toUpperCase() + event.name.slice(1);
        dialog.querySelector('p').textContent = event.text
        dialog.showModal();
    } else if (event.name == 'passport'){

        // Tähän tulee viimäinen statistiikka ikkuna, jolla arvioidan kestävän kehityksen päämäärät
        // Ja se luultavasti pitää olla erilisilla funktiona

        const win = document.getElementById('win');
        win.showModal();
    }
}










// Setting up game

document.getElementById('player-form').addEventListener('submit', function (evt) {
    evt.preventDefault();

    const audio = new Audio('../audio/open-the-can.mp3');
        audio.play();


    gameRound = 1;
    playerName = document.getElementById('player-input').value;
    difficulty = document.querySelector('input[name="difficulty"]:checked').value;

    (async function() {
    try {
    const response = await fetch(`http://localhost:3000/create/${playerName}/${difficulty}`);
    const data = await response.json();
    gameId = data.GameID;


    document.getElementById('changeName').innerText = playerName;
    document.getElementById('disappear').innerHTML = '';

    // GAME START HERE


    getCurrentStation()

    } catch(error) {
        console.error(error);
    }
})();
});





/*    location by click    */

var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(map);
}

// map.on('click', onMapClick);

/*   Restart   */

const restart = document.querySelectorAll('.restart')
restart[0].addEventListener('click', () => {
    location.reload()
});
restart[1].addEventListener('click', () => {
    location.reload()
});


/*  help menu  */

const story = document.querySelector('#story')
const manual = document.querySelector('#manual')
const dialog = document.querySelectorAll('.help_menu')
const closeStory = document.querySelector('#close_story')
const closeLeManuelle = document.querySelector('#close_manual')

story.addEventListener('click', () => {
    const audio = new Audio('../audio/open-the-can.mp3');
    audio.play();
    dialog[0].showModal();
});

manual.addEventListener('click', () => {
    const audio = new Audio('../audio/open-the-can.mp3');
    audio.play();
    dialog[1].showModal();
});

closeStory.addEventListener('click', () => {
    dialog[0].close();
});

closeLeManuelle.addEventListener('click', () => {
    dialog[1].close();
});

// map initialization
const map = L.map('map').setView([63, 43], 3.8)  // ([lat "korkeus", long "leveys"], zoom)
const markerGroup = L.layerGroup().addTo(map);

// svg layer
const imageUrl = '../img/redmapwhitefixed.svg',
    imageBounds = [
        [0, 0],
        [100, 100]];
L.imageOverlay(imageUrl, imageBounds).addTo(map);

// Define the bounding box coordinates
const southWest = L.latLng(5, -80);
const northEast = L.latLng(90, 160);
const bounds = L.latLngBounds(southWest, northEast);

// Set maximum bounds for map dragging
map.setMaxBounds(bounds);

// Set minimum and maximum zoom levels
const minZoom = 3;
const maxZoom = 8; // 5 def
map.setMinZoom(minZoom);
map.setMaxZoom(maxZoom);


// global variables

const url= 'http://127.0.0.1:3000'; // BACKEND URL

let playerName;
let difficulty;
let gameRound;
let gameId;
let letter;
let clickedLetter = false;
let dirty = 0;
let green = 0;

/*   marker icons   */

const focusIcon = L.icon({
    iconUrl: '../img/marker.png',
    iconSize:     [30, 40], // size of the icon
    iconAnchor:   [15, 40], // point of the icon which will correspond to marker's location
    popupAnchor:  [0, -40] // point from which the popup should open relative to the iconAnchor
});
const currentIcon = L.icon({
    iconUrl: '../img/currentmarker.png',
    iconSize:     [30, 40],
    iconAnchor:   [15, 40],
    popupAnchor:  [0, -40]
});


/*                        FUNCTIONS                          */

/*+++++++++++++++++++++++++++++++++++++++++++++++ BALANCE FUNCTION ++++++++++++++++++++++++++++++*/
async function updateBalance(balance) {
    const balanceInt = parseInt(balance);
    if (balanceInt <= 0) { balance = 0 }
    document.getElementById('budget').innerText = balance;
    return balance
}
/*-------------------------------------- BALANCE FUNCTION -----------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++ NEIGHBORS FUNCTION ++++++++++++++++++++++++++++++*/

async function getNeighbors(neighbors) {
    markerGroup.clearLayers();
    for (let key in neighbors) {
      if (neighbors.hasOwnProperty(key)) {
        const station = neighbors[key];
        const { lat, lng, StationName, StationID } = station;
        const popupContent = document.createElement('div');
        popupContent.innerHTML = `<h2>${StationName}</h2><p><b>Which train do you prefer ?</b></p>`;
        const buttonElement = document.createElement('button');
        buttonElement.id = 'go_green';
        buttonElement.textContent = 'Electric';
        buttonElement.addEventListener('click', () => {
            console.log(`Button clicked for station ${StationName} ${StationID}`);
            green ++;
            document.getElementById('green').innerText = green;
            moveTo(StationID, 'green');
        });
        popupContent.appendChild(buttonElement);
        const buttonElement2 = document.createElement('button');
        buttonElement2.id = 'go_dirty';
        buttonElement2.textContent = 'Diesel';
        buttonElement2.addEventListener('click', () => {
            console.log(`Button clicked for station ${StationName} ${StationID}`);
            dirty ++;
            document.getElementById('dirty').innerText = dirty;
            moveTo(StationID, 'dirty');
        });
        popupContent.appendChild(buttonElement2);

        const marker = L.marker([lat, lng], {icon: focusIcon}).addTo(map).bindPopup(popupContent);
        markerGroup.addLayer(marker);}}}
/*-------------------------------------- NEIGHBORS FUNCTION -----------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++ MOVE FUNCTION ++++++++++++++++++++++++++++++*/

async function moveTo(stationId, option) {
    const response = await fetch(`${url}/move/${stationId}/${gameId}/${option}`);
    const data = await response.json();
    await getCurrentStation(data);}

async function getCurrentStation(data) {    /*Station.id, name, Lat + Lon, neighbors list, balance, event.name, event.opened.   */
    await checkEvent(data.Event);
    await getNeighbors(data.Neighbors);
    updateBalance(data.Balance);
    // const coordinates = await getCoordinates(station.Location)
    const { lat, lng, stationName, stationId } = data.Location;
    const marker = L.marker([lat, lng], {icon: currentIcon}).addTo(map).bindPopup("You are at "+ data.Location.StationName);
    markerGroup.addLayer(marker);
    if (!clickedLetter) {checkBalanceCondition(data.Balance);}}
/*-------------------------------------- MOVE FUNCTION -----------------------------------*/


/*+++++++++++++++++++++++++++++++++++++++++++++++ EVENT FUNCTION ++++++++++++++++++++++++++++++*/

async function checkEvent(event){
    const balance = document.getElementById('budget').innerText;
    console.log('Event condition:', event.opened);
    if (event.name == 'passport'){
        const win = document.getElementById('win');
        const audio = new Audio('../audio/success-trumpets.mp3');
        audio.play();
        await endstats(win,"win");
        win.showModal();}
    else if (balance == '0') {
        const lose = document.getElementById('lose');
        const audio = new Audio('../audio/jingle-bells.mp3');
        audio.play();
        await endstats(lose,"lose");
        lose.showModal();
    }
    else if (event.opened == 0 && event.name != 'passport') {
        const closeEvent = document.querySelector('#close_event');
        const dialog = document.getElementById('event');
        const h2 = dialog.querySelector('h2');
        closeEvent.addEventListener('click', () => dialog.close());
        h2.style.color = event.balance > 0 ? 'green' : 'red';
        h2.textContent = event.balance > 0 ? `+${event.balance} Coca-Cola` : `${event.balance} Coca-Cola`;
        dialog.querySelector('h1').textContent = event.name;
        dialog.querySelector('p').textContent = event.text;
        dialog.showModal();}}

async function endstats(element, type) {
  if (green > 0) {
  element.querySelector('h3').innerHTML = "Even though you didn't have to," +
      ` you have spent more Coca-Cola for the green option ${green} times.`;
  } else if (green == 0 && type == "win") {
    element.querySelector('#youWin').src = "../img/train.gif"
    element.querySelector('h3').innerHTML = "You won!<br>But you didn't use green option even once. " +
      `Maybe try better next time.`
  }

}
/*-------------------------------------- EVENT FUNCTION -----------------------------------*/

/*+++++++++++++++++++++++++++++++++++++ LETTER BUTTON +++++++++++++++++++++++++++++++++++++*/

function updateButtonState(option) {
  const button = document.getElementById('passport');
  if (option == 1) {
    // Remove the lock icon and update styles when the condition is met
    button.innerHTML = 'Get letter'; button.style.backgroundColor = 'gold';
    button.style.color = 'black'; button.disabled = false;
  } else if (option == 2) {
    // Restore the original button content and styles when the condition is not met
    button.innerHTML = 'Get letter<img src="../img/lock.png" alt="Lock Icon" class="lock-icon">';
    button.style.backgroundColor = '#9c9c9c'; button.style.color = '#454545';
    button.disabled = true;
  } else {
    // Restore the original button content and styles when the condition is not met
    button.innerHTML = `First letter is: ${option}`; button.style.backgroundColor = 'rgb(117, 0, 0)';
    button.style.color = 'white'; button.disabled = true;
    button.style.fontSize = '1rem'; button.style.padding = '0.7rem 0.4rem' }}


async function checkBalanceCondition(balance) {
  if (balance <= 5) {
    updateButtonState(1);
    document.getElementById('passport').addEventListener('click', async function getPassportLetter(){
      updateButtonState(letter)
      clickedLetter = true})}}
/*----------------------------------------- LETTER BUTTON END -----------------------------------------------------*/

/* ++++++++++++++++++++++++++++++++++++++ SETTING UP GAME +++++++++++++++++++++++++++++++++++++++++++++++++++++++++ */
updateButtonState(2) // disables Get letter button

document.getElementById('player-form').addEventListener('submit', function (event) {
    event.preventDefault();

    const audio = new Audio('../audio/open-the-can.mp3');
        audio.play();

    gameRound = 1;
    playerName = document.getElementById('player-input').value;
    difficulty = document.querySelector('input[name="difficulty"]:checked').value;

    (async function() {
    try {
        const response = await fetch(`${url}/create/${playerName}/${difficulty}`);
        const data = await response.json();
        await updateBalance(data.Balance);
        gameId = data.GameID; letter = data.Letter;

        document.getElementById('changeName').innerText = playerName;
        document.getElementById('disappear').innerHTML = '';

        // GAME START HERE

        await moveTo(7, "start")

    } catch(error) {
        console.error(error);
    }
})();
});


// map.on('click', onMapClick);

/*   Restart   */

const restart = document.querySelectorAll('.restart')
restart[0].addEventListener('click', () => {
    location.reload()
});
restart[1].addEventListener('click', () => {
    location.reload()
});
restart[2].addEventListener('click', () => {
    location.reload()
});

/*  help menu  */

const story = document.querySelector('#story')
const manual = document.querySelector('#manual')
const dialog = document.querySelectorAll('.help_menu')
const closeStory = document.querySelector('#close_story')
const closeLeManuelle = document.querySelector('#close_manual')

story.addEventListener('click', () => {
    const audio = new Audio('../audio/pageturn.mp3');
    audio.play();
    dialog[0].showModal();
});

manual.addEventListener('click', () => {
    const audio = new Audio('../audio/page-turn2.mp3');
    audio.play();
    dialog[1].showModal();
});

closeStory.addEventListener('click', () => {
    dialog[0].close();
});

closeLeManuelle.addEventListener('click', () => {
    dialog[1].close();
});




/*++++++++             DEV TOOLS           +++++++++++++++*/
/*    location by click WORKING

map.on('click', function(e){
  var coord = e.latlng;
  var lat = coord.lat;
  var lng = coord.lng;
  console.log("You clicked the map at latitude: " + lat + " and longitude: " + lng);
  });
*/
/*    location by click NOT WORKING

const popup = L.popup();
function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(map);}

*/

/*----------------- THE END   ----------------------*/

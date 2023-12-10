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



/*   markers   */

var focusIcon = L.icon({
    iconUrl: '../img/marker.png',
    iconSize:     [30, 40], // size of the icon
    iconAnchor:   [15, 40], // point of the icon which will correspond to marker's location
    popupAnchor:  [0, -40] // point from which the popup should open relative to the iconAnchor
});

async function getNeighbors(current_station) {
    markerGroup.clearLayers();
    const response = await fetch(`http://localhost:3000/get/neighbors/${current_station}`);
    const stations = await response.json();
    for (let key in stations) {
        if (stations.hasOwnProperty(key)) {
          const station = stations[key];
          const { lat, lng, StationName } = station;
          const marker = L.marker([lat, lng], {icon: focusIcon}).addTo(map).bindPopup(StationName);
          markerGroup.addLayer(marker);
        }
    }
}
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
/*
var SaintPeterburg = L.marker([67.39868, 15.3]).addTo(map);
var Murmansk = L.marker([70.15467, 25.73]).addTo(map);
var Arkhangelsk = L.marker([67.444719, 24.4]).addTo(map);
var Pechora = L.marker([65.783985, 32.56]).addTo(map);
var Vorkuta = L.marker([66.40648, 37.276027]).addTo(map);
var Yaroslavl = L.marker([64.852794, 18.2]).addTo(map);
var Moscow = L.marker([64.53859, 14.9]).addTo(map);
var Voronezh = L.marker([62.348729, 13.1]).addTo(map);
var Krasnodar = L.marker([59.235846, 6.5]).addTo(map);
var Volgograd = L.marker([59.326614, 13.35]).addTo(map);
var Astrakhan = L.marker([57.175875, 14.2]).addTo(map);
var Kazan = L.marker([62.183766, 21]).addTo(map);
var Perm = L.marker([62.216313, 27.36]).addTo(map);
var Yekaterinburg = L.marker([60.763599, 29.65]).addTo(map);
var Saratov = L.marker([60.4, 16.5]).addTo(map);
var Ufa = L.marker([60.165642, 25.706749]).addTo(map);
var Kurgan = L.marker([59.477617, 31.95]).addTo(map);
var Orenburg = L.marker([58.840288, 23]).addTo(map);
var Orsk = L.marker([57.813579, 25.57]).addTo(map);
var Tyumen = L.marker([60.336036, 33.3]).addTo(map);
var Surgut = L.marker([62.189449, 40]).addTo(map);
var NovyUrengoy = L.marker([64.631792, 43.9]).addTo(map);
var Omsk = L.marker([58.070165, 38.05]).addTo(map);
var Krasnoyarsk = L.marker([58.081783, 52.8]).addTo(map);
var Bratsk = L.marker([58.509039, 58.65]).addTo(map);
var Irkutsk = L.marker([55.811589, 61.73]).addTo(map);
var Chita = L.marker([56.739684, 69.32]).addTo(map);
var Tynda = L.marker([60.773494, 75.5]).addTo(map);
var Tommot = L.marker([62.384446, 73.6]).addTo(map);
var UstIlimsk = L.marker([59.859554, 59.2]).addTo(map);
var Urgal = L.marker([59.95, 83.7]).addTo(map);
var Khabarovsk = L.marker([59.125561, 87.7]).addTo(map);
var Vladivostok = L.marker([55.074125, 88.921864]).addTo(map);
*/


/*    location by click    */

var popup = L.popup();

function onMapClick(e) {
    popup
        .setLatLng(e.latlng)
        .setContent("You clicked the map at " + e.latlng.toString())
        .openOn(map);
}

map.on('click', onMapClick);

/*   Restart   */

function pageLoad() {
    const modal = document.querySelector('#player-modal')
    modal.showModal()

    const closeModal = document.querySelector('#level_submit')
    closeModal.addEventListener('click', () => {
        modal.close()
    })
}

window.onload = pageLoad;

const restart = document.querySelector('#restart')
restart.addEventListener('click', () => {
    location.reload()
});



/*  help menu  */

const story = document.querySelector('#story')
const manual = document.querySelector('#manual')
const dialog = document.querySelectorAll('.help_menu')
const closeStory = document.querySelector('#close_story')
const closeLeManuelle = document.querySelector('#close_manual')

story.addEventListener('click', () => {
    console.log(dialog[0])
    dialog[0].showModal();
});

manual.addEventListener('click', () => {
    dialog[1].showModal();
});

closeStory.addEventListener('click', () => {
    console.log('click')
    dialog[0].close();
});

closeLeManuelle.addEventListener('click', () => {
    console.log('click')
    dialog[1].close();
});
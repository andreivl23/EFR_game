const map = L.map('map').setView([51.505, -0.09], 13);
L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
    maxZoom: 19,
    attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
}).addTo(map);


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
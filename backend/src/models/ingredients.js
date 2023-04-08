const fetch = require('node-fetch');
require("dotenv").config();


const API_KEY = process.env.API_KEY;
const ingredients = 'carrots,tomatoes'; // O puede variar según el valor de una variable

const url = `https://api.spoonacular.com/recipes/findByIngredients?apiKey=${API_KEY}&ingredients=${ingredients}&number=10&limitLicense=true&ranking=1&ignorePantry=false`;

fetch(url)
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error));

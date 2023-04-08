const express = require('express');
const router = express.Router();
const axios = require('axios');

// Ruta para obtener recetas con ingredientes dados
router.get('/api/suggestions', async (req, res) => {
  const ingredients = req.query.ingredients;
  const apiUrl = `https://api.spoonacular.com/recipes/findByIngredients?ingredients=${ingredients}&number=10&limitLicense=true&ranking=1&ignorePantry=false&apiKey=${process.env.SPOONACULAR_API_KEY}`;

  try {
    const response = await axios.get(apiUrl);
    const data = response.data;
    res.json(data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Ha ocurrido un error al obtener las recetas' });
  }
});

module.exports = router;
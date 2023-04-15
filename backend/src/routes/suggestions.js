const express = require('express');
const router = express.Router();
const axios = require('axios');

// Ruta para obtener recetas con ingredientes dados
router.get('/api/suggestions', async (req, res) => {
  const ingredients = req.query.ingredients;
  if (!ingredients) {
    return res.status(400).json({ error: 'Debe proporcionar ingredientes para obtener sugerencias de recetas' });
  }
  const apiUrl = `https://api.spoonacular.com/recipes/findByIngredients?ingredients=${ingredients}&number=10&limitLicense=true&ranking=1&ignorePantry=false&apiKey=${process.env.SPOONACULAR_API_KEY}`;

  try {
    const response = await axios.get(apiUrl);
    const data = response.data;
    res.json(data);
  } catch (error) {
    console.error(error);
    let errorMessage = 'Ha ocurrido un error al obtener las recetas';
    if (error.response) {
      if (error.response.status === 401) {
        errorMessage = 'No se pudo autenticar con la API externa';
      } else if (error.response.status === 404) {
        errorMessage = 'La API externa no pudo encontrar la información solicitada';
      } else if (error.response.status === 429) {
        errorMessage = 'Ha excedido el límite de solicitudes de la API externa';
      }
    } else if (error.code === 'ECONNREFUSED') {
      errorMessage = 'La API externa no está disponible en este momento';
    }
    res.status(500).json({ error: errorMessage });
  }
});

module.exports = router;

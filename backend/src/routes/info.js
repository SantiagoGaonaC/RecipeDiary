const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const axios = require('axios');

router.get('/api/info',auth, async (req, res) => {
  const ids = req.query.ids;
  const apiUrl = `https://api.spoonacular.com/recipes/informationBulk?ids=${ids}&includeNutrition=false&apiKey=${process.env.SPOONACULAR_API_KEY}`;

  try {
    const response = await axios.get(apiUrl);
    const data = response.data;

    // Si vamos a usar un modelo de datos para Recipe
    // Guardar información en la base de datos
    // Devolver los datos guardados al usuario
    // ...

    // Si no se está usando el modelo de datos Recipe
    // Devolver los datos relevantes al usuario directamente
    res.json(data);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Ha ocurrido un error al obtener la información de la receta' });
  }
});

module.exports = router;
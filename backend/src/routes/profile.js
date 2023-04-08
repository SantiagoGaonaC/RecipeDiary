const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const User = require('../models/user');

router.get('/api/profile', auth, async (req, res) => {
  try {
    const user = await User.findById(req.user.userId);
    res.json({ name: user.name, lastName: user.lastName });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Ha ocurrido un error al obtener el perfil del usuario' });
  }
});

module.exports = router;
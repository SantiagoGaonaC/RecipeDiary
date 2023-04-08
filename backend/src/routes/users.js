const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const User = require('../models/user');

router.post('/api/register', async (req, res) => {
  const { username, password, name, lastName } = req.body;

  // Verificar si el usuario ya existe
  const existingUser = await User.findOne({ username });
  if (existingUser) {
    return res.status(409).json({ error: 'El usuario ya existe' });
  }

  // Hash de la contraseña
  const saltRounds = 10;
  const hashedPassword = await bcrypt.hash(password, saltRounds);

  // Crear el usuario
  const user = new User({ username, password: hashedPassword, name, lastName });
  try {
    await user.save();
    res.status(201).json({ message: 'El usuario se ha registrado con éxito' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Ha ocurrido un error al registrar el usuario' });
  }
});

module.exports = router;

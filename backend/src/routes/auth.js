const express = require('express');
const router = express.Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/user');


router.post('/api/login', async (req, res) => {
  const { username, password } = req.body;

  // Verificar si el usuario existe
  const user = await User.findOne({ username });
  if (!user) {
    return res.status(401).json({ error: 'El usuario o la contraseña son incorrectos' });
  }

  // Verificar si la contraseña es correcta
  const validPassword = await bcrypt.compare(password, user.password);
  if (!validPassword) {
    return res.status(401).json({ error: 'El usuario o la contraseña son incorrectos' });
  }

  // Crear token de autenticación
  const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET);

  // Enviar respuesta con token
  res.json("Login exitoso token:",{ token });
});

module.exports = router;

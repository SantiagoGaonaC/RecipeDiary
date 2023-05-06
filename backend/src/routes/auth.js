const express = require("express");
const router = express.Router();
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const User = require("../models/user");
const auth = require("../middleware/auth");
const { ActiveToken } = require("../models/activeToken");

router.post("/api/login", async (req, res) => {
  const { username, password } = req.body;

  // Verificar si el usuario existe
  const user = await User.findOne({ username });
  if (!user) {
    return res.status(404).json({ error: "El usuario no existe" });
  }

  // Verificar si la contraseña es correcta
  const validPassword = await bcrypt.compare(password, user.password);
  if (!validPassword) {
    return res
      .status(401)
      .json({ error: "El usuario o la contraseña son incorrectos" });
  }

  // Verificar si ya existe un token activo para el usuario
  const existingActiveToken = await ActiveToken.findOne({ userId: user._id });
  const currentDate = new Date();

  if (existingActiveToken) {
    // Verificar si el token activo existente ha expirado
    if (existingActiveToken.expiresAt > currentDate) {
      // Devolver el token activo existente
      return res.json({ token: existingActiveToken.token });
    } else {
      // Eliminar el token expirado
      await ActiveToken.deleteOne({ _id: existingActiveToken._id });
    }
  }

  // Crear token de autenticación
  const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
    expiresIn: 43200,
  });

  // Guardar token activo en la base de datos
  const expiresAt = new Date();
  expiresAt.setDate(expiresAt.getDate() + 1);
  const activeToken = new ActiveToken({ token, userId: user._id, expiresAt });
  await activeToken.save();

  // Enviar respuesta con token
  res.json({ token });
});

router.post("/api/logout", auth, async (req, res) => {
  const token = req.header("Authorization")?.replace("Bearer ", "");

  try {
    await ActiveToken.deleteOne({ token });
    res.json({ message: "Sesión cerrada exitosamente" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Error al cerrar la sesión" });
  }
});

module.exports = router;

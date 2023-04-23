const jwt = require('jsonwebtoken');
const { ActiveToken} = require('../models/activeToken');

const auth = async (req, res, next) => {
  const token = req.header('Authorization')?.replace('Bearer ', '');
  if (!token) {
    return res.status(401).json({ error: 'Token de autenticación no proporcionado' });
  }

  try {
    console.log(ActiveToken);
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const activeToken = await ActiveToken.findOne({ token: token });
    if (!activeToken) {
      throw new Error('Token no encontrado');
    }
    req.user = { userId: decoded.userId };
    next();
  } catch (error) {
    console.error(error);
    res.status(401).json({ error: 'Token de autenticación inválido' });
  }
};

module.exports = auth;
const jwt = require('jsonwebtoken');
const User = require('../models/user');

const auth = (req, res, next) => {
  const token = req.header('Authorization').replace('Bearer ', '');
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = { userId: decoded.userId };
    next();
  } catch (error) {
    res.status(401).json({ error: 'Token de autenticación inválido' });
  }
};

module.exports = auth;
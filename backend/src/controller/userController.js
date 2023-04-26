const User = require("../models/user");

// Otros imports y funciones existentes

const getFollowedUsers = async (req, res) => {
    try {
      const userId = req.user.userId;
      const user = await User.findById(userId).select('following');
      if (!user) {
        return res.status(404).json({ error: 'Usuario no encontrado' });
      }
      res.status(200).json(user.following);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Error al obtener la lista de usuarios seguidos' });
    }
  };
  
  module.exports = {
    // Otros controladores exportados
    getFollowedUsers
  };
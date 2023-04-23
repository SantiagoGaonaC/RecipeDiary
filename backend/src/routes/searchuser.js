const express = require('express');
const router = express.Router();
const User = require('../models/user');
const auth = require('../middleware/auth');

function removeDiacritics(str) {
  return str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
}

router.get("/api/users/search", auth, async (req, res) => {
  try {
    const { searchTerm } = req.query;

    if (!searchTerm) {
      return res.status(400).json({ error: "Debe proporcionar un término de búsqueda" });
    }

    const normalizedSearchTerm = removeDiacritics(searchTerm);
    const regexSearchTerm = new RegExp(normalizedSearchTerm, "i");

    const users = await User.find().select('-password');

    const filteredUsers = users.filter(user => {
      const normalizedUsername = removeDiacritics(user.username);
      const normalizedName = removeDiacritics(user.name);
      const normalizedLastName = removeDiacritics(user.lastName);

      return (
        regexSearchTerm.test(normalizedUsername) ||
        regexSearchTerm.test(normalizedName) ||
        regexSearchTerm.test(normalizedLastName)
      );
    });

    res.status(200).json({
      success: true,
      data: filteredUsers,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: "Error al buscar usuarios",
      error: err.message,
    });
  }
});

module.exports = router;
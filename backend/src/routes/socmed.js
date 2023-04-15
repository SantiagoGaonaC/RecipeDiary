const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const postsm = require('../models/postsocmed');

router.post('/api/socmed/post', auth, async (req, res) => {
    try {
      const { title, content } = req.body;
  
      // Validar formato de los datos
      if (typeof title !== 'string' || title.trim().length === 0) {
        return res.status(400).json({ error: 'El título del post debe ser una cadena de texto no vacía' });
      }
      if (typeof content !== 'string' || content.trim().length === 0) {
        return res.status(400).json({ error: 'El contenido del post debe ser una cadena de texto no vacía' });
      }
  
      const post = new postsm({
        userId: req.user.userId,
        title,
        content
      });
      await post.save();
      res.json(post);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Ha ocurrido un error al crear el post' });
    }
  });
  

router.get('/api/socmed/posts', auth, async (req, res) => {
    try {
      const posts = await postsm.find();
      res.json(posts);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'Ha ocurrido un error al obtener los posts' });
    }
  });

module.exports = router;
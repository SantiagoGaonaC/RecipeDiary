const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth");
const postsm = require("../models/postsocmed");
const User = require("../models/user");

router.post("/api/socmed/post", auth, async (req, res) => {
  try {
    const { title, content } = req.body;

    // Validar formato de los datos
    if (typeof title !== "string" || title.trim().length === 0) {
      return res.status(400).json({
        error: "El título del post debe ser una cadena de texto no vacía",
      });
    }
    if (typeof content !== "string" || content.trim().length === 0) {
      return res.status(400).json({
        error: "El contenido del post debe ser una cadena de texto no vacía",
      });
    }

    const post = new postsm({
      userId: req.user.userId,
      title,
      content,
    });
    await post.save();
    res.json(post);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Ha ocurrido un error al crear el post" });
  }
});

router.get("/api/socmed/posts", auth, async (req, res) => {
  try {
    const posts = await postsm.find();
    res.json(posts);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Ha ocurrido un error al obtener los posts" });
  }
});

router.post("/api/socmed/follow", auth, async (req, res) => {
  try {
    const { username } = req.body;

    // Validar formato de los datos
    if (typeof username !== "string" || username.trim().length === 0) {
      return res.status(400).json({
        error: "El nombre de usuario debe ser una cadena de texto no vacía",
      });
    }

    // Buscar el usuario a seguir
    const userToFollow = await User.findOne({ username });
    if (!userToFollow) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    // Agregar al usuario a la lista de seguidos
    const currentUser = await User.findById(req.user.userId);
    const alreadyFollowing = currentUser.following.some(
      (user) => user.userId.toString() === userToFollow._id.toString()
    );
    if (alreadyFollowing) {
      return res.status(400).json({ error: "Ya sigues a este usuario" });
    }
    currentUser.following.push({
      userId: userToFollow._id,
      username: userToFollow.username,
    });
    await currentUser.save();

    res.json({ message: `Ahora sigues a ${userToFollow.username}` });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Ha ocurrido un error al seguir al usuario" });
  }
});

router.get("/api/socmed/posts-following", auth, async (req, res) => {
  try {
    // Obtener los usuarios que sigue el usuario autenticado
    const currentUser = await User.findById(req.user.userId).populate(
      "following.userId"
    );
    const followingIds = currentUser.following.map((user) =>
      user.userId._id.toString()
    );

    // Obtener los posts de los usuarios seguidos
    const posts = await postsm.find({ userId: { $in: followingIds } });
    res.json(posts);
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Ha ocurrido un error al obtener los posts" });
  }
});


router.post("/api/socmed/unfollow", auth, async (req, res) => {
  try {
    const { username } = req.body;

    // Validar formato de los datos
    if (typeof username !== "string" || username.trim().length === 0) {
      return res.status(400).json({
        error: "El nombre de usuario debe ser una cadena de texto no vacía",
      });
    }

    // Buscar el usuario a dejar de seguir
    const userToUnfollow = await User.findOne({ username });
    if (!userToUnfollow) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    // Eliminar al usuario de la lista de seguidos
    const currentUser = await User.findById(req.user.userId);
    const followingIndex = currentUser.following.findIndex(
      (user) => user.userId.toString() === userToUnfollow._id.toString()
    );
    if (followingIndex === -1) {
      return res.status(400).json({ error: "No sigues a este usuario" });
    }
    currentUser.following.splice(followingIndex, 1);
    await currentUser.save();

    res.json({ message: `Dejaste de seguir a ${userToUnfollow.username}` });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Ha ocurrido un error al dejar de seguir al usuario" });
  }
});

module.exports = router;

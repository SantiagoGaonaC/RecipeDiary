const postsm = require("../models/postsocmed");

const deletePost = async (req, res) => {
  try {
    const postId = req.params.postId;
    const post = await postsm.findById(postId);

    if (!post) {
      return res.status(404).json({ error: "Publicación no encontrada" });
    }

    if (post.userId.toString() !== req.user.userId) {
      return res
        .status(403)
        .json({ error: "No tienes permiso para eliminar esta publicación" });
    }

    await postsm.findByIdAndDelete(postId);
    res.json({ message: "Publicación eliminada correctamente" });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Ha ocurrido un error al eliminar la publicación" });
  }
};

module.exports = {
  deletePost,
};
const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  username: { type: String, required: true },
  password: { type: String, required: true },
  name: { type: String, required: true },
  lastName: { type: String, required: true },
  following: [
    {
      userId: { type: mongoose.Types.ObjectId, ref: 'user' },
      username: { type: String, required: true }
    }
  ]
});

const user = mongoose.model('user', userSchema);

module.exports = user;
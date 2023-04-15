const mongoose = require('mongoose');

function connect() {
    mongoose.connect(process.env.CONNECTION_DB, { useNewUrlParser: true });
    const db = mongoose.connection;
    db.on('error', console.error.bind(console, 'Error de conexión:'));
    db.once('open', function() {
      console.log('Conectado a la base de datos');
    });
}

module.exports = { connect };

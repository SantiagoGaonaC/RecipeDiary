const {Schema, model} = require('mongoose');

const socialSchema = new Schema({
    id_usuario: {
        type: Schema.Types.ObjectId,
        ref: 'user'
    },
    id_receta: {
        type: Schema.Types.ObjectId,
        ref: 'receta'
    },
    tipo: String,
    fecha_creacion: Date
});

module.exports = model('social', socialSchema);

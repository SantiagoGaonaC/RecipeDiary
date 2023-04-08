const {Schema, model} = require('mongoose');

const recetaSchema = new Schema({
    titulo: String,
    descripcion: String,
    procedimiento: String,
    autor: {
        type: Schema.Types.ObjectId,
        ref: 'user'
    },
    fecha_creacion: Date
});

module.exports = model('receta', recetaSchema);

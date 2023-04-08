const mongoose = require('mongoose');
require("dotenv").config();

function connect() {
    mongoose.connect(process.env.CONNECTION_DB,{
        useNewUrlParser: true,
    } )
    mongoose.connection.on('connected', () => {
        console.log('Connected to MongoDB');
        })
    };

module.exports = {connect};
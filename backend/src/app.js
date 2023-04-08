const express = require('express');
const app = express();
require('dotenv').config();


const morgan = require('morgan');
const cors = require('cors');

app.use(morgan('dev'));
app.use(cors());

app.use(express.json());

app.use(require('./routes/users'));
app.use(require('./routes/auth'));

module.exports = app;
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
app.use(require('./routes/profile'));
app.use(require('./routes/suggestions'));
app.use(require('./routes/info'));
app.use(require('./routes/socmed'));


module.exports = app;
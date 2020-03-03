const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

const items = require('./routes/api/items');
const remarks = require('./routes/api/remarks');
const users = require('./routes/api/items');


const app = express();

//Bodyparser middleware
app.use(bodyParser.json());

//mongo config
const db = require('./config/keys').mongoURI;

//connection to db
mongoose.connect(db,  { useNewUrlParser: true, useUnifiedTopology: true })
    .then(()=> console.log('mongoDB connected'))
    .catch(err => console.log(err) );

//use routes
app.use('/api/items', items);
app.use('/api/remarks', remarks);
app.use('/api/users', users);

const port = process.env.PORT || 5000

app.listen(port, () => console.log('server started '));


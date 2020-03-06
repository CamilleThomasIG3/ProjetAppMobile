const express = require('express');
const mongoose = require('mongoose');
const config = require('config');


const items = require('./routes/api/items');
const remarks = require('./routes/api/remarks');
const users = require('./routes/api/users');



const app = express();

//Bodyparser middleware 
app.use(express.json());

//mongo config
const db = config.get('mongoURI');

//connection to db
mongoose.connect(db,  { useNewUrlParser: true, useUnifiedTopology: true, useCreateIndex: true })
    .then(()=> console.log('mongoDB connected'))
    .catch(err => console.log(err) );

//use routes
app.use('/api/auth', require('./routes/api/auth'));
app.use('/api/remarks', require('./routes/api/remarks'));
app.use('/api/users', require('./routes/api/users'));

const port = process.env.PORT || 5000

app.listen(port, () => console.log('server started '));


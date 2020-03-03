const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CategoryResponseSchema = new Schema({
    label: {
        type : String,
        required: true
    }
})

module.exports = Item = mongoose.model('categoryResponse', CategoryResponseSchema); 
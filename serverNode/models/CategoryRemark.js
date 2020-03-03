const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const CategoryRemarkSchema = new Schema({
    label: {
        type : String,
        required: true
    }
})

module.exports = Item = mongoose.model('categoryRemark', CategoryRemarkSchema); 
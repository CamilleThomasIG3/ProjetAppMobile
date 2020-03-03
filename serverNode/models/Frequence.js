const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const FrequenceSchema = new Schema({
    idPersonne: {
        type : String,
        required: true
    },
    idRemark: {
        type: String,
        required: true
    }
})

module.exports = Item = mongoose.model('frequence', FrequenceSchema); 
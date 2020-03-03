const mongoose = require('mongoose');
const Schema = mongoose.Schema;


const ResponseSchema = new Schema({

    contents: {
        type: String,
        required: true
    },
    idUser: {
        type: String,
        required: true
    },
    idRemark: {
        type: String,
        required: true
    },
    idCategoryResponse: {
        type: String,
        required: true
    },
    date:{
        type: Date,
        default: Date.now
    }
    
})

module.exports = Item = mongoose.model('response', ResponseSchema);
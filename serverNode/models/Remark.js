const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const RemarkSchema = new Schema({
    title: {
        type: String,
        required: true
    },
    content: {
        type: String,
        required: true
    },
    user: {
        type: String,
    },
    idCategory: {
        type: String,
        required: true
    },
    date:{
        type: Date,
        default: Date.now
    },
    likes: [
        {
            user: {
                type: String,
            }
        }
    ],
    answers: [
        {
            user: {
                type: String,
            },
            content: {
                type: String,
                required: true
            },
            date: {
                type: Date,
                default: Date.now
            },

            categoryResponse: {
                type: String
            },

            likes: [
                {
                    user: {
                        type: String,
                    }
                }
            ],
            signals: [
                {
                    user: {
                        type: String,
                    }
                }
            ],
            
        }
    ],
    signals: [
        {
            user: {
                type: String,
            }
        }
    ]
});

module.exports = Item = mongoose.model('remark',RemarkSchema);
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const RemarkSchema = new Schema({
    content: {
        type: String,
        required: true
    },
    User: {
        type: Schema.Types.ObjectId,
        ref:'user'
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
                type: Schema.Types.ObjectId,
                ref: 'user'
            }
        }
    ],
    comments: [
        {
            user: {
                type: Schema.Types.ObjectId,
                ref: 'user'
            },
            content: {
                type: String,
                required: true
            },
            pseudo: {
                type: String
            },
            date: {
                type: Date,
                default: Date.now
            },

            categoryResponse: {
                type : Schema.Types.ObjectId,
                ref: 'categoryResponse'
            },

            likes: [
                {
                    user: {
                        type: Schema.Types.ObjectId,
                        ref: 'user'
                    }
                }
            ]
            
        }
        
    ]

});

module.exports = Item = mongoose.model('remark',RemarkSchema);
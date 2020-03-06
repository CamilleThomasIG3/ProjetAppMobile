const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const RemarkSchema = new Schema({
    content: {
        type: String,
        required: true
    },
    user: {
        //type: Schema.Types.ObjectId,
        type: String,
        ref:'user',
        default: "camille"
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
                //type: Schema.Types.ObjectId,
                type: String,
                ref: 'user'
            }
        }
    ],
    answers: [
        {
            user: {
                //type: Schema.Types.ObjectId,
                type: String,
                ref: 'user',
                default: "mathis"
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
                //type : Schema.Types.ObjectId,
                type: String,
                ref: 'categoryResponse',
                default: "drole"
            },

            likes: [
                {
                    user: {
                        //type: Schema.Types.ObjectId,
                        type: String,
                        ref: 'user',
                    }
                }
            ]
            
        }
        
    ]

});

module.exports = Item = mongoose.model('remark',RemarkSchema);
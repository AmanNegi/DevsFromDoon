const mongoose = require("mongoose");
const { Schema } = mongoose;

const eventSchema = new Schema({
    title: {
        type : String,
        required: true
    },
    description: {
        type : String,
        required: true
    },
    venue: {
        type : String,
        required: true
    },
    paid: {
        type : Boolean,
        default: false
    },
    dl: {
        type: Boolean,
        default: true
    },
    attendees:[
        { type: Schema.Types.ObjectId, ref: 'User' }
    ] 
})


module.exports = mongoose.model('Event', eventSchema);
const mongoose = require('mongoose');
const { Schema } = mongoose;

const eventSchema = new Schema({
    title: {
        type: String,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    imageUrl: {
        type: String,
        required: true
    },
    venue: {
        type: String,
        required: true
    },
    paid: {
        type: Boolean,
        default: false
    },
    isLeaveProvided: {
        type: Boolean,
        default: true
    },
    attendees: [
        { type: Schema.Types.ObjectId, ref: 'User' }
    ],
    createdBy: {
        type: Schema.Types.ObjectId, 
        ref: 'User'
    },
    date: {
        type: Date,
        required: true
    },
    price: {
        type: Number,
        default: 0.0
    }
});

module.exports = mongoose.model('Event', eventSchema);
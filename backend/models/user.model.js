const mongoose = require('mongoose')
const Schema = mongoose.Schema

const journeySchema = new mongoose.Schema({
    date: {
        type: Date,
        default: Date.now
    },
    from: {
        type: String,
    },
    to: {
        type: String,
    },
    distance: {
        type: Number,
    },
    fare: {
        type: Number,
    },
    user: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: 'User',
    },
})

const newSchema = new Schema({
    email: String,
    password: String,
    name: {
        type: String,
        trim: true,
        required: true,
        maxlength: 32,
    },
    address: {
        type: String,
        trim: true,
        required: true,
        maxlength: 32,
    },
    phone: {
        type: Number,
        max: 9999999999,
        required: true,
    },
    balance: {
        type: Number,
        default: 500,
    },
    payments: [{
        amount: {
            type: Number,
        },
        paymentMethod: {
            type: String,
            enum: ['credit', 'debit']
        },
        cardNumber: {
            type: Number,
            min: 1000000000000000,
            max: 9999999999999999
        },
        date: {
            type: Date,
            default: Date.now
        }
    }],
    journeys: journeySchema,

})




const userSchema = new mongoose.Schema(
    {
        name: {
            type: String,
            trim: true,
            required: true,
            maxlength: 32,
        },
        address: {
            type: String,
            trim: true,
            required: true,
            maxlength: 32,
        },
        email: {
            type: String,
            trim: true,
        },
        info: {
            type: String,
            trim: true,
            maxlength: 32,
        },
        phone: {
            type: Number,
            max: 9999999999,
            required: true,
        },
        balance: {
            type: Number,
            default: 500,
        },
        payments: [{
            amount: {
                type: Number,
            },
            paymentMethod: {
                type: String,
                enum: ['credit', 'debit']
            },
            cardNumber: {
                type: Number,
                min: 1000000000000000,
                max: 9999999999999999
            },
            date: {
                type: Date,
                default: Date.now
            }
        }],
        journeys: [{
            date: {
                type: Date,
                default: Date.now
            },
            from: {
                type: String,
            },
            to: {
                type: String,
            },
            distance: {
                type: Number,
            },
            fare: {
                type: Number,
            }
        }],
        //   hashed_password: {
        //     type: String,
        //     required: true,
        //   },
        //   photo: {
        //     type: String,
        //   },
        //   resetPasswordLink: {
        //     data: String,
        //     default: "",
        //   },
        //   salt: String,
        //   isVerified: {
        //     type: Boolean,
        //     default: false,
        //   },
    },
);

module.exports = mongoose.model('User', newSchema)
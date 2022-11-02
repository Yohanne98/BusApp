// DB.js


//module.exports = {
//    DB: 'mongodb://localhost:27017/test1'
//}

const mongoose = require('mongoose')
const {
    dbconfig
} = require('./config')

mongoose
    .connect(dbconfig.connectionString, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    })
    .catch(e => {
        console.error('DB Connection error', e.message)
    })

const db = mongoose.connection

module.exports = db
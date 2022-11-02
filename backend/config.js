//config.js

const mongodb = {
    username: "ravindu",
    password: "584627913",
}

//mongodb+srv://cluster0.j13fi.mongodb.net/?authSource=%24external&authMechanism=MONGODB-X509&retryWrites=true&w=majority

//mongodb+srv://${mongodb.username}:${mongodb.password}@cluster0.j13fi.mongodb.net/Csse?retryWrites=true&w=majority

const dbconfig = {
    connectionString: `mongodb+srv://${mongodb.username}:${mongodb.password}@cluster0.j13fi.mongodb.net/Csse?retryWrites=true&w=majority`,
}


module.exports = { dbconfig }
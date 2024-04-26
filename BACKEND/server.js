const express = require('express');
const app = express();
require('dotenv').config();
const mongoose = require('mongoose');

const bodyParser = require('body-parser');
const Note = require("./src/models/Note");


app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());


const connectDb = async()=>{
    await mongoose.connect("mongodb+srv://sudarshandate21:Date%402004@cluster0.umuxzop.mongodb.net/notesdb");
    console.log(mongoose.connection.host);
}
connectDb();

app.get("/", function(req, res){
    const response = {statuscode: res.statusCode, message: "API Works!"};
    res.send(response);

});

const noteRouter = require('./src/routes/Note');

app.use("/notes", noteRouter);



const PORT = process.env.PORT || 5000;

app.listen(PORT, function(){
    console.log("server started at PORT : " + PORT);
});
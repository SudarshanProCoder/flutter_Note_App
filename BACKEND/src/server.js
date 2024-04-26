const express = require('express');
const app = express();
const mongoose = require('mongoose');

const bodyParser = require('body-parser');
const Note = require("./models/Note");


app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

const mongodbURL = "mongodb://localhost:27017/notesdb";

mongoose.connect(mongodbURL).then(function(){

    app.get("/", function(req, res){
        const response = {statuscode: res.statusCode, message: "API Works!"};
        res.send(response);

    });

    const noteRouter = require('./routes/Note');

    app.use("/notes", noteRouter);

   

});



const PORT = process.env.PORT || 5000;

app.listen(PORT, function(){
    console.log("server started at PORT : " + PORT);
});
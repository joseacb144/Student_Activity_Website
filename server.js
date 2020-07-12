const express = require("express");

const app = express();

app.get("/", function(req, res){
  res.sendFile(__dirname + "/login_page.html");
})

app.get("/home", function(req, res){
  res.sendFile(__dirname + "/home_page.html");
})

app.get("/textbook", function(req,res){
  res.send("Textbook Search");
})

app.listen(3000, function(){
  console.log("Server started on port 3000");
});

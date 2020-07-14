const express = require("express");
const bodyParser = require("body-parser");

const app = express();
app.use(bodyParser.urlencoded({extended: true}));


// Login Page
app.get("/", function(req, res) {
  res.sendFile(__dirname + "/login_page.html");
});

app.post("/", function(req, res) {
  console.log(req.body);

    res.send("Thanks for loging in!");
});




// Home Page
app.get("/home", function(req, res) {
  res.sendFile(__dirname + "/home_page.html");
});

app.get("/textbook", function(req, res) {
  res.send("Textbook Search");
});

app.listen(3000, function() {
  console.log("Server started on port 3000");
});

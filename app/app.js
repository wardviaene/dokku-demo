var express = require('express');
var mongoose = require('mongoose');
var app = express();

// db connection
var db = mongoose.connect(process.env.MONGO_URL ? process.env.MONGO_URL : 'mongodb://localhost/test', function (error) {
    if (error) {
        console.log(error);
    }
});
// Mongoose Schema definition
var Schema = mongoose.Schema;
var VisitsSchema = new Schema({ hits: Number });
var Visits = mongoose.model('visits', VisitsSchema);


app.get('/', function (req, res) {
   res.send('The app is working!');
});
app.get('/hit', function (req, res) {
    Visits.findOne({}, function(err, visit) {
      if(err || visit == null) {
        var newVisit = new Visits({hits: 1});
        res.send('Mongo Hits: '+newVisit.hits);
        newVisit.save();
      } else {
        visit.hits = visit.hits + 1;
        res.send('Mongo Hits: '+visit.hits);
        visit.save();
      }
    });
});

app.listen(5000, function () {
    console.log('Example app listening on port 5000!');
});

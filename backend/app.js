const express = require('express');
const mongoose = require('mongoose');
const routeList = require('./routes/routelist');

const app = express();
const port = process.env.SERVER_PORT || 3000;
const dbUri = `mongodb://${process.env.SERVER}:${process.env.DB_PORT}/${process.env.DB_NAME}`;

app.use(express.json());

mongoose.connect(dbUri, 
    { 
        useNewUrlParser: true, 
        useUnifiedTopology: true 
    }
)
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Could not connect to MongoDB:', err));

app.route('/api/v1/offers')
.get(routeList.getAllOfferList)
.post(routeList.createOfferList);

app.route('/api/v1/offers/:id')
.get(routeList.getOfferListById)
.patch(routeList.updateOfferList)
.delete(routeList.deleteOfferList);

app.listen(port,()=>{
    console.log(`Server running on port ${port}...`);
});
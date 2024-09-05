require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');
const { ObjectId } = require('mongoose').Types;
const Offer = require('./models/Offer');

const app = express();
const port = process.env.SERVER_PORT;
console.log(process.env.SERVER_PORT);
const dbUri = `mongodb://${process.env.SERVER}:${process.env.DB_PORT}/${process.env.DB_NAME}`;

app.use(express.json());

mongoose.connect(dbUri)
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('Could not connect to MongoDB:', err));

const getAllOfferList = async (req, res) => {
    try {
        const offers = await Offer.find();
        res.status(200).json(offers);
    } catch (err) {
        res.status(500).json({ message: 'Failed to retrieve offers', error: err.message });
    }
}

const getOfferListById = async (req, res) => {
    try {
        const offerId = req.params.id;

        // Validate if the ID is a valid ObjectId
        const validOfferId = ObjectId.isValid(offerId) ? new ObjectId(offerId) : offerId;

        // Find offer by ID
        const offer = await Offer.findById(validOfferId);
        if (!offer) {
            return res.status(404).json({
                status: 'failed',
                message: 'Offer not found'
            });
        }
        res.status(200).json({
          status: 'success',
          data: { offer }
        });
    } catch (err) {
        res.status(500).json({ message: 'Failed to retrieve offer', error: err.message });
    }
}

const createOfferList = async (req,res) => {
    try {
        const offer = new Offer(req.body);
        await offer.save();
        res.status(201).json(offer);
    } catch (err) {
        res.status(500).json({ message: 'Failed to create offer', error: err.message });
    }
}

const updateOfferList = async (req,res) => {
    try {
        const offer = await Offer.findByIdAndUpdate(req.params.id, req.body, { new: true });
        if (!offer) {
          return res.status(404).json({
            status: 'failed',
            message: 'Offer not found'
          });
        }
        res.json(offer);
    } catch (err) {
        res.status(500).json({ message: 'Failed to update offer', error: err.message });
    }
}

const deleteOfferList = async (req,res) => {
    try {
        const offer = await Offer.findByIdAndDelete(req.params.id);
        if (!offer) {
          return res.status(404).json({
            status: 'failed',
            message: 'Offer not found'
          });
        }
        res.status(204).end();
    } catch (err) {
        res.status(500).json({ message: 'Failed to delete offer', error: err.message });
    }
}

app.route('/api/v1/offers')
.get(getAllOfferList)
.post(createOfferList);

app.route('/api/v1/offers/:id')
.get(getOfferListById)
.put(updateOfferList)
.delete(deleteOfferList);

app.listen(port,()=>{
    console.log(`Server running on port ${port}...`);
});
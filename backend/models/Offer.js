const mongoose = require('mongoose');

const offerSchema = new mongoose.Schema({
  title: String,
  description: String,
  discountPercentage: Number,
  originalPrice: Number,
  discountedPrice: Number,
});

const Offer = mongoose.model('Offer', offerSchema);
module.exports = Offer;

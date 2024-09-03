const Offer = require('./models/Offer');

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
        const offer = await Offer.findById(req.params.id);
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

module.exports = {
    getAllOfferList,
    getOfferListById,
    createOfferList,
    updateOfferList,
    deleteOfferList
}
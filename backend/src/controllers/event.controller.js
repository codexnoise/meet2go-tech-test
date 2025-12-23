const EventService = require('../services/event.service');

/**
 * Controller to handle event-related HTTP requests.
 */
const getEvents = async (req, res) => {
    try {
        const data = await EventService.getAllEvents();
        return res.status(200).json({
            status: 'success',
            data: data
        });
    } catch (error) {
        return res.status(500).json({
            status: 'error',
            message: error.message
        });
    }
};

const buyTicket = async (req, res) => {
    try {
        const { eventId, quantity } = req.body;
        const result = await EventService.purchaseTicket(eventId, quantity);

        return res.status(200).json({
            status: 'success',
            data: result
        });
    } catch (error) {
        return res.status(400).json({
            status: 'error',
            message: error.message
        });
    }
};

module.exports = {
    getEvents,
    buyTicket
};
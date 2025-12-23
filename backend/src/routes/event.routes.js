const express = require('express');
const router = express.Router();
const eventController = require('../controllers/event.controller');
const { protect } = require('../middlewares/auth.middleware');

/**
 * GET /api/events - List all events
 * POST /api/events/purchase - Buy tickets for an event
 */
router.get('/', eventController.getEvents);
router.post('/purchase', protect, eventController.buyTicket);

module.exports = router;
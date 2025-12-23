const events = require('../models/event.model');

/**
 * Service to handle business logic for events and ticket purchases.
 */
class EventService {
    /**
     * Returns the list of all available events.
     */
    static async getAllEvents() {
        return events;
    }

    /**
     * Simulates a ticket purchase.
     * Decrements stock and validates availability.
     */
    static async purchaseTicket(eventId, quantity = 1) {
        const event = events.find(e => e.id === eventId);

        if (!event) {
            throw new Error('Event not found');
        }

        if (event.stock < quantity) {
            throw new Error('Insufficient stock for this event');
        }

        // Simulating persistence by updating the mock in memory
        event.stock -= quantity;

        return {
            message: 'Purchase completed successfully',
            eventTitle: event.title,
            remainingStock: event.stock
        };
    }
}

module.exports = EventService;
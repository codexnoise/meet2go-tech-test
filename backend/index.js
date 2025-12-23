// Load environment variables from .env file
require('dotenv').config();

const express = require('express');
const cors = require('cors');

// Import routes
const authRoutes = require('./src/routes/auth.routes');
const eventRoutes = require('./src/routes/event.routes');

/**
 * Initialize the Express application
 */
const app = express();
const PORT = process.env.PORT || 3000;

/**
 * Global Middlewares
 * CORS is enabled to allow communication with the Flutter frontend 
 */
app.use(cors());
app.use(express.json()); // Built-in middleware to parse JSON bodies

/**
 * API Routes
 * All authentication routes will be prefixed with /api/
 */
app.use('/api/auth', authRoutes);
app.use('/api/events', eventRoutes);

/**
 * Basic Health Check Route
 * Confirms the API is running correctly 
 */
app.get('/', (req, res) => {
    res.json({
        message: "Meet2Go API is running",
        environment: process.env.NODE_ENV
    });
});

/**
 * Start the server
 */
app.listen(PORT, () => {
    console.log(`🚀 Server is successfully running on port ${PORT}`);
    console.log(`Auth endpoints available at: http://localhost:${PORT}/api/auth/login`);
    console.log(`Events endpoints available at: http://localhost:${PORT}/api/events`);
});
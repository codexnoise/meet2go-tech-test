const jwt = require('jsonwebtoken');

/**
 * Middleware to protect routes by validating the JWT token.
 * Expects the token in the 'Authorization' header as 'Bearer <token>'.
 */
const protect = (req, res, next) => {
    let token;

    // Check for token in headers
    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
        token = req.headers.authorization.split(' ')[1];
    }

    if (!token) {
        return res.status(401).json({
            status: 'error',
            message: 'Not authorized, no token provided'
        });
    }

    try {
        // Verify token using the secret from .env
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        // Attach user info to the request object
        req.user = decoded;
        next();
    } catch (error) {
        return res.status(401).json({
            status: 'error',
            message: 'Not authorized, invalid or expired token'
        });
    }
};

module.exports = { protect };
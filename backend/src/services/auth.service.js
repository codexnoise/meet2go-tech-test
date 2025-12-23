const jwt = require('jsonwebtoken');
const users = require('../models/user.model');

/**
 * Service to handle the authentication business logic.
 */
class AuthService {
    /**
     * Validates user credentials and returns a JWT token.
     */
    static async login(email, password) {
        // Find user in the mocked array
        const user = users.find(u => u.email === email && u.password === password);

        if (!user) {
            throw new Error('Invalid email or password');
        }

        // Generate JWT Token based on environment configuration
        const token = jwt.sign(
            { id: user.id, email: user.email },
            process.env.JWT_SECRET,
            { expiresIn: process.env.JWT_EXPIRES_IN }
        );

        return {
            token,
            user: {
                id: user.id,
                email: user.email,
                name: user.name
            }
        };
    }
}

module.exports = AuthService;
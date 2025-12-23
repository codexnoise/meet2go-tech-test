const AuthService = require('../services/auth.service');

/**
 * Controller for Auth related requests.
 */
const login = async (req, res) => {
    try {
        const { email, password } = req.body;
        const result = await AuthService.login(email, password);

        return res.status(200).json({
            status: 'success',
            data: result
        });
    } catch (error) {
        return res.status(401).json({
            status: 'error',
            message: error.message
        });
    }
};

module.exports = {
    login
};
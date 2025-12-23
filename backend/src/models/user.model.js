/**
 * Mocked User Database
 * In a production environment, this would be replaced by a Database query.
 */
const users = [
    {
        id: "1",
        email: "admin@meet2go.com",
        password: "password123", // In production, this must be hashed
        name: "Test User"
    }
];

module.exports = users;
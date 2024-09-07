const express = require('express');
const router = express.Router();
const eventControllers = require('../controllers/eventControllers');

router.post('/register', eventControllers.registerEvent);
router.get('/event/:id', eventControllers.eventById);
router.get('/all', eventControllers.allEvents);

module.exports = router;
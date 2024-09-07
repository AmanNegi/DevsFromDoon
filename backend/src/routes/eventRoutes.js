const express = require('express');
const router = express.Router();
const eventControllers = require('../controllers/eventControllers');

router.post('/registerEvent', eventControllers.registerEvent);
router.get('/eventById', eventControllers.eventById);
router.get('/all', eventControllers.allEvents);
router.get('/eventsOfUser', eventControllers.eventsOfUser);

module.exports = router;
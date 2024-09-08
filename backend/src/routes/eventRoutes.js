const express = require('express');
const router = express.Router();
const eventControllers = require('../controllers/eventControllers');

router.post('/registerEvent', eventControllers.registerEvent);
router.get('/eventById', eventControllers.eventById);
router.get('/all', eventControllers.allEvents);
router.post('/eventsOfUser', eventControllers.eventsOfUser);
router.post('/eventsByManager', eventControllers.eventsByManager);

module.exports = router;

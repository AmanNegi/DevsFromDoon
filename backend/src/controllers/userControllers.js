const User = require('../models/User');
const Event = require('../models/Event');
const bcrypt = require('bcrypt')

exports.login = async (req, res) => {
	const { registrationNo, password } = req.body;
	if (!registrationNo || !password) {
		return res
			.status(400)
			.json({ message: 'Please provide registration number and password' });
	}

	try {
		const user = await User.findOne({ registrationNo });

		if (!user) {
			return res.status(404).json({ message: 'Invalid credentials' });
		}

		const isMatch = await bcrypt.compare(password, user.password);
		if (!isMatch) {
			return res.status(404).json({ message: 'Invalid credentials' });
		}

		return res.status(200).json({ message: 'Login successful', user });
	} catch (err) {
		return res.status(500).json({ message: err.message });
	}
};


exports.register = async (req, res) => {
    try {
        const user = new User(req.body);
        if(!user)return res.status(404).json({ message: 'Invalid Inputs' });
        await user.save();
        return res.status(200).json({ message: 'successfully saved' });
    } catch (err) {
        return res.status(500).json({ message: err.message });
    }

}

exports.registerForEvent = async (req, res) => {
    try{
        const eventId = req.body.eventId;
        const userId = req.body.userId;
        const event = await Event.findOne({_id:eventId});
        const user = await User.findOne({_id:userId});
        if(!event || !user)return res.status(404).json({ message: 'user or event Not found' });
        event.attendees.push(userId);
        user.eventsRegistered.push(eventId);
        await Promise.all([event.save(), user.save()]);
        return res.status(200).json({ message: 'successfully added', event, user });
    } catch (error){
        console.log(error.message);
        return res.status(500).json({ message:"error"});
    }
}
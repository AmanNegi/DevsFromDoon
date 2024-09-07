const User = require('../models/User');
const bcrypt = require("bcrypt");

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
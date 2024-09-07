const Event = require("../models/Event");
const User = require("../models/User");

exports.registerEvent = async (req, res) => {
	try {
		const id = req.body.id;
		console.log(id);
		const user = await User.findOne({ _id: id });
		if (user.role != "manager") {
			return res.status(400).send({ message: "You are not a Manager" });
		}
		req.body.createdBy = id;
		const event = new Event(req.body);
		await event.save();
		return res.status(201).send({ message: "Saved Succesfully!" });
	} catch (error) {
		return res.status(400).send(error);
	}
};

exports.eventById = async (req, res) => {
	try {
		const event = await Event.find({ _id: req.body.id });
		if (!event) {
			throw new Error("Event is missing");
		}
		console.log(event);
		return res.status(200).send(event);
	} catch (error) {
		return res.send(400).send();
	}
};

exports.allEvents = async (req, res) => {
	try {
		const events = await Event.find();
		if (!events) {
			return res.status(400).send("Error: No events exists");
		}
		return res.status(200).send({ events: events });
	} catch (error) {
		return res.status(400).send({message: error.message});
	}
};

exports.eventsOfUser = async (req, res) => {
    try {
        const userId = req.body.userId;
        if (!userId) {
            return res.status(400).json({ message: "User ID is required" });
        }
        const user = await User.findById(userId);

        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }

        if (user.eventsRegistered.length === 0) {
            return res.status(200).json({ message: "User has not registered for any events", events: [] });
        }

        const events = await Event.find({ _id: { $in: user.eventsRegistered } });

        res.status(200).json({ events });
    } catch (error) {
        console.error("Error in eventsOfUser:", error);
        res.status(500).json({ message: "Internal server error" });
    }
};
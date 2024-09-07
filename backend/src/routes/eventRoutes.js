const Event = require('../models/Event');
const Event = require('../models/User');

exports.registerEvent = async (req,res) => {
    try{
        const id = req.body.id;
        const user = User.find({_id : id});
        if(!(user.role === "manager")){
            return res.status(400).send({message:"You are not a Manager"});
        }
        const event = new Event(req.body);
        await event.save();
        return res.status(201).send({message:"Saved Succesfully!"});
    }catch(error){
        return res.status(400).send(error);
    }   
};


exports.eventById = async (req,res) => {
    try{
        const event = await Event.find({_id:req.body.id});
        if(!event){
            throw new Error("Event is missing");
        }
        return res.status(200).send(event);
    }catch(error){
        return res.send(400).send();
    }

};


exports.allEvents = async (req,res) => {
    try{
        const events = await Event.find();
        if(!events){
            return res.send(400).send();
        }
        return res.status(200).send({events:events});
    }catch(error){
        return res.send(400).send();
    }
};
import 'package:flutter/material.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.event.imageUrl),
          SizedBox(height: 0.02 * getHeight(context)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 5.0,
              children: [
                getChip(widget.event.paid ? "Paid" : "Free"),
                getChip(widget.event.paid ? widget.event.price.toString() : ""),
                getChip(widget.event.isLeaveProvided
                    ? "DL Provided"
                    : "No DL Provided"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(widget.event.description),
          ),
        ],
      ),
    );
  }

  Container getChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

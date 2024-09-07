import 'package:flutter/material.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/core/home/presentation/event_item.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: ListView(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          bottom: kToolbarHeight,
          top: 15.0,
        ),
        children: [
          getHeading("Registered Events"),
          EventItem(
            event: Event(
              name: "Event Name",
              description:
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              imageUrl:
                  "https://cdn0.weddingwire.in/vendor/3007/3_2/960/jpg/rock-music-event1_15_163007-163973098155561.jpeg",
              paid: true,
              price: 20,
              isLeaveProvided: true,
              venue: "LA",
              date: DateTime.now(),
            ),
          ),
          getHeading("Upcoming Events"),
          ...List.generate(
            4,
            (index) => EventItem(
              event: Event(
                name: "Event Name",
                description:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                imageUrl:
                    "https://cdn0.weddingwire.in/vendor/3007/3_2/960/jpg/rock-music-event1_15_163007-163973098155561.jpeg",
                paid: true,
                price: 20,
                isLeaveProvided: true,
                venue: "LA",
                date: DateTime.now(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getHeading(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

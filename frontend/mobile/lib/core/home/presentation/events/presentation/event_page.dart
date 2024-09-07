import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/core/home/presentation/event_item.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_manager.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_repository.dart';
import 'package:lpu_events/widgets/loading_widget.dart';

class EventPage extends ConsumerStatefulWidget {
  const EventPage({super.key});

  @override
  ConsumerState<EventPage> createState() => _EventPageState();
}

class _EventPageState extends ConsumerState<EventPage> {
  late EventsManager eventsManager;

  @override
  void initState() {
    eventsManager = EventsManager(context, ref);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.wait([
        eventsManager.getAllEvents(),
        eventsManager.getAllRegisteredEvents(),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: LoadingWidget(
        isLoading: eventsManager.isLoading,
        child: ListView(
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
            bottom: kToolbarHeight,
            top: 15.0,
          ),
          children: [
            if (ref.watch(eventRepository).myEvents.isNotEmpty)
              getHeading("Registered Events"),
            ...ref.watch(eventRepository).myEvents.map((e) {
              return EventItem(event: e);
            }).toList(),
            if (ref.watch(eventRepository).events.isNotEmpty)
              getHeading("Upcoming Events"),
            ...ref.watch(eventRepository).events.map((e) {
              return EventItem(
                event: e,
              );
            }).toList(),
          ],
        ),
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

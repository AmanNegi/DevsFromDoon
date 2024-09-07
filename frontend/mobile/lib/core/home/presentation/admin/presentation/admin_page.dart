import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/core/home/presentation/admin/presentation/add_event_page.dart';
import 'package:lpu_events/core/home/presentation/event_item.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_manager.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_repository.dart';
import 'package:lpu_events/globals.dart';

class AdminPage extends ConsumerStatefulWidget {
  const AdminPage({super.key});

  @override
  ConsumerState<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends ConsumerState<AdminPage> {
  late EventsManager eventsManager;

  @override
  void initState() {
    eventsManager = EventsManager(context, ref);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      eventsManager.getAllEventsOfManager();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: ListView(
              children: [
                getHeading("Your Events"),
                ...ref.watch(eventRepository).myEvents.map((e) {
                  return EventItem(
                    event: e,
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: kToolbarHeight + 10,
          child: FloatingActionButton.extended(
            elevation: 1,
            onPressed: () {
              goToPage(context, const AddItemPage());
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Event"),
          ),
        ),
      ]),
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

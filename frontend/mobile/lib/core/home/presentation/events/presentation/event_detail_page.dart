import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/colors.dart';
import 'package:lpu_events/core/form/presentation/form_page.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_manager.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_repository.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';
import 'package:lpu_events/widgets/action_button.dart';

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
        title: Text(widget.event.title),
      ),
      body: ListView(
        children: [
          Image.network(
            widget.event.imageUrl,
            height: 0.4 * getHeight(context),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 0.02 * getHeight(context)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 5.0,
              children: [
                getChip(widget.event.paid ? "Paid" : "Free"),
                if (widget.event.price! > 0)
                  getChip(
                      widget.event.price.toString()),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
                "Total Number of Attendees: ${widget.event.attendees.length}"),
          ),
          const SizedBox(height: 20),
          if (showRegisterButton())
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: ActionButton(
                isFilled: false,
                text: "Register",
                onPressed: () {
                  goToPage(context, FormPage(event: widget.event));
                },
              ),
            ),
        ],
      ),
    );
  }

  bool showRegisterButton() {
    print("Values ${appState.value.user!.id} || ${widget.event.createdBy}");
    if (widget.event.createdBy == appState.value.user!.id) {
      return false;
    } else if (widget.event.attendees.contains(appState.value.user!.id)) {
      return false;
    }

    return true;
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

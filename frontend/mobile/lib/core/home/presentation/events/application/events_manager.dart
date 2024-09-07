import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/core/home/presentation/events/application/events_repository.dart';
import 'package:lpu_events/globals.dart';
import "package:http/http.dart" as http;
import 'package:lpu_events/models/event.dart';

class EventsManager {
  final BuildContext context;
  final WidgetRef ref;

  EventsManager(this.context, this.ref);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<int> getAllEvents() async {
    ref.read(eventRepository).clearAllEvents();
    isLoading.value = true;
    final res = await http.get(Uri.parse("$API_URL/events/all"));

    final mappedBody = json.decode(res.body);
    List<Event> events = (mappedBody["events"] as List<dynamic>)
        .map((e) => Event.fromMap(e))
        .toList();
    print(events);
    ref.read(eventRepository).setEvents(events);

    isLoading.value = false;
    return 1;
  }

  Future<int> getAllEventsOfManager() async {
    final res =
        await http.post(Uri.parse("$API_URL/events/eventsByManager"), body: {
      "managerId": appState.value.user!.id,
    });

    final mappedBody = json.decode(res.body);
    print(mappedBody);
    List<Event> events = (mappedBody["events"] as List<dynamic>)
        .map((e) => Event.fromMap(e))
        .toList();

    ref.read(eventRepository).setMyEvents(events);
    return 1;
  }

  Future<int> getAllRegisteredEvents() async {
    final res =
        await http.post(Uri.parse("$API_URL/events/eventsOfUser"), body: {
      "userId": appState.value.user!.id,
    });
    print("Registered events");
    print(res.body);

    final mappedBody = json.decode(res.body);
    List<Event> events = (mappedBody["events"] as List<dynamic>)
        .map((e) => Event.fromMap(e))
        .toList();
      
    ref.read(eventRepository).setMyEvents(events);
    return 1;
  }
}

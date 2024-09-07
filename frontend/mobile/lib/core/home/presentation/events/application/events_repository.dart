import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/models/event.dart';
import "package:http/http.dart" as http;
import "package:lpu_events/globals.dart";

final eventRepository =
    ChangeNotifierProvider<EventsRepository>((ref) => EventsRepository());

class EventsRepository extends ChangeNotifier {
  List<Event> events = [];
  List<Event> myEvents = [];

  setEvents(List<Event> events) {
    this.events = events;
    notifyListeners();
  }

  setMyEvents(List<Event> events) {
    myEvents = events;
    notifyListeners();
  }

  clearAllEvents() {
    events = [];
    myEvents = [];
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/globals.dart';
import 'package:lpu_events/models/event.dart';
import "package:http/http.dart" as http;

class AddEventManager {
  Future<int> addEvent(Event event) async {
    try {
      final response = await http.post(
        Uri.parse("$API_URL/events/registerEvent"),
        body: {
          "title": event.title,
          "imageUrl": event.imageUrl,
          "description": event.description,
          "venue": event.venue,
          "createdBy": event.createdBy,
          "date": event.date.toString(),
          "price": event.price.toString(),
          "paid": event.paid.toString(),
          "isLeaveProvided": event.isLeaveProvided.toString(),
        },
      );

      if (response.statusCode == 200) {
        showToast("Event added successfully");
        return 1;
      } else {
        showToast("An error occurred while adding event! 2");
        return -1;
      }
    } catch (e) {
      showToast("An error occurred while adding event! 1");
      debugPrint(e.toString());
      return -1;
    }
  }
}

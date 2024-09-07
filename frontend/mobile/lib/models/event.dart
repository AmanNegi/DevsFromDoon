import 'dart:convert';

import 'package:flutter/widgets.dart';

class Event {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String venue;
  final String createdBy;
  final DateTime? date;
  final double? price;
  final bool paid;
  final bool isLeaveProvided;
  final List<String> attendees;

  Event({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.venue,
    required this.createdBy,
    this.date,
    this.price = 0.0,
    required this.paid,
    required this.isLeaveProvided,
    required this.attendees,
  });

  Event copyWith({
    String? id,
    String? title,
    String? imageUrl,
    String? description,
    String? venue,
    String? createdBy,
    ValueGetter<DateTime?>? date,
    ValueGetter<double?>? price,
    bool? paid,
    bool? isLeaveProvided,
    List<String>? registeredUsers,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      venue: venue ?? this.venue,
      date: date != null ? date() : this.date,
      price: price != null ? price() : this.price,
      paid: paid ?? this.paid,
      isLeaveProvided: isLeaveProvided ?? this.isLeaveProvided,
      createdBy: createdBy ?? this.createdBy,
      attendees: registeredUsers ?? attendees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'venue': venue,
      'date': date!.toIso8601String(),
      'price': price,
      'paid': paid,
      'isLeaveProvided': isLeaveProvided,
      'createdBy': createdBy,
      'attendees': attendees,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      venue: map['venue'] ?? '',
      date: map['date'] != null ? DateTime.parse(map['date']) : null,
      price: map["price"] != null ? map["price"] * 1.0 : 0.0,
      paid: map['paid'] ?? false,
      isLeaveProvided: map['isLeaveProvided'] ?? false,
      createdBy: map['createdBy'] ?? '',
      attendees: List<String>.from(map['attendees'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(id: $id, title: $title, imageUrl: $imageUrl, createdBy: $createdBy, description: $description, venue: $venue, date: $date, price: $price, paid: $paid, isLeaveProvided: $isLeaveProvided, attendees: $attendees)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.id == id &&
        other.title == title &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.venue == venue &&
        other.date == date &&
        other.price == price &&
        other.paid == paid &&
        other.isLeaveProvided == isLeaveProvided &&
        other.createdBy == createdBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        venue.hashCode ^
        date.hashCode ^
        price.hashCode ^
        paid.hashCode ^
        isLeaveProvided.hashCode ^
        createdBy.hashCode;
  }
}

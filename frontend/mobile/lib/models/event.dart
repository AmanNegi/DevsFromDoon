import 'dart:convert';

import 'package:flutter/widgets.dart';

class Event {
  final String name;
  final String imageUrl;
  final String description;
  final double? price;
  final bool paid;
  final bool isLeaveProvided;

  Event({
    required this.name,
    required this.imageUrl,
    required this.description,
    this.price = 0.0,
    required this.paid,
    required this.isLeaveProvided,
  });

  Event copyWith({
    String? name,
    String? imageUrl,
    String? description,
    ValueGetter<double?>? price,
    bool? paid,
    bool? isLeaveProvided,
  }) {
    return Event(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      price: price != null ? price() : this.price,
      paid: paid ?? this.paid,
      isLeaveProvided: isLeaveProvided ?? this.isLeaveProvided,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'paid': paid,
      'isLeaveProvided': isLeaveProvided,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble(),
      paid: map['paid'] ?? false,
      isLeaveProvided: map['isLeaveProvided'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Event(name: $name, imageUrl: $imageUrl, description: $description, price: $price, paid: $paid, isLeaveProvided: $isLeaveProvided)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event &&
        other.name == name &&
        other.imageUrl == imageUrl &&
        other.description == description &&
        other.price == price &&
        other.paid == paid &&
        other.isLeaveProvided == isLeaveProvided;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        imageUrl.hashCode ^
        description.hashCode ^
        price.hashCode ^
        paid.hashCode ^
        isLeaveProvided.hashCode;
  }
}

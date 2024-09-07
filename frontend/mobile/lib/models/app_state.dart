import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:lpu_events/models/user.dart';

class AppState {
  final bool isLoggedIn;
  final User? user;

  const AppState({
    this.isLoggedIn = false,
    required this.user,
  });

  factory AppState.initial() {
    return const AppState(
      user: null,
      isLoggedIn: false,
    );
  }

  AppState copyWith({
    bool? isLoggedIn,
    User? user,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isLoggedIn': isLoggedIn,
      'user': user?.toMap(),
    };
  }

  factory AppState.fromMap(Map<String, dynamic> map) {
    return AppState(
      isLoggedIn: map['isLoggedIn'] as bool,
      user: map['user'] != null
          ? User.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppState.fromJson(String source) =>
      AppState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AppState(isLoggedIn: $isLoggedIn, user: $user)';

  @override
  bool operator ==(covariant AppState other) {
    if (identical(this, other)) return true;

    return other.isLoggedIn == isLoggedIn && other.user == user;
  }

  @override
  int get hashCode => isLoggedIn.hashCode ^ user.hashCode;
}

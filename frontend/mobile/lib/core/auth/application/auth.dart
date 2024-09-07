import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/cache/app_cache.dart';
import 'package:lpu_events/core/auth/application/auth_repository.dart';
import 'package:lpu_events/globals.dart';
import "package:http/http.dart" as http;
import 'package:lpu_events/models/app_state.dart';
import 'package:lpu_events/models/user.dart';

class AuthManager {
  final BuildContext context;
  final WidgetRef ref;
  AuthManager(this.context, this.ref);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<int> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    ref.read(authProvider).clearUserData();
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse("$API_URL/users/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "registrationNo": email,
          "password": password,
        }),
      );
      isLoading.value = false;
      Map data = json.decode(response.body);

      if (response.statusCode == 200) {
        ref.read(authProvider).updateUserData(User.fromMap(data["user"]));
        return 1;
      } else {
        showToast(data["message"]);
        return -1;
      }
    } catch (error) {
      isLoading.value = false;
      showToast("An error occurred!");
      debugPrint(error.toString());
      return -1;
    }
  }
}

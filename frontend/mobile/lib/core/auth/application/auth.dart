import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lpu_events/globals.dart';
import "package:http/http.dart" as http;

class AuthManager {
  final BuildContext context;
  final WidgetRef ref;
  AuthManager(this.context, this.ref);

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<int> loginUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    // ref.read(authProvider).clearUserData();
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse("$API_URL/auth/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );
      isLoading.value = false;
      Map data = json.decode(response.body);

      if (data["statusCode"] == 200) {
        // ref.read(authProvider).updateUserData(User.fromMap(data["data"]));
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

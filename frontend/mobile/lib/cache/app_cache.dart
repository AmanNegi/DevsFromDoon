import 'package:flutter/material.dart';
import 'package:lpu_events/models/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<AppState> appState = ValueNotifier(AppState.initial());

class AppCache {
  final String _prefsKey = "lpu_events";

  getDataFromDevice() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString(_prefsKey);
    if (data == null) return;
    appState.value = (AppState.fromJson(data));
    debugPrint("Data From Device: $data");
  }

  saveDataToDevice() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_prefsKey, appState.value.toJson());
    debugPrint("Saved Data to Device...");
  }

  updateAppCache(AppState state) {
    appState.value = (AppState.fromMap(state.toMap()));
    saveDataToDevice();
  }

  clearAppCache() {
    appState.value = (AppState.initial());
    saveDataToDevice();
  }

  String getUserName() {
    if (appState.value.user == null) {
      return "NA";
    }
    return appState.value.user!.name;
  }

  String getEmail() {
    if (appState.value.user == null) {
      return "NA";
    }
    return appState.value.user!.email;
  }

  String getRegistrationNo() {
    if (appState.value.user == null) {
      return "NA";
    }
    return appState.value.user!.registrationNo;
  }

  bool isManager() {
    return appState.value.user!.role == "manager";
  }

  bool isLoggedIn() {
    if (appState.value.user == null || appState.value.user!.id == "") {
      return false;
    }

    return appState.value.isLoggedIn;
  }
}

AppCache appCache = AppCache();

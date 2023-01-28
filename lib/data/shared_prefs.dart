import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_vendor_app/models/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/* 
* Module responsible for storing user and app data to device
*/

ValueNotifier<AppData> appData = ValueNotifier<AppData>(AppData.empty());

class SharedPrefsHelper {
  SharedPreferences? _instance;
  init() async {
    _instance ??= await SharedPreferences.getInstance();
  }

  updateUserToDevice(AppData data) async {
    await init();
    await _instance!.setString('appData', json.encode(data.toJson()));
    appData.value = data;
  }

  getUserFromDevice() async {
    await init();
    if (_instance!.containsKey('appData')) {
      String? data = _instance!.getString('appData');
      debugPrint("Got User Data From Device $data");
      if (data != null && data.isNotEmpty) {
        Map session = json.decode(data);
        appData.value = AppData.fromJSON(session);
      }
    } else {
      updateUserToDevice(AppData.empty());
    }
  }
}

// Singleton instance
SharedPrefsHelper sharedPrefsHelper = SharedPrefsHelper();

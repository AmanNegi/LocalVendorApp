import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';

Color accentColor = Colors.deepPurple;
Color secondaryColor = const Color(0xFFfeebe4);
showToast(String msg) {
  Fluttertoast.showToast(msg: msg);
}

bool isOwner() => configs.value["ownerEmail"] == appData.value.email;

goToPage(BuildContext context, Widget destination, {bool clearStack = false}) {
  if (clearStack) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination), (route) => false);
  }
  return Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => destination));
}

getHeight(context) => MediaQuery.of(context).size.height;
getWidth(context) => MediaQuery.of(context).size.width;

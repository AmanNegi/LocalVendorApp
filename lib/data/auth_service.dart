import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/models/app_data.dart';
import 'package:local_vendor_app/models/shop_user.dart';
import 'package:uuid/uuid.dart';

import '../globals.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    try {
      //TODO:(AmanNegi) Validate incoming Input
      var result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      ShopUser? user = await cloudDatabase.getUser(email);

      if (user == null) {
        return null;
      }

      await sharedPrefsHelper.updateUserToDevice(
        AppData(
            userId: user.userId,
            name: user.name,
            isLoggedIn: true,
            isFirstTime: false,
            email: email),
      );
      return result.user;
    } on FirebaseException catch (error) {
      showToast(error.message.toString());
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUp(String email, String password) async {
    try {
      //TODO:(AmanNegi) Validate incoming Input
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      //TODO:(AmanNegi) Add Email Verification

      String id = const Uuid().v1();
      String name = "Name";
      await cloudDatabase.addUser(
        ShopUser(
          userId: id,
          name: name,
          email: email,
          isOwner: email == configs.value['ownerEmail'],
          orders: [],
        ),
      );

      await sharedPrefsHelper.updateUserToDevice(
        AppData(
            userId: id,
            name: name,
            isLoggedIn: true,
            isFirstTime: false,
            email: email),
      );

      return result.user;
    } catch (error) {
      if (error is PlatformException) {
        showToast(error.code.toString());
      }
      return null;
    }
  }
}

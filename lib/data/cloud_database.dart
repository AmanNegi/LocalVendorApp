import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/models/shop_user.dart';

class CloudDataBase {
  final FirebaseFirestore globalInstance = FirebaseFirestore.instance;

  late CollectionReference userCollection = globalInstance.collection("users");
  // The items a particular vendor is willing to offer
  late CollectionReference itemsCollection = globalInstance.collection("items");

// User Related Functions
  Future<bool> addUser(ShopUser user) async {
    try {
      await userCollection.doc(user.userId).set(user.toJson());
      return true;
    } catch (e) {
      showToast("An error occurred while adding the user");
      return false;
    }
  }

  Future<ShopUser?> getUser(String email) async {
    ShopUser? user;
    QuerySnapshot data =
        await userCollection.where("email", isEqualTo: email).snapshots().first;

    debugPrint("Got Data regarding user $email $data");

    user = ShopUser.fromJson(data.docs.first.data() as Map<String, dynamic>);

    return user;
  }

// Items Related Functions
  Future<bool> addItem(ShopItem item) async {
    try {
      await itemsCollection.doc(item.itemId).set(item.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot> getItems() {
    return itemsCollection.snapshots();
  }

Future<void> placeOrder(ShopItem item)async{

}

}


CloudDataBase cloudDatabase = CloudDataBase();

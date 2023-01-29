import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/cart_item.dart';
import 'package:local_vendor_app/models/message.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/models/shop_user.dart';
import 'package:local_vendor_app/models/user_order.dart';

// TODO: Create another classes to split code
class CloudDataBase {
  final FirebaseFirestore globalInstance = FirebaseFirestore.instance;

  late CollectionReference userCollection = globalInstance.collection("users");
  // The items a particular vendor is willing to offer
  late CollectionReference itemsCollection = globalInstance.collection("items");
  // Group Chat collection
  late CollectionReference chatCollection = globalInstance.collection("chat");

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

  Future<ShopUser?> getUserById(String id) async {
    ShopUser? user;
    QuerySnapshot data =
        await userCollection.where("userId", isEqualTo: id).snapshots().first;

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
    return itemsCollection.snapshots(includeMetadataChanges: true);
  }

  Future<bool> addProduct(ShopItem item) async {
    try {
      await itemsCollection.doc(item.itemId).set(item.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteItem(ShopItem item) async {
    return handleError(() async {
      await itemsCollection.doc(item.itemId).delete();
    });
  }

  Future<List<CartItem>> getCartItems() async {
    DocumentSnapshot data =
        await userCollection.doc(appData.value.userId).snapshots().first;
    return ShopUser.fromSnapshot(data)
        .cart
        .map((e) => CartItem.fromJson(e))
        .toList();
  }

  Future<bool> addItemToCart(CartItem item) async {
    try {
      bool exists = false;
      List<CartItem> data = await getCartItems();

      // If it exists, then update amount
      for (int i = 0; i < data.length; i++) {
        if (item.item.itemId == data[i].item.itemId) {
          exists = true;
          if (item.amount == 0) {
            // If exists and amount is zero delete it
            debugPrint("Removing Item");
            data.removeAt(i);
          } else {
            data[i].amount = item.amount;
            debugPrint("The Item Prexists in cart adding amount");
          }
        }
      }

      // Otherwise,add item to the list
      if (!exists) data.add(item);
      userCollection
          .doc(appData.value.userId)
          .update({"cart": data.map((e) => e.toJson()).toList()});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> getAllOrders() async {
    DocumentSnapshot data =
        await userCollection.doc(appData.value.userId).snapshots().first;
    return ShopUser.fromSnapshot(data).orders;
  }

  Future<void> placeOrder(UserOrder order) async {
    List<dynamic> data = await getAllOrders();
    data.add(order.toJson());
    await userCollection.doc(appData.value.userId).update({
      "orders": data,
    });
    showToast("Placed Order Successfully");
    await clearCart();
  }

  Future<void> clearCart() async {
    await userCollection.doc(appData.value.userId).update({"cart": []});
  }

  addChat(Message item) async {
    await chatCollection.doc(item.messageId).set(item.toJson());
  }

  Stream<QuerySnapshot> getChatStream() {
    return chatCollection.orderBy("listedAt", descending: true).snapshots();
  }

  bool handleError(Function fun) {
    try {
      fun();
      return true;
    } catch (e) {
      debugPrint("Error Occurred $e");
      return false;
    }
  }
}

CloudDataBase cloudDatabase = CloudDataBase();

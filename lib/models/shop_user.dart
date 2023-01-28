import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_vendor_app/models/cart_item.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/models/user_order.dart';

/*
* UserId is the documentid in the cloud_firestore
*/
class ShopUser {
  String userId;
  String name;
  String email;
  bool isOwner;
  List<UserOrder> orders;
  List<CartItem> cart;

  ShopUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.isOwner,
    required this.orders,
    required this.cart,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "name": name,
      "email": email,
      "isOwner": isOwner,
      "orders": orders,
      "cart": cart,
    };
  }

  factory ShopUser.fromJson(Map<String, dynamic> map) {
    return ShopUser(
      name: map["name"],
      email: map["email"],
      isOwner: map["isOwner"],
      orders: (map["orders"] as List<dynamic>)
          .map((e) => UserOrder.fromJson(e))
          .toList(),
      cart: (map["cart"] as List<dynamic>)
          .map((e) => CartItem.fromJson(e))
          .toList(),
      userId: map["userId"] ?? " ",
    );
  }
  factory ShopUser.fromSnapshot(DocumentSnapshot data) {
    ShopUser value = ShopUser.fromJson(data.data() as Map<String, dynamic>);
    value.userId = data.reference.id;
    return value;
  }

  @override
  String toString() {
    return "{-$name $isOwner-}";
  }
}

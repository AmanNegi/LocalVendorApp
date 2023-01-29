import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_vendor_app/models/cart_item.dart';
import 'package:local_vendor_app/models/user_order.dart';

/*
* UserId is the documentid in the cloud_firestore
*/
class ShopUser {
  String userId;
  String name;
  String email;
  bool isOwner;
  List<dynamic> orders;
  List<dynamic> cart;

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
      name: map["name"] ?? "",
      email: map["email"] ?? "",
      isOwner: map["isOwner"] ?? false,
      orders: (map["orders"]) ?? [],
      cart: (map["cart"]) ?? [],
      userId: map["userId"] ?? "",
    );
  }

  List<CartItem> getUserCart(Map<String, dynamic> map) {
    List<CartItem> userCart = [];
    List<dynamic> list = map["cart"];
    if (userCart.isEmpty) return userCart;

    for (var e in list) {
      userCart.add(CartItem.fromJson(e));
    }
    return userCart;
  }

  List<UserOrder> getUserOrders(Map<String, dynamic> map) {
    List<UserOrder> userOrders = [];
    List<dynamic> list = map["orders"];
    if (orders.isEmpty) return userOrders;

    for (var e in list) {
      userOrders.add(UserOrder.fromJson(e));
    }
    return userOrders;
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

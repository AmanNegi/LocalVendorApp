import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_vendor_app/models/shop_item.dart';

class CartItem {
  ShopItem item;
  int amount;

  CartItem({
    required this.item,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      "item": item.toJson(),
      "amount": amount,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
      item: ShopItem.fromJson(map["item"]),
      amount: map["amount"],
    );
  }
  factory CartItem.fromSnapshot(DocumentSnapshot data) {
    CartItem value = CartItem.fromJson(data.data() as Map<String, dynamic>);
    // value.itemId = data.reference.id;
    return value;
  }

  @override
  String toString() {
    return "{-$item $amount-}";
  }
}

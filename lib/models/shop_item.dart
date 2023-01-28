import 'package:cloud_firestore/cloud_firestore.dart';

class ShopItem {
  String itemId;
  String itemName;
  String description;
  String image;
  double price;
  DateTime listedAt;

  ShopItem({
    required this.price,
    required this.description,
    required this.itemId,
    required this.itemName,
    required this.image,
    required this.listedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "itemId": itemId,
      "itemName": itemName,
      "image": image,
      "listedAt": listedAt.millisecondsSinceEpoch,
      "price": price,
      "description": description,
    };
  }

  factory ShopItem.fromJson(Map<String, dynamic> map) {
    return ShopItem(
        itemId: map["itemId"],
        image: map["image"],
        itemName: map["itemName"],
        listedAt: DateTime.fromMicrosecondsSinceEpoch(map["listedAt"]),
        description: map["description"],
        price: (map["price"] * 1.0));
  }
  factory ShopItem.fromSnapshot(DocumentSnapshot data) {
    ShopItem value = ShopItem.fromJson(data.data() as Map<String, dynamic>);
    value.itemId = data.reference.id;
    return value;
  }

  @override
  String toString() {
    return "{-$itemId $itemName $price-}";
  }
}

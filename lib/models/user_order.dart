import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  String orderId;
  String userId;
  String userName;
  DateTime orderedAt;
  DateTime expectedBy;

  List<dynamic> images;
  List<dynamic> itemsId;

  UserOrder({
    required this.orderId,
    required this.userId,
    required this.userName,
    required this.orderedAt,
    required this.expectedBy,
    required this.images,
    required this.itemsId,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "orderId": orderId,
      "userName": userName,
      "images": images.map((e) => e.toString()).toList(),
      "itemsId": itemsId.map((e) => e.toString()).toList(),
      "orderedAt": orderedAt.millisecondsSinceEpoch,
      "expectedBy": expectedBy.millisecondsSinceEpoch,
    };
  }

  factory UserOrder.fromJson(Map<String, dynamic> map) {
    return UserOrder(
      userId: map["userId"],
      orderId: map["orderId"],
      userName: map["userName"],
      images: map["images"],
      itemsId: map["itemsId"],
      orderedAt: DateTime.fromMicrosecondsSinceEpoch(map["orderedAt"]),
      expectedBy: DateTime.fromMicrosecondsSinceEpoch(map["expectedBy"]),
    );
  }
  factory UserOrder.fromSnapshot(DocumentSnapshot data) {
    UserOrder value = UserOrder.fromJson(data.data() as Map<String, dynamic>);
    value.orderId = data.reference.id;
    return value;
  }

  @override
  String toString() {
    return "{-$userName $orderId }";
  }
}

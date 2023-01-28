import 'package:cloud_firestore/cloud_firestore.dart';

class UserOrder {
  String orderId;
  String userId;
  String productName;
  String userName;
  DateTime orderedAt;
  DateTime expectedBy;

  UserOrder({
    required this.orderId,
    required this.userId,
    required this.productName,
    required this.userName,
    required this.orderedAt,
    required this.expectedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "orderId": orderId,
      "userName": userName,
      "productName": productName,
      "orderedAt": orderedAt.millisecondsSinceEpoch,
      "expectedBy": expectedBy.millisecondsSinceEpoch,
    };
  }

  factory UserOrder.fromJson(Map<String, dynamic> map) {
    return UserOrder(
      userId: map["userId"],
      orderId: map["orderId"],
      userName: map["userName"],
      productName: map["productName"],
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
    return "{-$userName $productName-}";
  }
}

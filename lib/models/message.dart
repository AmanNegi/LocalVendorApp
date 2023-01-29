import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageId;
  String message;
  String senderId;
  String senderName;
  DateTime listedAt;

  Message({
    required this.messageId,
    required this.senderName,
    required this.message,
    required this.senderId,
    required this.listedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "senderId": senderId,
      "listedAt": listedAt.millisecondsSinceEpoch,
      "senderName": senderName,
      "messageId": messageId,
    };
  }

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      message: map["message"],
      senderId: map["senderId"],
      listedAt: DateTime.fromMicrosecondsSinceEpoch(map["listedAt"]),
      senderName: map["senderName"],
      messageId: map["messageId"] ?? "",
    );
  }
  factory Message.fromSnapshot(DocumentSnapshot data) {
    Message value = Message.fromJson(data.data() as Map<String, dynamic>);
    value.messageId = data.reference.id;
    return value;
  }

  @override
  String toString() {
    return "{-$message $senderId -}";
  }
}

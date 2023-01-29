import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/message.dart';
import 'package:local_vendor_app/widgets/message_item.dart';
import 'package:uuid/uuid.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Chat",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _buildMessagingLayout(),
    );
  }

  _buildMessagingLayout() {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          _getList(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    offset: const Offset(0.0, -5.0),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onTap: () async {},
                        controller: controller,
                        cursorRadius: const Radius.circular(20.0),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 5.0),
                          hintText: "Type your message.",
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Send',
                    icon: Icon(
                      Icons.send,
                      color: accentColor,
                    ),
                    onPressed: () async {
                      await cloudDatabase.addChat(Message(
                          messageId: const Uuid().v1(),
                          senderName: appData.value.name,
                          message: controller.text,
                          senderId: appData.value.userId,
                          listedAt: DateTime.now()));
                      controller.clear();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getList() {
    return StreamBuilder<QuerySnapshot>(
        stream: cloudDatabase.getChatStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              List<Message> messages = snapshot.data!.docs
                  .map((e) => Message.fromSnapshot(e))
                  .toList();

              return Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(bottom: 0.1 * getHeight(context)),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemBuilder: (context, index) {
                    return MessageItem(
                      message: messages[index],
                    );
                  },
                  itemCount: messages.length,
                ),
              );
            }
          }

          return Center(
            child: Image.asset(
              "assets/images/loading.gif",
              height: 100,
              width: 100,
            ),
          );
        });
  }
}

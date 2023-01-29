import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/message.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cloudDatabase.getUserById(message.senderId),
      builder: (context, snapshot) {
        debugPrint("Snapshot: ${snapshot.data}");
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            bool isOwnerMessage =
                snapshot.data!.email == configs.value['ownerEmail'];
            return message.senderId == appData.value.userId
                ? _getSelfMessageWidget(context, isOwnerMessage)
                : _getReceivedMessageWidget(context, isOwnerMessage);
          }
        }
        return const CircularProgressIndicator();
      },
    );
  }

  _getSelfMessageWidget(BuildContext context, bool isOwnerMessage) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              children: <Widget>[
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  constraints:
                      BoxConstraints(maxWidth: getWidth(context) * 0.7),
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 15.0,
                    right: 10.0,
                    bottom: 5.0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      color: isOwnerMessage ? bgColor : Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2.0,
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0.0, 0.0),
                            spreadRadius: 1.0)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(message.message),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(DateFormat.jm().format(message.listedAt.toLocal()),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      onTap: () {},
                      onDoubleTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getReceivedMessageWidget(BuildContext context, bool isOwnerMessage) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: getWidth(context) * 0.7),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: accentColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: isOwnerMessage
                            ? bgColor
                            : Theme.of(context).canvasColor,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20.0),
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        left: 10.0,
                        right: 15.0,
                        bottom: 5.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(message.message),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                              DateFormat.jm()
                                  .format(message.listedAt.toLocal()),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          onDoubleTap: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

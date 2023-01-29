import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/shop_user.dart';
import 'package:local_vendor_app/models/user_order.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

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
          "Your Orders",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream:
            cloudDatabase.userCollection.doc(appData.value.userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              List<dynamic> data = ShopUser.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>)
                  .orders;

              if (data.isEmpty) {
                return const Center(
                  child: Text("Your have no orders."),
                );
              }

              List<UserOrder> orderList = [];
              for (var e in data) {
                orderList.add(UserOrder.fromJson(e));
              }

              return ListView.builder(
                itemCount: orderList.length,
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                itemBuilder: (context, index) {
                  return Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5.0,
                            spreadRadius: 3.0,
                            offset: const Offset(5.0, 5.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      height: 0.25 * getHeight(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Order ID: ${orderList[index].orderId.substring(0, 15)}"),
                          SizedBox(
                            height: 0.15 * getHeight(context),
                            width: double.infinity, // color: Colors.green,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: orderList[index].images.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 8.0),
                                  width: 0.2 * getWidth(context),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      orderList[index].images[i],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Row(
                            children: [
                              const Text("Expected By:"),
                              const Spacer(),
                              Text(
                                DateFormat('dd-MM-y')
                                    .format(orderList[index].expectedBy)
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: accentColor,
                                ),
                              )
                            ],
                          ),
                        ],
                      ));
                },
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
        },
      ),
    );
  }
}

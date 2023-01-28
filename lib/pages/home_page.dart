import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/widgets/grid_item.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      floatingActionButton: isOwner() ? _getFAB() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0.05 * height),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    Text(
                      "Welcome to ${configs.value['shopName']}",
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Good Food.\nFast Delivery.",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: GoogleFonts.arvo().fontFamily,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: cloudDatabase.getItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      List<QueryDocumentSnapshot> list = snapshot.data!.docs;

                      return _getGridView(list);
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton _getFAB() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        // Take to add item page
        cloudDatabase.addItem(
          ShopItem(
              price: 250,
              description: "Description",
              itemId: const Uuid().v1(),
              itemName: "Name",
              image:
                  "https://firebasestorage.googleapis.com/v0/b/local-vendor-app.appspot.com/o/noodles.png?alt=media&token=101f135a-7e2c-4dd0-96e2-4458479f6df3",
              listedAt: DateTime.now()),
        );
      },
    );
  }

  _getGridView(List list) {
    return MasonryGridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          bottom: 30.0,
          top: 30.0,
        ),
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemCount: list.length,
        itemBuilder: (context, index) {
          ShopItem item =
              ShopItem.fromJson(list[index].data() as Map<String, dynamic>);
          return GridItem(item: item, index: Random().nextInt(100));
        });
  }
}

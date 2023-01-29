import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/pages/add_item_page.dart';
import 'package:local_vendor_app/widgets/drawer.dart';
import 'package:local_vendor_app/widgets/grid_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double height, width;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      drawer: const DrawerWidget(),
      floatingActionButton: isOwner() ? _getFAB() : null,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,
              child: Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(
                  "assets/images/semicircle.svg",
                  height: 0.2 * getHeight(context),
                  color: bgColor,
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: SvgPicture.asset(
                "assets/images/semicircle.svg",
                height: 0.15 * getHeight(context),
              ),
            ),
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.01 * height),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _key.currentState!.openDrawer();
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Image.asset(
                              "assets/images/drawer.png",
                              height: 60,
                              width: 30,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                      stream: cloudDatabase.itemsCollection
                          .snapshots(includeMetadataChanges: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data != null) {
                            List<QueryDocumentSnapshot> list =
                                snapshot.data!.docs;

                            return _getGridView(list);
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _getFAB() {
    return FloatingActionButton(
      backgroundColor: accentColor,
      child: const Icon(Icons.add),
      onPressed: () async {
        await goToPage(context, const AddItemPage());
        setState(() {});

        // );
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

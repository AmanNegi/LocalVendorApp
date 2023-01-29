import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/cart_item.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/pages/item_detail.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class GridItem extends StatelessWidget {
  final int index;
  final ShopItem item;

  const GridItem({
    super.key,
    required this.index,
    required this.item,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.5 * getWidth(context),
      height:
          index % 2 == 0 ? 0.2 * getHeight(context) : 0.3 * getHeight(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                goToPage(context, ItemDetailPage(item: item));
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(2.0),
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
                child: LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: Image.network(
                            item.image,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: Image.asset(
                                  "assets/images/loading.gif",
                                  height: 50,
                                  width: 50,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 0.5 * constraints.maxWidth,
                                  child: Text(
                                    item.itemName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: null,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "₹ ${item.price}",
                                  style: TextStyle(
                                      color: accentColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ]),
                    ],
                  );
                }),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () async {
                await cloudDatabase.addItemToCart(CartItem(
                  item: item,
                  amount: 1,
                ));
                showToast("Added to cart");
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                      offset: const Offset(0.0, 0.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Icon(
                  MdiIcons.cartPlus,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

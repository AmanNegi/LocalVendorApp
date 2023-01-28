import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_vendor_app/data/providers.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/shop_item.dart';
import 'package:local_vendor_app/widgets/action_button.dart';

class ItemDetailPage extends StatefulWidget {
  final ShopItem item;
  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  late ShopItem item;
  int amount = 1;
  @override
  void initState() {
    item = widget.item;
    super.initState();
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
          "Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0.05 * getHeight(context)),
                Container(
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Image.network(
                    item.image,
                    height: 0.5 * getHeight(context),
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 0.025 * getHeight(context)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 0.45 * getWidth(context),
                      child: Text(
                        item.itemName,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$ ${item.price}",
                      style: TextStyle(
                          fontSize: 25,
                          color: accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 0.01 * getHeight(context)),
                Text(
                  item.description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            height: 0.1 * getHeight(context),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            // color: Colors.red,
            child: Row(
              children: [
                Container(
                  width: 0.3 * getWidth(context),
                  height: 0.06 * getHeight(context),
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(30.0),
                  ),

                  // color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (amount == 0) {
                            showToast("Can not reduce below 0");
                            return;
                          }
                          amount--;
                          setState(() {});
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.4)),
                            padding: const EdgeInsets.all(5.0),
                            child: const Icon(Icons.remove)),
                      ),
                      Text(
                        "$amount",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (amount == 50) {
                            showToast("You can only order 50 items at a time");
                            return;
                          }
                          amount++;
                          setState(() {});
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.4)),
                            padding: const EdgeInsets.all(5.0),
                            child: const Icon(Icons.add)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 0.1 * getWidth(context)),
                Expanded(
                  child: Consumer(builder: (context, ref, child) {
                    return ActionButton(
                      text: "Add to Cart",
                      onPressed: () {
                        ref.read(cartProvider).addItem(item, amount);
                      },
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

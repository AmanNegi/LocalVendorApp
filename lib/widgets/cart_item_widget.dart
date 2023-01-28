import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/cloud_database.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/models/cart_item.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final Function updateAmount;
  const CartItemWidget({
    super.key,
    required this.item,
    required this.updateAmount,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int amount = 0;

  @override
  void initState() {
    amount = widget.item.amount;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      height: 0.15 * getHeight(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5.0,
            spreadRadius: 3.0,
            offset: const Offset(5.0, 5.0),
          )
        ],
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                widget.item.item.image,
                fit: BoxFit.contain,
                width: 0.3 * getWidth(context),
              ),
            ),
          ),
          SizedBox(width: 0.025 * getWidth(context)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.item.itemName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 0.05 * getHeight(context),
                width: 0.25 * getWidth(context),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: const Icon(Icons.remove),
                      onTap: () async {
                        if (amount > 0) {
                          amount--;
                          setState(() {});
                          await cloudDatabase.addItemToCart(
                            CartItem(
                              amount: amount,
                              item: widget.item.item,
                            ),
                          );
                        }
                      },
                    ),
                    Text("$amount"),
                    GestureDetector(
                      child: const Icon(Icons.add),
                      onTap: () async {
                        amount++;
                        await cloudDatabase.addItemToCart(
                          CartItem(
                            amount: amount,
                            item: widget.item.item,
                          ),
                        );
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            "₹ ${widget.item.item.price * amount}",
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          )
        ],
      ),
    );
  }
}

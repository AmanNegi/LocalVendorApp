import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_vendor_app/models/shop_item.dart';

final cartProvider = ChangeNotifierProvider((ref) => MyCartProvider());

class MyCartProvider extends ChangeNotifier {
  Set<ShopItem> items = {};
  Map<String, int> amounts = <String, int>{};

  void addItem(ShopItem item, int amount) {
    if (items.contains(item) && amounts.containsKey(item.itemId)) {
      amounts[item.itemId] = amount + amounts[item.itemId]!;
      notifyListeners();
      return;
    }
    items.add(item);
    amounts[item.itemId] = amount;
    notifyListeners();
  }
}

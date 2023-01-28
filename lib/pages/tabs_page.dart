import 'package:flutter/material.dart';
import 'package:local_vendor_app/pages/cart_page.dart';
import 'package:local_vendor_app/pages/home_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int tabIndex = 0;
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
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
        height: kToolbarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getBottomNavBarItem(0),
            _getBottomNavBarItem(1),
            _getBottomNavBarItem(2),
          ],
        ),
      ),
      body: PageView.builder(
        itemCount: 3,
        controller: controller,
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => tabs[index],
      ),
    );
  }

  _getBottomNavBarItem(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          tabIndex = index;
          setState(() {});
          controller.jumpToPage(index);
        },
        child: Container(
          color: Colors.transparent,
          child: Icon(
            index == tabIndex ? filledIcons[index] : outlineIcons[index],
          ),
        ),
      ),
    );
  }

  List<Widget> tabs = [
    const HomePage(),
    Container(
      color: Colors.red,
    ),
    const CartPage(),
  ];

  List<IconData> filledIcons = [
    MdiIcons.homeVariant,
    MdiIcons.searchWeb,
    MdiIcons.cart,
  ];
  List<IconData> outlineIcons = [
    MdiIcons.homeVariantOutline,
    Icons.search_outlined,
    MdiIcons.cartOutline,
  ];
}

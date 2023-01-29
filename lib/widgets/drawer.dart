import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_vendor_app/data/auth_service.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/pages/auth.dart';
import 'package:local_vendor_app/pages/cart_page.dart';
import 'package:local_vendor_app/pages/message_page.dart';
import 'package:local_vendor_app/pages/order_page.dart';
import 'package:local_vendor_app/pages/qr_page.dart';
import 'package:local_vendor_app/widgets/about_us.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),

          SizedBox(
            height: 0.2 * getHeight(context),
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: bgColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          appData.value.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Text(
                            configs.value["shopName"],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -0.03 * getHeight(context),
                  left: -10,
                  right: 0.2 * getWidth(context),
                  child: SvgPicture.asset(
                    "assets/images/drawerthread.svg",
                  ),
                ),
                Positioned(
                  top: 0.01 * getHeight(context),
                  right: 0,
                  child: Transform.rotate(
                    angle: pi,
                    child: SvgPicture.asset("assets/images/semicircle.svg"),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: 0.1 * getWidth(context),
                  child: SvgPicture.asset(
                    "assets/images/drawerthreadp2.svg",
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 0.025 * getHeight(context),
          ),
          _getListTile("Your Cart", MdiIcons.cart,
              () => goToPage(context, const CartPage())),

          _getListTile("Your Orders", MdiIcons.listStatus,
              () => goToPage(context, const OrderPage())),
          _getListTile("Book a table", MdiIcons.tableChair, () {}),
          _getListTile(
              "App QR",
              MdiIcons.qrcode,
              () => goToPage(
                    context,
                    const QrPage(),
                  )),
          _getListTile("Support", MdiIcons.chatOutline, () {
            goToPage(
              context,
              const MessagePage(),
            );
          }),

          _getListTile("Logout", MdiIcons.logout, () {
            authService.logOut();
            goToPage(context, const AuthPage(), clearStack: true);
          }),

          // _getListTile("My Orders", Icons.person_outline,
          //     () => goToPage(context, const EditProfilePage())),
          // _getListTile("Terms of use", Icons.gavel_outlined,
          //     () => goToPage(context, const TermsOfUsePage())),
          // _getListTile("Logout", Icons.logout_outlined, () async {
          // await apiHelper.signOut();
          // goToPage(context, const WelcomePage(), clearStack: true);
          // }),
          _getListTile("About", Icons.info_outline, () {
            showDialog(
                context: context, builder: (context) => const AboutUsDialog());
          }),
          const Spacer(),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(
                  "https://www.github.com/amannegi/local_vendor_app"));
            },
            child: Container(
              height: 0.075 * getHeight(context),
              color: Colors.black,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Interested in Codebase?",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    MdiIcons.github,
                    color: Colors.white,
                  ),
                ],
              )),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListTile(String text, IconData icon, Function onTap) {
    return ListTile(
      onTap: () => onTap(),
      leading: Icon(
        icon,
      ),
      minLeadingWidth: 20,
      title: Text(
        text,
        style: const TextStyle(),
      ),
    );
  }
}

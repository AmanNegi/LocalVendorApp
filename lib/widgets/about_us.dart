import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/globals.dart';

class AboutUsDialog extends StatelessWidget {
  const AboutUsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                "assets/images/loading.gif",
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(height: 20),
            Chip(
              backgroundColor: accentColor,
              label: Text(
                configs.value["shopName"],
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(configs.value["shopDescription"]),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

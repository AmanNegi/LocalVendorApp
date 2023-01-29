import 'package:flutter/material.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/widgets/action_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
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
          "Shop QR",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: configs.value["shopName"].toString(),
                foregroundColor: accentColor,
              ),
              SizedBox(height: 0.025 * getHeight(context)),
              const Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 0.025 * getHeight(context)),
              ActionButton(
                text: "Share the Link",
                fillColor: Colors.black,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

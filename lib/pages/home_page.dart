import 'package:flutter/material.dart';
import 'package:local_vendor_app/globals.dart';

import '../data/shared_prefs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isOwner()
          ? FloatingActionButton(
              onPressed: () {
                // Take to add item page
              },
            )
          : null,
      body: Column(
        children: [Text("Hello ${appData.value.name}")],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/pages/auth.dart';
import 'package:local_vendor_app/pages/home_page.dart';
import 'package:local_vendor_app/pages/tabs_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefsHelper.getUserFromDevice();
  configs.value = await getMockData();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: configs.value['shopName'],
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: appData.value.isLoggedIn ? const HomePage() : const AuthPage(),
    );
  }
}

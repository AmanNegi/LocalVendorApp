import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_vendor_app/data/configs.dart';
import 'package:local_vendor_app/data/shared_prefs.dart';
import 'package:local_vendor_app/pages/auth.dart';
import 'package:local_vendor_app/pages/home_page.dart';
import 'package:local_vendor_app/secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefsHelper.getUserFromDevice();
  configs.value = await getConfigsData();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: secrets["apiKey"]!,
        projectId: secrets["projectId"]!,
        appId: secrets["appId"]!,
        messagingSenderId: secrets["messagingSenderId"]!,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
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
      debugShowCheckedModeBanner: false,
      title: configs.value['shopName'],
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: appData.value.isLoggedIn ? const HomePage() : const AuthPage(),
    );
  }
}

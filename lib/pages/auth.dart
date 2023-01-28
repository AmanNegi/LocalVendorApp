import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_vendor_app/data/auth_service.dart';
import 'package:local_vendor_app/globals.dart';
import 'package:local_vendor_app/pages/home_page.dart';
import 'package:local_vendor_app/widgets/action_button.dart';

class AuthPage extends StatefulWidget {
  static const String route = "/LoginPage";

  const AuthPage({super.key});
  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  String email = "", password = "";
  late double height, width;
  bool isLogin = true;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: bgColor)),
            Positioned(
              top: 0.1 * height,
              left: 0,
              child: SvgPicture.asset("assets/images/semicircle.svg"),
            ),
            Positioned(
              top: 0.1 * height,
              right: 0,
              child: Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(
                  "assets/images/semicircle.svg",
                  width: 0.5 * width,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
            Positioned(
              left: -2,
              right: -2,
              bottom: 0.2 * height,
              child: SvgPicture.asset("assets/images/thread.svg"),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                      elevation: 20,
                      shadowColor: Colors.white30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Enter your credentials",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                )),
                            const SizedBox(height: 12),
                            _buildTextField("Email", (e) => email = e.trim()),
                            _buildTextField(
                                "Password", (e) => password = e.trim()),
                            const SizedBox(height: 20),
                            ActionButton(
                              onPressed: () async {
                                if (isLogin) {
                                  var res =
                                      await authService.login(email, password);
                                  if (res != null && mounted) {
                                    goToPage(context, const HomePage());
                                  }
                                } else {
                                  var res =
                                      await authService.signUp(email, password);
                                  if (res != null && mounted) {
                                    goToPage(context, const HomePage());
                                  }
                                }
                              },
                              text: isLogin ? "Login" : "Signup",
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                setState(() => isLogin = !isLogin);
                              },
                              child: RichText(
                                text: TextSpan(
                                    style: GoogleFonts.poppins(),
                                    children: [
                                      TextSpan(
                                          text: isLogin
                                              ? "Don't have an account?"
                                              : "Already have an account?",
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      TextSpan(
                                          text: isLogin
                                              ? " Sign Up now"
                                              : "Login",
                                          style: TextStyle(color: accentColor))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTextField(String text, Function onChange) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextField(
          onChanged: (e) => onChange(e),
          decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 20.0)),
        ),
      ),
    );
  }
}

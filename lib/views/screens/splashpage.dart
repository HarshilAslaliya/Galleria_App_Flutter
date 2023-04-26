import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallery_app/views/screens/homepage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(),)));
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.35,
            ),
            Image(
              image: AssetImage('assets/images/logo.png'),
              height: 100,
            ),
            SizedBox(
              height: size.height * 0.2,
            ),
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: Colors.blueAccent,
              size: size.height * 0.06,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Hero(
              tag: 'title',
              child: Text(
                "Galleria",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  fontSize: 45,
                      color: Get.isDarkMode?Colors.white24:Colors.black26,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

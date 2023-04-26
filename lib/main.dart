import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/views/screens/download_page.dart';
import 'package:gallery_app/views/screens/homepage.dart';
import 'package:gallery_app/views/screens/splashpage.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      defaultTransition: Transition.fade,
      initialRoute: '/splash_page',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/download_page',
          page: () => DownloadPage(),
        ),
        GetPage(
          name: '/splash_page',
          page: () => SplashPage(),
        ),
      ],
    );
    //   MaterialApp(
    //   theme: ThemeData(useMaterial3: true),
    //   debugShowCheckedModeBanner: false,
    //   initialRoute: 'splash_page',
    //   routes: {
    //     '/': (context) => HomePage(),
    //     'download_page': (context) => DownloadPage(),
    //     'splash_page': (context) => SplashPage(),
    //   },
    // );
  }
}

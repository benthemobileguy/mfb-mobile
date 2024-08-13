import 'package:flutter/material.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.introRoute,
      routes: AppPages.routes,
    );
  }
}

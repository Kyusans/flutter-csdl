import 'package:flutter/material.dart';
import 'package:flutter_csdl/login.dart';
import 'package:flutter_csdl/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // dark mode lang sah, kay sakit sa mata ang light mode hehe
      // theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const QrScanner(),
    );
  }
}

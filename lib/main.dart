import 'package:flutter/material.dart';
import 'pages/authentication_page.dart';

void main() {
  runApp(const Lawod());
}

class Lawod extends StatelessWidget {
  const Lawod({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationPage(),
    );
  }
}
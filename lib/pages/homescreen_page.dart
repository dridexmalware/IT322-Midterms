import 'package:flutter/material.dart';
import 'package:lawod/components/snapping_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1100), // Adjust this value as needed
            child: SnappingList(),
          ),
        ),
      ),
    );
  }
}

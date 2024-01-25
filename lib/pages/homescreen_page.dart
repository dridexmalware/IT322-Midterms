import 'package:flutter/material.dart';
import 'package:lawod/components/snapping_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        SnappingList(),
      ),
    );
  }
}

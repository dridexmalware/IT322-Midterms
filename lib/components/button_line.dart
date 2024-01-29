import 'package:flutter/material.dart';

class LawodButtonLine extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const LawodButtonLine({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(
            color: Color(0xFF196DFF), // Specify the border color here
          ),
        ),
        fixedSize: const Size(
          332, 60,
        ),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: Color(0xFF196DFF),
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Proxima Nova',
        ),
        child: child,
      ),
    );
  }
}
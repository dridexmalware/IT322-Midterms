import 'package:flutter/material.dart';

class LawodButtonFill extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const LawodButtonFill({
    Key? key,
    this.onPressed,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF196DFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fixedSize: const Size(
          332, 60,
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: 'Proxima Nova',
        ),
        child: child,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class LawodTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const LawodTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        child: TextField(
          focusNode: focusNode,
          controller: controller,
          obscureText: obscureText,
          onTap: () {
            controller.clear();
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.50,
                color: Color(0xFF828282),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 0.50,
                color: Color(0xFF196DFF),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: hintText,
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

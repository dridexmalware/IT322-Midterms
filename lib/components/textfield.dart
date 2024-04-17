import 'package:flutter/material.dart';

class LawodTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const LawodTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onTap: () {
          if (controller.text.isEmpty) {
            controller.clear();
          }
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
          hintText: '',
          labelText: controller.text.isEmpty ? hintText : '',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        style: const TextStyle(
          fontSize: 18,
          fontFamily: 'Proxima Nova',
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}

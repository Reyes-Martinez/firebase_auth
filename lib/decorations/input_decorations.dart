import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecorations(
      {
      // required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 168, 89, 36))),
        focusedBorder: const UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 168, 89, 36), width: 2)),
        // hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: const Color.fromARGB(255, 124, 79, 47))
            : null);
  }
}

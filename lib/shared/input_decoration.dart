import 'package:flutter/material.dart';

InputDecoration buildInputDecoration({String hintText}) {
  return InputDecoration(
    filled: true,
    hintText: hintText,
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}

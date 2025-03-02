import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSuccessMessage(BuildContext context, message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFailMessage(BuildContext context, message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

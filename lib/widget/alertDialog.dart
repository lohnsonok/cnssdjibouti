import 'package:flutter/material.dart';

class MAlertDialog
{
  static show(String text, BuildContext context)
  {
    AlertDialog dialog = AlertDialog(
      title: const Text('Info'),
      content: Text(text),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
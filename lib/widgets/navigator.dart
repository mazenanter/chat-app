import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future navigateTo(context, widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

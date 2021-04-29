import 'package:flutter/material.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content,
      {SnackBarAction snackBarAction}) {
    final SnackBar snackBar = SnackBar(
        action: snackBarAction,
        backgroundColor:
            Theme.of(context).accentColor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

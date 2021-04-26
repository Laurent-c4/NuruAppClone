import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nuru_clone_app/main.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';
import 'package:nuru_clone_app/widget/change_theme_button_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
        ? 'This is a demonstration of Dark Theme'
        : 'This is a demonstration of Light Theme';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(MyApp.title),
        actions: [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: Center(
        child: Text(
          'Hello $text!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

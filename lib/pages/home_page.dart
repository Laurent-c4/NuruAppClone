import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/pages/posts_page.dart';
import 'package:nuru_clone_app/widgets/change_theme_button_widget.dart';

import 'package:nuru_clone_app/widgets/post_item.dart';
import 'package:nuru_clone_app/widgets/simple_recorder.dart';
import 'package:provider/provider.dart';
import 'package:nuru_clone_app/main.dart';
import 'package:nuru_clone_app/pages/profile_page.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';

import '../widgets/navigationbar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          backgroundColor: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
              ? Theme.of(context).disabledColor
              : Theme.of(context).primaryColor,
          // leading: Icon(Icons.menu),
          title: Text(MyApp.title, style: TextStyle(color: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
              ? Theme.of(context).primaryColor
              : Colors.white,),),
          elevation: 0,
          actions: [
            ChangeThemeButtonWidget(),
          ],
        ),
      body: SizedBox.expand(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              PostsPage(),
              SimpleRecorder(),
              ProfilePage(),
              Container(color: Colors.red,),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('My Posts'),
              icon: Icon(Icons.home),activeColor: Theme.of(context).primaryColor
          ),
          BottomNavyBarItem(
              title: Text('New Post'),
              icon: Icon(Icons.add),activeColor: Theme.of(context).primaryColor
          ),
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person),activeColor: Theme.of(context).primaryColor
          ),
          BottomNavyBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings),activeColor: Theme.of(context).primaryColor
          ),
        ],
      ),
    );
  }
}


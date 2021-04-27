import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/pages/posts_page.dart';
import 'package:nuru_clone_app/widgets/change_theme_button_widget.dart';
import 'package:nuru_clone_app/widgets/post_item.dart';
import 'package:provider/provider.dart';
import 'package:nuru_clone_app/main.dart';
import 'package:nuru_clone_app/pages/profile_page.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';

import '../widgets/navigationbar_widget.dart';

// class HomePage extends StatelessWidget {
//   // @override
//   // Widget build(BuildContext context) => Scaffold(
//   //       appBar: AppBar(
//   //         iconTheme: Theme.of(context).iconTheme,
//   //         backgroundColor: Colors.transparent,
//   //         leading: Icon(Icons.menu),
//   //         title: Text(MyApp.title),
//   //         elevation: 0,
//   //         actions: [
//   //           ChangeThemeButtonWidget(),
//   //         ],
//   //       ),
//   //       body: ProfileWidget(),
//   //       extendBody: true,
//   //       bottomNavigationBar: NavigationBarWidget(),
//   //     );
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   final text = Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark
//   //       ? 'This is a demonstration of Dark Theme'
//   //       : 'This is a demonstration of Light Theme';
//   //
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       backgroundColor: Colors.orange,
//   //       title: Text(MyApp.title),
//   //       actions: [
//   //         ChangeThemeButtonWidget(),
//   //       ],
//   //     ),
//   //     body: Center(
//   //       child: Text(
//   //         'Hello $text!',
//   //         style: TextStyle(
//   //           fontSize: 32,
//   //           fontWeight: FontWeight.bold,
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }

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
          backgroundColor: Colors.transparent,
          leading: Icon(Icons.menu),
          title: Text(MyApp.title),
          elevation: 0,
          actions: [
            ChangeThemeButtonWidget(),
          ],
        ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            PostsPage(),
            Container(color: Colors.red,),
            ProfilePage(),
            Container(color: Colors.red,),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('My Posts'),
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('New Post'),
              icon: Icon(Icons.add)
          ),
          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.person)
          ),
          BottomNavyBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuru_clone_app/pages/home_page.dart';
import 'package:nuru_clone_app/pages/login_page.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';
import 'package:nuru_clone_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Specifies the set of orientations the application interface can
  /// be displayed in.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'Nuru App Clone';

  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    builder: (context, _) {
      final themeProvider = Provider.of<ThemeProvider>(context);

      return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text("Oops"));
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                Provider<AuthenticationService>(
                    create: (_) =>
                        AuthenticationService(FirebaseAuth.instance)),
                StreamProvider(
                  create: (context) => context
                      .read<AuthenticationService>()
                      .authStateChanges,
                )
              ],
              child: MaterialApp(
                title: title,
                themeMode: themeProvider.themeMode,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                home: AuthenticationWrapper(),
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: Text("Loading"));
        },
      );
    },
  );
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser != null) {
      return HomePage();
    }
    return LoginPage();
  }
}

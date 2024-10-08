import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postalhub_client/auth/auth_page.dart';
import 'package:postalhub_client/src/postalhub_ui.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'auth/auth_service.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity, // For Android
    appleProvider: AppleProvider.appAttest, // For iOS
  );

  // Set the system navigation bar color to transparent
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    systemNavigationBarIconBrightness:
        Brightness.dark, // navigation bar icon color
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
      return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'GoogleSans',
            colorScheme: lightDynamic ?? lightColorScheme,
          ),
          darkTheme: ThemeData(
            fontFamily: 'GoogleSans',
            colorScheme: darkDynamic ?? darkColorScheme,
          ),
          home: const AuthPage(),
        ),
      );
    });
  }
}

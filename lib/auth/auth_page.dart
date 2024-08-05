import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:postalhub_client/auth/new_login/login.dart';
import 'package:postalhub_client/src/navigator/navigator_services.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const AppNavigatorServices();
            } else {
              return const LoginScreenNew();
            }
          }),
    );
  }
}

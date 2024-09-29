// ignore_for_file: use_build_context_synchronously, duplicate_ignore, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:postalhub_client/auth/new_register/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:postalhub_client/src/navigator/navigator_services.dart';

class LoginScreenNew extends StatefulWidget {
  const LoginScreenNew({super.key});

  @override
  State<LoginScreenNew> createState() => _LoginScreenNewState();
}

class _LoginScreenNewState extends State<LoginScreenNew> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void emailErrorState() {
    Navigator.pop(context); // Close any existing dialogs
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('User not found'),
              actions: [
                TextButton(
                  onPressed: () {
                    // Close the dialog using the dialog's context
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void passwordErrorState() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Ops incorrect password'),
          );
        });
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      // 1. Request notification permission before login
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('User granted permission');
        }
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        if (kDebugMode) {
          print('User granted provisional permission');
        }
      } else {
        if (kDebugMode) {
          print('User declined or has not accepted permission');
        }

        // You might want to handle this case, maybe show a message to the user
      }

      // 2. Proceed with login
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      String? fcmToken = await FirebaseMessaging.instance.getToken();
      if (fcmToken != null) {
        await FirebaseFirestore.instance
            .collection('client_user') // Assuming you have a 'users' collection
            .doc(userCredential
                .user!.uid) // Use the user's UID as the document ID
            .set({
          'fcmToken': fcmToken
        }, SetOptions(merge: true)); // Merge to avoid overwriting other data
      }
      // Navigation   only happens if login is successful

      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppNavigatorServices()),
          (route) => false, // Remove all previous routes
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User not found')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Incorrect password')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _resetPassword() async {
    String email = _emailController.text.trim();
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Password reset email sent! Check your inbox')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    //final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
        body: Stack(
      children: [
        // Container(
        //  height: size.height - 200,
        //   color: Theme.of(context).colorScheme.primary,
        // ),
        // AnimatedPositioned(
        //  duration: const Duration(milliseconds: 100),
        //   curve: Curves.easeOutQuad,
        //   top: keyboardOpen ? -size.height / 10 : 0.0,
        //  child: WaveWidget(
        //    size: size,
        //     yOffset: size.height / 5.0,
        //     color: Theme.of(context).colorScheme.surface,
        //   ),
        // ),
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Material(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                hintText: 'Email',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: const Icon(Icons.password_rounded),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                  child: IconButton(
                                    onPressed: _toggleObscured,
                                    icon: Icon(
                                      _obscured
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                hintText: 'Password',
                              ),
                              obscureText: _obscured,
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Card(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: SizedBox(
                                    child: Column(
                                  children: [
                                    isLoading
                                        ? const CircularProgressIndicator()
                                        : ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight: Radius.circular(15),
                                            ),
                                            child: Material(
                                              color: const Color.fromARGB(
                                                  0, 255, 193, 7),
                                              child: InkWell(
                                                onTap: login,
                                                child: const Padding(
                                                  padding: EdgeInsets.only(
                                                    top: 15,
                                                    bottom: 15,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        //width: MediaQuery.of(context).size.width - 180,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(),
                                                                        child: Text("Login",
                                                                            style: TextStyle(
                                                                              fontWeight: FontWeight.w600,
                                                                            ))))
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                )),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Forgot password?"),
                            TextButton(
                                onPressed: _resetPassword,
                                child: const Text('Recover your password')),
                            const SizedBox(height: 5),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Doesn't have an account yet?"),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Card(
                                //color: Theme.of(context).colorScheme.surfaceVariant,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: SizedBox(
                                    child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      ),
                                      child: Material(
                                        color: const Color.fromARGB(
                                            0, 255, 193, 7),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegisterScreenNew()),
                                            );
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                              top: 15,
                                              bottom: 15,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                  //width: MediaQuery.of(context).size.width - 180,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                              child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(),
                                                                  child: Text(
                                                                      "Register Now",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ))))
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              )
            ])
      ],
    ));
  }
}

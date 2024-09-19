// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:postalhub_client/pages/ask_ai_services/ask_ai_module.dart';
import 'package:shimmer/shimmer.dart';

class AskAi extends StatefulWidget {
  const AskAi({super.key});

  @override
  State<AskAi> createState() => _AskAiState();
}

class _AskAiState extends State<AskAi> {
  final user = FirebaseAuth.instance.currentUser!;

  String? firstname;
  String? lastname;
  String? email;
  String? hostelAddress;
  String? phoneNo;
  String? companyName;
  String? companyEmail;
  String? companyId;
  String? profilePic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                right: 0,
                //left: 15,
                //top: 5,
                //bottom: 2,
              ),
              child: Text("Ask AI by "),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
              ),
              child: Shimmer.fromColors(
                direction: ShimmerDirection.ltr,
                period: const Duration(milliseconds: 3000),
                baseColor: const Color.fromARGB(255, 106, 147, 252),
                highlightColor: const Color.fromARGB(255, 242, 106, 88),
                child: const Text(
                  '✨Gemini',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Flexible(fit: FlexFit.tight, child: SizedBox()),
          ],
        ),
      ),
      body: const AskAiChatUi(),
    );
  }
}

import 'package:flutter/material.dart';

class MyParcel extends StatefulWidget {
  const MyParcel({super.key});
  @override
  State<MyParcel> createState() => _MyParcelState();
}

class _MyParcelState extends State<MyParcel> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            child: Image.asset(
              "assets/gif/coming_soon.gif",
            ),
          ),
          const Text('Coming soon'),
        ],
      ),
    );
  }
}

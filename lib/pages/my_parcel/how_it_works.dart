import 'package:flutter/material.dart';

class HowItWorks extends StatefulWidget {
  const HowItWorks({super.key});
  @override
  State<HowItWorks> createState() => _HowItWorksState();
}

class _HowItWorksState extends State<HowItWorks> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Scaffold(
      appBar: AppBar(
        title: const Text("How it works?"),
        centerTitle: true,
      ),
      body: Center(
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
      ),
    );
  }
}

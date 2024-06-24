import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/my_parcel/how_it_works.dart';

class MyParcel extends StatefulWidget {
  const MyParcel({super.key});
  @override
  State<MyParcel> createState() => _MyParcelState();
}

class _MyParcelState extends State<MyParcel> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Parcel"),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.info_rounded,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HowItWorks()),
                  );
                },
                tooltip: 'How it works?',
              ))
        ],
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

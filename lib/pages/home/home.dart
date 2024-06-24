import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/home/home_services/carousel.dart';
import 'package:postalhub_client/pages/home/home_services/newsletter_brief.dart';
import 'package:postalhub_client/pages/home/home_services/queue_ms.dart';
import 'package:postalhub_client/pages/profiler_service/profile_overview_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // ... other widget code

    return Scaffold(
        appBar: AppBar(
          //toolbarHeight: 80,
          //elevation: 3,
          title: Row(children: [
            Image.asset(
              'assets/images/ic_launcher.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            const Text('  Postal Hub'),
          ]),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    size: 28,
                  ),
                  onPressed: () {},
                  tooltip: 'Notification',
                ))
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          children: const [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Carousel(),
                    HomeProfileOverview(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Ready to pickup?')],
                    ),
                    QueueMs(),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('Notification/Newsletter')],
                    ),
                    NewsletterBrief(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ],
        ));
  }
}

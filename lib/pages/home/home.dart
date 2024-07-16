import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/home/home_services/carousel.dart';
//import 'package:postalhub_client/pages/home/home_services/newsletter_brief.dart';
import 'package:postalhub_client/pages/home/home_services/homescreen_widgets.dart';
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
        //backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
                    HomeProfileOverview(),
                    SizedBox(
                      height: 10,
                    ),
                    Carousel(),
                    //HomeProfileOverview(),
                    SizedBox(
                      height: 10,
                    ),
                    QueueMs(),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
          ],
        ));
  }
}

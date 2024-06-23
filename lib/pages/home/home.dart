import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/home/home_services/carousel.dart';
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

    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      children: const [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              children: [
                Carousel(),
                HomeProfileOverview(),
                QueueMs(),
              ],
            )),
      ],
    );
  }
}

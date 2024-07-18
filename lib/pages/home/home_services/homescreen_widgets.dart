// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueueMs extends StatefulWidget {
  const QueueMs({super.key});
  @override
  State<QueueMs> createState() => _QueueMsState();
}

class _QueueMsState extends State<QueueMs> {
  final _firestore = FirebaseFirestore.instance;
  int _parcelCount = 0;

  @override
  void initState() {
    super.initState();
    _fetchParcelCount();
  }

  Future<void> _fetchParcelCount() async {
    final querySnapshot = await _firestore
        .collection('parcelInventory')
        .where('ownerId', isEqualTo: '20000382')
        .where('status', isEqualTo: 'ARRIVED-SORTED')
        .get();

    setState(() {
      _parcelCount = querySnapshot.size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width:
                            (MediaQuery.sizeOf(context).width - 20) * (11 / 20),
                        height: 195,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Material(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 16,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        child: Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0),
                                                        child: Text(
                                                          "Queue System",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0),
                                                        child: Text(
                                                          "Coming Soon",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .social_distance_rounded,
                                                          size: 50,
                                                        ),
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Column(
                                                        children: [
                                                          Text('Your number'),
                                                          Text('13'),
                                                          Text('Queue Number'),
                                                          Text('8')
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width:
                            (MediaQuery.sizeOf(context).width - 70) * (9 / 20),
                        height: 92,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Material(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 6,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        Icons
                                                            .takeout_dining_rounded,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        Icons
                                                            .chevron_right_rounded,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "$_parcelCount",
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    const Text(
                                                      " parcels",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "Ready to pick-up",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width:
                            (MediaQuery.sizeOf(context).width - 70) * (9 / 20),
                        height: 92,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: Material(
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(
                                  top: 6,
                                  bottom: 1,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        Icons.delivery_dining,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Icon(
                                                        Icons
                                                            .chevron_right_rounded,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "2",
                                                      style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                    Text(
                                                      " parcels",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "On-delivery (Coming soon)",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
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
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

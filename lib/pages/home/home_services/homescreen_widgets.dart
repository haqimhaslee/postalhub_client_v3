// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QueueMs extends StatefulWidget {
  const QueueMs({super.key});
  @override
  State<QueueMs> createState() => _QueueMsState();
}

class _QueueMsState extends State<QueueMs> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final int _parcelCount = 0;
  String? uniqueid;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  Future<void> _getUserDetails() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('client_user').doc(user.uid).get();
      if (mounted) {
        setState(() {
          uniqueid = userDoc['unique_id'];
        });
      }
    }
  }

  Stream<int> _fetchParcelCountStream() {
    return _firestore
        .collection('parcelInventory')
        .where('ownerId', isEqualTo: uniqueid)
        .where('status', isEqualTo: 1)
        .snapshots()
        .map((querySnapshot) => querySnapshot.size);
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
          child: StreamBuilder<int>(
              stream: uniqueid != null ? _fetchParcelCountStream() : null,
              builder: (context, snapshot) {
                int parcelCount = snapshot.data ?? 0; // Use 0 if data is null
                return Column(children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: (MediaQuery.sizeOf(context).width - 20) *
                                (11 / 20),
                            height: 195,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Material(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: InkWell(
                                  onTap: () {
                                    const snackBar = SnackBar(
                                      content:
                                          Text('Queue System - Coming Soon'),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 16,
                                      bottom: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: SizedBox(
                                            child: Column(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
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
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Row(
                                                      children: [
                                                        SizedBox(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 0),
                                                            child: Text(
                                                              "(Coming soon)",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right: 8,
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .social_distance_rounded,
                                                                size: 50,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 18,
                                                          ),
                                                          child: SizedBox(
                                                            width: (MediaQuery.sizeOf(
                                                                            context)
                                                                        .width -
                                                                    20) *
                                                                (7 / 20),
                                                            //height: 92,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                              ),
                                                              child: Material(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .surface,
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                    top: 6,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <Widget>[
                                                                      SizedBox(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 0),
                                                                                  child: Text(
                                                                                    "Your numbers",
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text(
                                                                                        "0",
                                                                                        style: TextStyle(
                                                                                          fontSize: 20,
                                                                                          fontWeight: FontWeight.w900,
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(left: 0),
                                                                                  child: Text(
                                                                                    "Current numbers",
                                                                                    style: TextStyle(
                                                                                      fontSize: 10,
                                                                                      fontWeight: FontWeight.w400,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(bottom: 10),
                                                                                  child: Text(
                                                                                    "0",
                                                                                    style: TextStyle(
                                                                                      fontSize: 20,
                                                                                      fontWeight: FontWeight.w600,
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
                                                        )
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
                            width: (MediaQuery.sizeOf(context).width - 70) *
                                (9 / 20),
                            height: 92,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Material(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: InkWell(
                                  onTap: () {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          "Open 'My Parcel' for more details"),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                          padding:
                                                              EdgeInsets.only(
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
                                                          padding:
                                                              EdgeInsets.only(
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
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "$_parcelCount",
                                                          style:
                                                              const TextStyle(
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
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "Ready to pick-up",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                            width: (MediaQuery.sizeOf(context).width - 70) *
                                (9 / 20),
                            height: 92,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              child: Material(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                child: InkWell(
                                  onTap: () {
                                    const snackBar = SnackBar(
                                      content: Text(
                                          'One-Tap Delivery - Coming soon'),
                                    );

                                    // Find the ScaffoldMessenger in the widget tree
                                    // and use it to show a SnackBar.
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                      top: 6,
                                      bottom: 1,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Icon(
                                                            Icons
                                                                .delivery_dining,
                                                            size: 20,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
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
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "0",
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
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      "On-delivery (Coming soon)",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                ]);
              }),
        ),
      ),
    );
  }
}

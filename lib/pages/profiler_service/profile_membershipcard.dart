import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MembershipCard extends StatefulWidget {
  const MembershipCard({super.key});

  @override
  State<MembershipCard> createState() => _MembershipCardState();
}

class _MembershipCardState extends State<MembershipCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String? firstname;
  String? lastname;
  String? email;
  int? membershipPoints;

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
      setState(() {
        firstname = userDoc['firstName'];
        lastname = userDoc['lastName'];
        email = userDoc['email'];
        membershipPoints = userDoc['membership_points'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: Center(
            child: ListView(children: [
          Column(children: [
            Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(51, 0, 0, 0),
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 3.0,
                      ), //BoxShadow
                    ],
                  ),
                  width: 350,
                  //height: 500,
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              left: 0,
                              right: 0,
                              bottom: 8,
                            ),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 15,
                                    right: 10,
                                  ),
                                  child: CircleAvatar(
                                    radius: 20,
                                    //backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(
                                        "assets/images/postalhub_logo.jpg"),
                                  ),
                                ),
                                Text(
                                  "Postal Hub Membership",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 0,
                              left: 20,
                              right: 0,
                              bottom: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '$firstname $lastname',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 13,
                                ),
                                Text(
                                  "Reward Points",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  "$membershipPoints",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                    left: 5,
                                    right: 5,
                                    bottom: 5,
                                  ),
                                  child: QrImageView(
                                    data: '$email',
                                    version: QrVersions.auto,
                                    size: 150,
                                    gapless: true,
                                  ),
                                )
                              ]),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                top: 30,
                                left: 0,
                                right: 0,
                                bottom: 0,
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                ),
                                child: Column(children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/werehouse_membershipcard.png"),
                                            fit: BoxFit.cover),
                                      ),
                                      child: SizedBox.fromSize(
                                        size: const Size(400, 110),
                                        child: const ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(30),
                                            bottomLeft: Radius.circular(30),
                                          ),
                                          child: Material(
                                              color: Color.fromARGB(
                                                  0, 39, 39, 39)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              )),
                        ],
                      )),
                )),
            // const Text("Postal Hub©️"),

            SizedBox(
              height: 55,
              child: IconButton(
                icon: Image.asset('assets/images/add_to_google_wallet.png'),
                iconSize: 10,
                onPressed: () {
                  const snackBar = SnackBar(
                    content: Text('Coming soon!'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
            const SizedBox(
              height:30
            )
            //SizedBox(
            //  height: 55,
            //  child: IconButton(
            //    icon: Image.asset('assets/images/add_to_apple_wallet.png'),
           //     iconSize: 10,
           //     onPressed: () {
            //      const snackBar = SnackBar(
           //         content: Text('Coming soon!'),
           //       );
//
                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
     //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
              //  },
             // ),
           // )
          ]),
        ])));
  }
}

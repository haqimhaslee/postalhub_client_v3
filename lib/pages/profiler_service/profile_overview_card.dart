import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/profiler_service/profile_membershipcard.dart';
import 'package:postalhub_client/pages/profiler_service/your_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeProfileOverview extends StatefulWidget {
  const HomeProfileOverview({super.key});
  @override
  State<HomeProfileOverview> createState() => _HomeProfileOverviewState();
}

class _HomeProfileOverviewState extends State<HomeProfileOverview> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String? firstname;
  String? lastname;
  String? email;
  String? profilePic;
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
        profilePic = userDoc['profile_pic'];
        firstname = userDoc['firstName'];
        lastname = userDoc['lastName'];
        email = userDoc['email'];
        membershipPoints = userDoc['membership_points'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: SizedBox(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: Material(
              color: const Color.fromARGB(0, 255, 193, 7),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const YourProfile()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: profilePic != null
                                    ? Image.network(
                                        profilePic!,
                                        width: 90.0,
                                        height: 90.0,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Column(
                                            children: [
                                              Icon(
                                                Icons
                                                    .image_not_supported_outlined,
                                                size: 70,
                                              ),
                                              Text('Failed to load image'),
                                            ],
                                          );
                                        },
                                      )
                                    : const Column(
                                        children: [
                                          Icon(
                                            Icons.image,
                                            size: 50,
                                          ),
                                          Text('No Image'),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, left: 0),
                                        child: Text("$firstname $lastname",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                            ))))
                              ],
                            ),
                            Text("ID : 834623",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                )),
                            Row(
                              children: [
                                SizedBox(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 0, left: 0, top: 7),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onTertiaryContainer,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                0, 255, 254, 254)),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 1, 5, 1),
                                        child: Text(
                                          "$membershipPoints Pts",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryContainer),
                                        )),
                                  ),
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Flexible(fit: FlexFit.tight, child: SizedBox()),
                      Padding(
                          padding: const EdgeInsets.only(right: 15, left: 0),
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MembershipCard()));
                                  },
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.qr_code_rounded,
                                        size: 40,
                                        color: Color.fromARGB(255, 37, 37, 37),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

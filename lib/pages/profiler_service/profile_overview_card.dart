import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/profiler_service/profile_membershipcard.dart';
import 'package:postalhub_client/pages/profiler_service/your_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:postalhub_client/auth/auth_service.dart';
//import 'package:provider/provider.dart';

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
    //final authService = Provider.of<AuthService>(context);
    //final user = authService.user;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Card(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: SizedBox(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
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
                      const Padding(
                        padding: EdgeInsets.only(right: 15, left: 15),
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                                // backgroundImage:
                                //      AssetImage("assets/profile_pic.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        //width: MediaQuery.of(context).size.width - 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 0, left: 0),
                                        child: Text("Hi, $firstname $lastname!",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ))))
                              ],
                            ),
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
                                            .primary,
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
                                                  .onPrimary),
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
                                  //splashColor: Theme.of(context)
                                  //    .colorScheme
                                  //   .primaryContainer,
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

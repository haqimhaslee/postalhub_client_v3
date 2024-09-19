// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
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
  bool isLoading = true;

  String? firstname;
  String? lastname;
  String? email;
  String? profilePic;
  String? uniqueId;
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
      if (mounted) {
        setState(() {
          profilePic = userDoc['profile_pic'];
          firstname = userDoc['firstName'];
          lastname = userDoc['lastName'];
          uniqueId = userDoc['unique_id'];
          email = userDoc['email'];
          membershipPoints = userDoc['membership_points'];
          isLoading = false; // Set isLoading to false when data is loaded
        });
      } else {
        // Handle the case where the widget is no longer mounted, perhaps by printing a log message
        if (kDebugMode) {
          print("Widget is no longer mounted, unable to update state.");
        }
      }
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
                onTap: isLoading
                    ? null
                    : () {
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
                  child: _buildProfileContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return StreamBuilder<DocumentSnapshot>(
      stream: _firestore.collection('client_user').doc(user.uid).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerEffect();
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text('No user data found');
        }

        var userDoc = snapshot.data!;
        return _buildProfileRow();
      },
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.primaryContainer,
      highlightColor: Theme.of(context).colorScheme.tertiaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: SizedBox(
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                height: 15,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Container(
                width: 50,
                height: 20,
                color: Colors.white,
              ),
            ],
          ),
          const Flexible(fit: FlexFit.tight, child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 0),
            child: SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow() {
    return Row(
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
                          errorBuilder: (context, error, stackTrace) {
                            return const Column(
                              children: [
                                Image(
                                  height: 80,
                                  image: AssetImage(
                                      'assets/images/null_profile.jpg'),
                                ),
                              ],
                            );
                          },
                        )
                      : const Column(
                          children: [
                            Image(
                              height: 80,
                              image:
                                  AssetImage('assets/images/null_profile.jpg'),
                            ),
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
                      padding: const EdgeInsets.only(right: 0, left: 0),
                      child: Text(
                        "$firstname $lastname",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                "Unique ID : $uniqueId",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 0, left: 0, top: 7),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.onTertiaryContainer,
                          border: Border.all(
                              color: const Color.fromARGB(0, 255, 254, 254)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                          child: Text(
                            "$membershipPoints Pts",
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
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
                        builder: (context) => const MembershipCard(),
                      ),
                    );
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
          ),
        ),
      ],
    );
  }
}

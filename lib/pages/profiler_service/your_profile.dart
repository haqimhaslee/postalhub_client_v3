// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:postalhub_client/pages/profiler_service/edit_your_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class YourProfile extends StatefulWidget {
  const YourProfile({super.key});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String? firstname;
  String? lastname;
  String? email;
  String? hostelAddress;
  String? phoneNo;
  String? companyName;
  String? companyEmail;
  String? companyId;
  String? profilePic;

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
        hostelAddress = userDoc['company_address'];
        phoneNo = userDoc['phone'];
        companyName = userDoc['company_name'];
        companyEmail = userDoc['company_email'];
        companyId = userDoc['company_id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'EditProfile':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditYourProfile()),
                  );
                  break;
                case 'ResetPassword':
                  //
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'EditProfile',
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Icon(Icons.edit),
                    ),
                    Text('Edit profile')
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(200.0),
                        child: profilePic != null
                            ? Image.network(
                                profilePic!,
                                width: 160.0,
                                height: 160.0,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Column(
                                    children: [
                                      Image(
                                        height: 130,
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
                                    height: 130,
                                    image: AssetImage(
                                        'assets/images/null_profile.jpg'),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                '$firstname $lastname',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                //child: Divider(),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
                  'Personal Info',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: SizedBox(
                      child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(Icons.phone))),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text("$phoneNo",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))))
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(Icons.email))),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text(user.email!,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))))
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
                    ],
                  )),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                //child: Divider(),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
                  'Company Info',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: SizedBox(
                      child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(Icons.work))),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text("$companyName",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))))
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child:
                                                      Icon(Icons.apartment))),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text("$hostelAddress",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))))
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(
                                                      Icons.badge_rounded))),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text("$companyId",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))))
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(
                                              child: Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Icon(Icons.email))),
                                          SizedBox(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Text("$companyEmail",
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ))))
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
                    ],
                  )),
                ),
              ),
              const SizedBox(height: 20)
            ],
          )),
    );
  }
}

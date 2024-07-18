// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:postalhub_client/pages/my_parcel/my_parcel_detail.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyParcel extends StatefulWidget {
  const MyParcel({super.key});
  @override
  State<MyParcel> createState() => _MyParcelState();
}

class _MyParcelState extends State<MyParcel> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser!;

  String? companyId;
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
        companyId = userDoc['company_id'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final collectionStream = _firestore
        .collection('parcelInventory')
        .where('ownerId', isEqualTo: companyId)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: collectionStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data!.docs;

        return Scaffold(
          appBar: AppBar(
            title: const Text('My Parcel'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final data = documents[index].data();
                    if (data is Map<String, dynamic>) {
                      return MyListItemWidget(
                          data: data, docId: documents[index].id);
                    } else {
                      // Handle unexpected data type (e.g., print a warning)
                      return const SizedBox(); // Or any placeholder widget
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MyListItemWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String docId;

  const MyListItemWidget({super.key, required this.data, required this.docId});

  @override
  State<MyListItemWidget> createState() => _MyListItemWidgetState();
}

class _MyListItemWidgetState extends State<MyListItemWidget> {
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final trackingID1 = widget.data['trackingId1'];

    final remarks = widget.data['remarks'] ?? 'No remarks';
    final status = widget.data['status'];

    //double width = MediaQuery.of(context).size.width;

    return VisibilityDetector(
      key: Key(widget.data['trackingId1']),
      onVisibilityChanged: (visibilityInfo) {
        if (_mounted) {
          setState(() {});
        }
      },
      child: Column(children: [
        Card(
          elevation: 0,
          child: Column(
            children: [
              SizedBox(
                // width: 400,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyParcelDetail(
                                data: widget.data, docId: widget.docId),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: SizedBox(
                                //width: width < 679 ? width - 40 : width - 360,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Track No 1: $trackingID1'),
                                    Text('Remarks: $remarks'),
                                    if (status == 'DELIVERED')
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 1),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 13, 196, 0),
                                                  border: Border.all(),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 1, 5, 1),
                                                child: Text(
                                                  widget.data['status'],
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 5, 1),
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 167, 196, 0),
                                                  border: Border.all(),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 1, 5, 1),
                                                child: Text(
                                                  widget.data['status'],
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
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
        ),
      ]),
    );
  }
}

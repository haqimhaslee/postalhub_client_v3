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

  String? uniqueid;
  int _selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    // Base query for parcels
    var baseQuery = _firestore
        .collection('parcelInventory')
        .where('ownerId', isEqualTo: uniqueid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Parcel'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: SegmentedButton<int>(
            segments: const <ButtonSegment<int>>[
              ButtonSegment<int>(value: 0, label: Text('All')),
              ButtonSegment<int>(value: 1, label: Text('Arrived')),
              ButtonSegment<int>(value: 2, label: Text('Delivered')),
            ],
            selected: <int>{_selectedIndex},
            onSelectionChanged: (Set<int> newSelection) {
              setState(() {
                _selectedIndex = newSelection.first;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Apply filter based on the selected segment and build the stream
        stream: (_selectedIndex == 1)
            ? baseQuery.where('status', isEqualTo: 1).snapshots()
            : (_selectedIndex == 2)
                ? baseQuery.where('status', isEqualTo: 3).snapshots()
                : baseQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          return Column(
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
          );
        },
      ),
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
    final parcelCategory = widget.data['parcelCategory'] ?? 1;

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
                                    Row(
                                      children: [
                                        _buildStatusWidget(context, status),
                                        _buildCategoryWidget(
                                            context, parcelCategory),
                                      ],
                                    )
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

  Widget _buildStatusWidget(BuildContext context, int status) {
    switch (status) {
      case 2:
        return _statusContainer(context, 'On-Delivery');
      case 3:
        return _statusContainer(context, 'Delivered');
      default:
        return _statusContainer(context, 'Arrived-Sorted');
    }
  }

  Widget _statusContainer(BuildContext context, String statusText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 1),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 174, 174, 0),
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              child: Text(
                statusText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildCategoryWidget(BuildContext context, int parcelCategory) {
    switch (parcelCategory) {
      case 2:
        return _categoryContainer(context, 'SELF-COLLECT');
      case 3:
        return _categoryContainer(context, 'COD');
      default:
        return Container();
    }
  }

  Widget _categoryContainer(BuildContext context, String categoryText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 5, 1),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(0, 167, 196, 0),
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              child: Text(
                categoryText,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:another_stepper/another_stepper.dart';

class SearchParcel extends StatefulWidget {
  const SearchParcel({super.key});

  @override
  State<SearchParcel> createState() => _SearchParcelState();
}

final searchInput = TextEditingController();

class _SearchParcelState extends State<SearchParcel> {
  final _firestore = FirebaseFirestore.instance;
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Parcel'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TextField(
                controller: searchInput,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        searchInput.clear();
                      });
                    },
                    icon: const Icon(Icons.cancel),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Tracking Number*',
                ),
              ),
            ),
            //const Divider(),
            Expanded(
              child: _buildSearchResults(_searchTerm),
            ),
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: SizedBox(
                  width: 200,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Material(
                          color: const Color.fromARGB(0, 255, 193, 7),
                          child: InkWell(
                            onTap: () =>
                                setState(() => _searchTerm = searchInput.text),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 0),
                                                    child: Text("Search",
                                                        style: TextStyle(
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
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(String searchTerm) {
    if (searchTerm.isEmpty) {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/gif/search.gif",
            ),
            const Text('Enter a tracking number to search.'),
            const Text('*Tracking numbers are case sensitive')
          ],
        ),
      );
    }

    return FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
      future: _performSearch(searchTerm),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data ?? [];
        if (documents.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/gif/not_found.gif",
                ),
                const Text('No items found for that tracking number.')
              ],
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final data = documents[index].data()!;
            final imageUrl = data['imageUrl'];
            final trackingId2 = data['trackingId2']?.toString() ?? '';
            final trackingId3 = data['trackingId3']?.toString() ?? '';
            final trackingId4 = data['trackingId4']?.toString() ?? '';
            final receiverRemarks = data['receiverRemarks']?.toString() ?? '';
            final remarks = data['remarks']?.toString() ?? '';
            final status = data['status'];
            final receiverImageUrl = data['receiverImageUrl'];
            final timestampSorted = data['timestamp_arrived_sorted'] != null
                ? (data['timestamp_arrived_sorted'] as Timestamp).toDate()
                : null;
            final timestampDelivered = data['timestamp_delivered'] != null
                ? (data['timestamp_delivered'] as Timestamp).toDate()
                : null;

            List<StepperData> stepperDataDelivered = [
              StepperData(
                  title: StepperText(
                    "Ready to take",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("Arriving/Sorting"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText("Delivered",
                      textStyle: const TextStyle(
                        color: Colors.grey,
                      )),
                  subtitle: StepperText("Delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  )),
            ];

            List<StepperData> stepperDataSorted = [
              StepperData(
                  title: StepperText(
                    "Ready to take",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("Arriving/Sorting"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.check_rounded, color: Colors.white),
                  )),
              StepperData(
                  title: StepperText(
                    "Not delivered",
                    textStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: StepperText("Delivery"),
                  iconWidget: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: const Icon(Icons.close_rounded, color: Colors.white),
                  )),
            ];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    if (status == 'DELIVERED')
                      AnotherStepper(
                        stepperList: stepperDataDelivered,
                        stepperDirection: Axis.horizontal,
                        iconWidth: 40,
                        iconHeight: 40,
                        activeBarColor: Colors.green,
                        inActiveBarColor: Colors.grey,
                        inverted: true,
                        verticalGap: 30,
                        activeIndex: 1,
                        barThickness: 8,
                      ),
                    if (status == 'ARRIVED-SORTED')
                      AnotherStepper(
                        stepperList: stepperDataSorted,
                        stepperDirection: Axis.horizontal,
                        iconWidth: 40,
                        iconHeight: 40,
                        activeBarColor: Colors.green,
                        inActiveBarColor: Colors.grey,
                        inverted: true,
                        verticalGap: 30,
                        activeIndex: 0,
                        barThickness: 8,
                      ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  imageUrl,
                                  width: 300.0,
                                  height: 300.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    String errorMessage;
                                    if (error is NetworkImageLoadException) {
                                      errorMessage = 'Network error: $error';
                                    } else {
                                      errorMessage =
                                          'Failed to load image: $error';
                                    }
                                    return Column(
                                      children: [
                                        const Icon(
                                            Icons.image_not_supported_outlined),
                                        Text(errorMessage),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tracking ID 1 : ${data['trackingId1']}',
                            ),
                            if (trackingId2.isNotEmpty)
                              Text(
                                'Tracking ID 2 : $trackingId2',
                              ),
                            if (trackingId3.isNotEmpty)
                              Text(
                                'Tracking ID 3 : $trackingId3',
                              ),
                            if (trackingId4.isNotEmpty)
                              Text(
                                'Tracking ID 4 : $trackingId4',
                              ),
                            if (remarks.isNotEmpty)
                              Text(
                                'Remarks/Notes : $remarks',
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 1, 20, 1),
                  child: Divider(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Card(
                  elevation: 0,
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (status == 'DELIVERED')
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Status : '),
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
                                                data['status'],
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                              )),
                                        ),
                                      ],
                                    ),
                                    if (timestampSorted != null)
                                      Text(
                                        'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampSorted)}',
                                      ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    if (timestampDelivered != null)
                                      Text(
                                        'Delivered at: ${DateFormat.yMMMd().add_jm().format(timestampDelivered)}',
                                      ),
                                    Text(
                                      'Receiver: ${data['receiverId']}',
                                    ),
                                    if (receiverRemarks.isNotEmpty)
                                      Text(
                                          'Remarks : ${data['receiverRemarks']}'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            receiverImageUrl,
                                            width: 300.0,
                                            height: 300.0,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              String errorMessage;
                                              if (error
                                                  is NetworkImageLoadException) {
                                                errorMessage =
                                                    'Network error: $error';
                                              } else {
                                                errorMessage =
                                                    'Failed to load image: $error';
                                              }
                                              return Column(
                                                children: [
                                                  const Icon(Icons
                                                      .image_not_supported_outlined),
                                                  Text(errorMessage),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text('Status : '),
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
                                                data['status'],
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                              )),
                                        ),
                                      ],
                                    ),
                                    if (timestampSorted != null)
                                      Text(
                                        'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampSorted)}',
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _performSearch(
      String searchTerm) async {
    final results1 = await _firestore
        .collection('parcelInventory')
        .where('trackingId1', isEqualTo: searchTerm)
        .get();

    final results2 = await _firestore
        .collection('parcelInventory')
        .where('trackingId2', isEqualTo: searchTerm)
        .get();

    final results3 = await _firestore
        .collection('parcelInventory')
        .where('trackingId3', isEqualTo: searchTerm)
        .get();

    final results4 = await _firestore
        .collection('parcelInventory')
        .where('trackingId4', isEqualTo: searchTerm)
        .get();

    final allResults = [
      ...results1.docs,
      ...results2.docs,
      ...results3.docs,
      ...results4.docs,
    ];

    // Remove duplicates by tracking document IDs
    final uniqueResults =
        {for (var doc in allResults) doc.id: doc}.values.toList();

    return uniqueResults;
  }
}

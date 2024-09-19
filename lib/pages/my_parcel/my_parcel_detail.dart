// ignore_for_file: deprecated_member_use

import 'package:intl/intl.dart'; // Add this import for date formatting
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:another_stepper/another_stepper.dart';

class MyParcelDetail extends StatelessWidget {
  final Map<String, dynamic> data;
  final String docId;

  const MyParcelDetail({super.key, required this.data, required this.docId});

  @override
  Widget build(BuildContext context) {
    final trackingID1 = data['trackingId1'];
    final remarks = data['remarks'] ?? 'No remarks';
    final status = data['status'];
    final trackingID2 = data['trackingId2'] ?? 'No Tracking ID';
    final trackingID3 = data['trackingId3'] ?? 'No Tracking ID';
    final trackingID4 = data['trackingId4'] ?? 'No Tracking ID';
    final warehouse = data['warehouse'] ?? 'No warehouse data';
    final ownerId = data['ownerId']?.toString() ?? '';
    final receiverId = data['receiverId'] ?? 'No receiver ID data';
    final receiverRemark =
        data['receiverRemarks'] ?? 'No receiver remarks data';
    final receiverImageUrl =
        data['receiverImageUrl'] ?? 'No receiver image data';
    final imageUrl = data['imageUrl'];
    final timestampDelivered = data['timestamp_arrived_sorted'] != null
        ? (data['timestamp_arrived_sorted'] as Timestamp).toDate()
        : null;
    final timestampArrived = data['timestamp_delivered'] != null
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
            child: const Icon(Icons.inventory, color: Colors.white),
          )),
      StepperData(
          title: StepperText(
            "On delivery",
            textStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          subtitle: StepperText("On delivery"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.delivery_dining, color: Colors.white),
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
          ))
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
            child: const Icon(Icons.inventory, color: Colors.white),
          )),
      StepperData(
          title: StepperText(
            "On delivery",
            textStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          subtitle: StepperText("On delivery"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.delivery_dining, color: Colors.white),
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
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.check_rounded, color: Colors.white),
          ))
    ];

    List<StepperData> stepperDataOnDelivery = [
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
            child: const Icon(Icons.inventory, color: Colors.white),
          )),
      StepperData(
          title: StepperText(
            "On delivery",
            textStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
          subtitle: StepperText("On delivery"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.delivery_dining, color: Colors.white),
          )),
      StepperData(
          title: StepperText("Not delivered",
              textStyle: const TextStyle(
                color: Colors.grey,
              )),
          subtitle: StepperText("Delivery"),
          iconWidget: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: const Icon(Icons.check_rounded, color: Colors.white),
          ))
    ];

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        appBar: AppBar(
          title: Text('$trackingID1'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Coming soon!'),
                action: SnackBarAction(
                  label: 'OK',
                  onPressed: () {
                    // Code to execute.
                  },
                ),
              ),
            );
          },
          label: const Text("Request for delivery"),
          icon: const Icon(Icons.delivery_dining_rounded),
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                switch (status) {
                  1 => AnotherStepper(
                      stepperList: stepperDataSorted,
                      stepperDirection: Axis.horizontal,
                      iconWidth: 40,
                      iconHeight: 40,
                      activeBarColor: Colors.green,
                      inActiveBarColor: Colors.grey,
                      inverted: true,
                      verticalGap: 20,
                      activeIndex: 0,
                      barThickness: 8,
                    ),
                  2 => AnotherStepper(
                      stepperList: stepperDataOnDelivery,
                      stepperDirection: Axis.horizontal,
                      iconWidth: 40,
                      iconHeight: 40,
                      activeBarColor: Colors.green,
                      inActiveBarColor: Colors.grey,
                      inverted: true,
                      verticalGap: 20,
                      activeIndex: 1,
                      barThickness: 8,
                    ),
                  3 => AnotherStepper(
                      stepperList: stepperDataDelivered,
                      stepperDirection: Axis.horizontal,
                      iconWidth: 40,
                      iconHeight: 40,
                      activeBarColor: Colors.green,
                      inActiveBarColor: Colors.grey,
                      inverted: true,
                      verticalGap: 20,
                      activeIndex: 2,
                      barThickness: 8,
                    ),
                  _ => Container(), // Handle default case if needed
                },
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        imageUrl,
                                        width: 300.0,
                                        //height: 300.0,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            // Image is fully loaded
                                            return child;
                                          } else {
                                            // Image is still loading, show a progress indicator
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
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
                                )
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
                              if (trackingID2.isNotEmpty)
                                Text(
                                  'Tracking ID 2 : $trackingID2',
                                ),
                              if (trackingID3.isNotEmpty)
                                Text(
                                  'Tracking ID 3 : $trackingID3',
                                ),
                              if (trackingID4.isNotEmpty)
                                Text(
                                  'Tracking ID 4 : $trackingID4',
                                ),
                              if (ownerId.isNotEmpty)
                                Text(
                                  'Owner : $ownerId',
                                ),
                              if (timestampArrived != null)
                                Text(
                                  'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampArrived)}',
                                ),
                              if (remarks.isNotEmpty)
                                Text(
                                  'Remarks/Notes : $remarks',
                                ),
                              Text('Wherehouse : $warehouse')
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
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
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (status == 3)
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (timestampDelivered != null)
                                        Text(
                                          'Delivered at: ${DateFormat.yMMMd().add_jm().format(timestampDelivered)}',
                                        ),
                                      Text(
                                        'Receiver: $receiverId',
                                      ),
                                      if (receiverRemark.isNotEmpty)
                                        Text('Remarks : $receiverRemark'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  receiverImageUrl,
                                                  width: 300.0,
                                                  //height: 300.0,
                                                  fit: BoxFit.cover,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
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
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 5, 5, 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (timestampArrived != null)
                                        Text(
                                          'Arrived & sorted at: ${DateFormat.yMMMd().add_jm().format(timestampArrived)}',
                                        ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

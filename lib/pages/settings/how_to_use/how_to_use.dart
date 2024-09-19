// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';

class HowToUse extends StatefulWidget {
  const HowToUse({super.key});
  @override
  State<HowToUse> createState() => _HowToUseState();
}

class _HowToUseState extends State<HowToUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('How to use this app?'),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(
            left: 0,
            right: 0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: Text("Navigating in this app",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SizedBox(
                      child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text("Home",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text("My Parcel",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text("Search Parcel",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Settings & More",
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
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: Text("Account etc",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SizedBox(
                      child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Edit your profile",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Forgot password",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Unique ID (UID)",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Request account deletion",
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
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
                child: Text("Others function and more",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SizedBox(
                      child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Ask AI (AI Chatbot)",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text("Search Parcel",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "One-Tap-Delivery",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Arrived-Sorted Notification",
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
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Material(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          child: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    //width: MediaQuery.of(context).size.width - 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                        "Claim reward point",
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
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ))
      ],
    ));
  }
}

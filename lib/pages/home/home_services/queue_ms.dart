import 'package:flutter/material.dart';

class QueueMs extends StatefulWidget {
  const QueueMs({super.key});
  @override
  State<QueueMs> createState() => _QueueMsState();
}

class _QueueMsState extends State<QueueMs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Card(
        //color: Theme.of(context).colorScheme.errorContainer,
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
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              child: Material(
                // ignore: deprecated_member_use
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 15,
                      bottom: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Text(
                                                  "Queue Management System",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                  ))))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          child: Padding(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Text("Coming Soon",
                                                  style: TextStyle(
                                                      //fontWeight: FontWeight.w600,
                                                      ))))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:postalhub_client/pages/ask_ai_services/ask_ai.dart';
import 'package:postalhub_client/pages/home/home.dart';
import 'package:postalhub_client/pages/my_parcel/my_parcel.dart';
import 'package:postalhub_client/pages/settings/settings.dart';
import 'package:postalhub_client/pages/search_parcel/search_parcel.dart';
import 'package:shimmer/shimmer.dart';

class AppNavigatorServices extends StatefulWidget {
  const AppNavigatorServices({super.key});

  @override
  State<AppNavigatorServices> createState() => _AppNavigatorServicesState();
}

class _AppNavigatorServicesState extends State<AppNavigatorServices> {
  var _selectedIndex = 0;
  final List<Widget> _windgetOption = <Widget>[
    const Home(),
    const MyParcel(),
    const SearchParcel(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        //appBar: AppBar(
        //backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        //elevation: 1,
        //scrolledUnderElevation: 0,
        //title: Row(children: [
        //Image.asset(
        //  'assets/images/ic_launcher.png',
        //  width: 40,
        //  height: 40,
        //  fit: BoxFit.cover,
        //),
        //const Text('  Postal Hub'),
        //]),
        //),
        bottomNavigationBar: BottomAppBar(
          //color: Theme.of(context).colorScheme.surfaceContainerLowest,

          //height: 75,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: NavigationBar(
            //backgroundColor:Theme.of(context).colorScheme.surfaceContainerLowest,
            selectedIndex: _selectedIndex,
            //labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            //indicatorShape: const CircleBorder(),
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            destinations: const [
              /// Home
              NavigationDestination(
                label: "Home",
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
              ),
              NavigationDestination(
                label: "My Parcel",
                icon: Icon(Icons.inventory_2_outlined),
                selectedIcon: Icon(Icons.inventory_2_rounded),
              ),
              NavigationDestination(
                label: "Search Parcel",
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search_rounded),
              ),
              NavigationDestination(
                label: "More",
                icon: Icon(Icons.more_horiz),
                selectedIcon: Icon(Icons.more_horiz),
              ),

              /// Profile
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton(
            elevation: 2,
            focusElevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            //shape: const CircleBorder(),
            tooltip: "FAQs - Ask AI",
            onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog.fullscreen(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                right: 0,
                                left: 15,
                                //top: 5,
                                //bottom: 2,
                              ),
                              child: Text('Ask AI by '),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                              ),
                              child: Shimmer.fromColors(
                                period: const Duration(milliseconds: 2000),
                                baseColor:
                                    Theme.of(context).colorScheme.primary,
                                highlightColor:
                                    Theme.of(context).colorScheme.tertiary,
                                child: const Text(
                                  'Gemini',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    //fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Flexible(
                                fit: FlexFit.tight, child: SizedBox()),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 10,
                                left: 10,
                                //top: 5,
                                //bottom: 2,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            )
                          ],
                        ),
                        const Divider(),
                        const Expanded(child: AskAiChatUi())
                      ],
                    ),
                  ),
                ),
            child: const Icon(Icons.forum_rounded)),
        body: PageTransitionSwitcher(
          transitionBuilder: (child, animation, secondaryAnimation) =>
              SharedAxisTransition(
            transitionType: SharedAxisTransitionType.vertical,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: _windgetOption.elementAt(_selectedIndex),
        ));
  }
}

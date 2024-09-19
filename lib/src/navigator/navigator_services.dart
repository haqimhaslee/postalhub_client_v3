import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:postalhub_client/pages/ask_ai_services/ask_ai.dart';
import 'package:postalhub_client/pages/home/home.dart';
import 'package:postalhub_client/pages/my_parcel/my_parcel.dart';
import 'package:postalhub_client/pages/settings/settings.dart';
import 'package:postalhub_client/pages/search_parcel/search_parcel.dart';

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
        bottomNavigationBar: BottomAppBar(
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
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
            tooltip: "Ask AI",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AskAi(),
                ),
              );
            },
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

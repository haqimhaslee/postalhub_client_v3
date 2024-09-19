// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class ApplicationSystemInfo extends StatefulWidget {
  const ApplicationSystemInfo({super.key});

  @override
  State<ApplicationSystemInfo> createState() => _ApplicationSystemInfoState();
}

Future<void> _easteregg(BuildContext context) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse('https://www.youtube.com/watch?v=dQw4w9WgXcQ'),
      customTabsOptions: CustomTabsOptions(
        colorSchemes: CustomTabsColorSchemes.defaults(
          toolbarColor: theme.colorScheme.surface,
          navigationBarColor: theme.colorScheme.surface,
        ),
        shareState: CustomTabsShareState.off,
        urlBarHidingEnabled: true,
        showTitle: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        preferredBarTintColor: theme.colorScheme.surface,
        preferredControlTintColor: theme.colorScheme.onSurface,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
      ),
    );
  } catch (e) {
    // If the URL launch fails, an exception will be thrown. (For example, if no browser app is installed on the Android device.)
    debugPrint(e.toString());
  }
}

class _ApplicationSystemInfoState extends State<ApplicationSystemInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        const SliverAppBar.large(
          title: Text('Our Dev Info'),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'About this new parcel tracking system',
                //textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              const Text(
                '• This parcel tracking system is designed to provide real-time updates and tracking information for your shipments.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'Our System Developer',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    width: 400,
                    'assets/images/dev_pic.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'Technology used to develop this system',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              const Text(
                '• The system utilizes Google Cloud (GCP) services and the Gemini for efficient and scallable data management and integration.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'We are excited to bring the latest/exciting technology to you',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              const Text(
                '• Our team is dedicated to bringing you cutting-edge technology to enhance your shipping and tracking experience.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'The beginning of a multi-year project',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 10.0),
              const Text(
                '• We are committed to expanding and improving this system over the coming years to provide even more features and reliability.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 40.0),
              const Text(
                'More exciting features coming soon... 🙃',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Card(
                  color: Theme.of(context).colorScheme.surfaceVariant,
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
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        child: Material(
                          color: const Color.fromARGB(0, 255, 193, 7),
                          child: InkWell(
                            onTap: () => _easteregg(context),
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
                                          children: [
                                            SizedBox(
                                                child: Padding(
                                                    padding: EdgeInsets.only(),
                                                    child: Text("Easter Egg 🥚",
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
              const SizedBox(height: 50.0),
            ],
          ),
        ))
      ],
    ));
  }
}

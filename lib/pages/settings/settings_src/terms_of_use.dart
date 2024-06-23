import 'package:flutter/material.dart';

class TermsOfUse extends StatefulWidget {
  const TermsOfUse({super.key});

  @override
  State<TermsOfUse> createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms Of Use'),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'About this new parcel tracking system',
                    //textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    '• This parcel tracking system is designed to provide real-time updates and tracking information for your shipments.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'Our System Developer',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
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
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    '• The system utilizes Google Cloud services and the Gemini for efficient and scallable data management and integration.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'We are excited to bring the latest/exciting technology to you',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    '• Our team is dedicated to bringing you cutting-edge technology to enhance your shipping and tracking experience.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'This is just the beginning of a multiyear project',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    '• We are committed to expanding and improving this system over the coming years to provide even more features and reliability.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 40.0),
                  const Text(
                    'More exciting features coming soon... 🙃',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: ListView(
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Last updated: July 16, 2024',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Interpretation',
                    //textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'Definitions',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'Technology used to develop this system',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '• The system utilizes Google Cloud services and the Gemini for efficient and scallable data management and integration.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'We are excited to bring the latest/exciting technology to you',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '• Our team is dedicated to bringing you cutting-edge technology to enhance your shipping and tracking experience.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'This is just the beginning of a multiyear project',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '• We are committed to expanding and improving this system over the coming years to provide even more features and reliability.',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    'More exciting features coming soon... 🙃',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  SizedBox(height: 50.0),
                ],
              ),
            ],
          )),
    );
  }
}

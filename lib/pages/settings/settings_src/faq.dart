import 'package:flutter/material.dart';

class FaqS extends StatefulWidget {
  const FaqS({super.key});

  @override
  State<FaqS> createState() => _FaqSState();
}

class _FaqSState extends State<FaqS> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text('FAQs'),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Frequently Asked Questions (FAQs) regarding this project and how the Postal Hub functions. It should be a helpful resource for anyone who interacts with the Postal Hub, whether you're a regular customer, a business shipper, or even someone interested in the logistics behind mail processing.",
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 40.0),
              Text(
                'Technology used to develop this system',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '• The system utilizes Google Cloud services and the Gemini for efficient and scallable data management and integration.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 40.0),
              Text(
                'We are excited to bring the latest/exciting technology to you',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '• Our team is dedicated to bringing you cutting-edge technology to enhance your shipping and tracking experience.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 40.0),
              Text(
                'This is just the beginning of a multiyear project',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                '• We are committed to expanding and improving this system over the coming years to provide even more features and reliability.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 40.0),
              Text(
                'More features coming soon.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 50.0),
            ],
          ),
        ))
      ],
    ));
  }
}

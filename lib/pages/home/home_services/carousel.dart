import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List<CarouselItem> _items = [
    CarouselItem(
      backgroundImage:
          'assets/images/werehouse_membershipcard.png', // Replace with your image paths
      title: 'Item 1',
      subtitle: 'Subitem 1',
      onTap: () {
        // Handle onTap for item 1
        if (kDebugMode) {
          print('Tapped Item 1');
        }
      },
    ),
    CarouselItem(
      backgroundImage: 'assets/images/werehouse_membershipcard.png',
      title: 'Item 2',
      subtitle: 'Subitem 1',
      onTap: () {
        // Handle onTap for item 2
        if (kDebugMode) {
          print('Tapped Item 2');
        }
      },
    ),
    CarouselItem(
      backgroundImage: 'assets/images/werehouse_membershipcard.png',
      title: 'Item 3',
      subtitle: 'Subitem 1',
      onTap: () {
        // Handle onTap for item 2
        if (kDebugMode) {
          print('Tapped Item 3');
        }
      },
    ),
    // Add more CarouselItem objects as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxHeight: 150), // Adjust height as needed
        child: CarouselView(
          itemExtent: 330,
          shrinkExtent: 10,
          //itemSnapping: true,
          children: _items.map((item) {
            return CarouselCard(item: item);
          }).toList(),
        ),
      ),
    );
  }
}

class CarouselItem {
  final String backgroundImage;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  CarouselItem({
    required this.backgroundImage,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.item});

  final CarouselItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(item.backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
          children: [
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              item.subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

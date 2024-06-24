import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});
  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carouselServices')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No images found'));
          }

          final items = snapshot.data!.docs;

          return CarouselSlider(
            options: CarouselOptions(
              //height: 177,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              //aspectRatio: 4 / 2,
              autoPlayCurve: Curves.easeInOut,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 1100),
              autoPlayInterval: const Duration(seconds: 7),
              viewportFraction: 1,
            ),
            items: items.map((item) {
              final imageUrl = item['image_url'] ?? '';
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    child: imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const Center(
                            child: Icon(Icons.image_not_supported, size: 50)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

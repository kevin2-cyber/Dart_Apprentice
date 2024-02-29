import 'package:flutter/material.dart';
import 'package:peaky/model/place.dart';

class PopularPlaceCard extends StatelessWidget {
  const PopularPlaceCard({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.3,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('${place.image}'), fit: BoxFit.fill),
        borderRadius: const BorderRadius.all(Radius.circular(10))
    ),
    );
  }
}

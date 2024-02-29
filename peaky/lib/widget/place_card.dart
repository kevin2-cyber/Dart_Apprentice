import 'package:flutter/material.dart';
import 'package:peaky/details.dart';
import 'package:peaky/model/place.dart';

import '../util/constants.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Details(place: place))),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('${place.image}'), fit: BoxFit.fill),
          borderRadius: const BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppConstants.kColorPrimary,
                  ),
                  child: IconButton(
                      onPressed: (){},
                      splashColor: Colors.amberAccent,
                      icon: Image.asset(AppConstants.heart, height: 30, width: 30,)
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${place.placeName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
                Text(
                  '${place.price}/Night',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

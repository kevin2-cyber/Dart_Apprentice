import 'package:coffee_ui/pages/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeTile extends StatelessWidget {
  final String coffeeImagePath;
  final String coffeeName;
  final String coffeePrice;
  final String coffeeAdditive;

  const CoffeeTile(
      {Key? key,
      required this.coffeeImagePath,
      required this.coffeeName,
      required this.coffeePrice,
      required this.coffeeAdditive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const DetailsScreen()))),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.black54,
          ),
          width: 200,
          child: Column(
            children: [
              // coffee image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  coffeeImagePath,
                  height: 210,
                ),
              ),
              // coffee name
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffeeName,
                      style: GoogleFonts.bebasNeue(
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      coffeeAdditive,
                      style: GoogleFonts.bebasNeue(
                        textStyle: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    // price
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$$coffeePrice',
                            style: GoogleFonts.bebasNeue(),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: Colors.orange,
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

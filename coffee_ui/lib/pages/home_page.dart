import 'package:coffee_ui/utils/coffee_tile.dart';
import 'package:coffee_ui/utils/coffee_type.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // list of coffee types
final List coffeeType = [
  // [coffeeType, isSelected]
  ['Cappuccino', true],
  ['Latte', false],
  ['Black', false],
  ['Tea', false],
];

  // user tapped on coffee types
  void coffeeTypeSelected(int index) {
    setState(() {

      // this for loop makes every selection false
      for (int i = 0; i < coffeeType.length; i++) {
        coffeeType[i][1] = false;
      }
      coffeeType[index][1] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.person),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '',
          ),
        ],
      ),
      body: Column(
        children: [
          // Find the best coffee for you
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                Text(
                  'Find the best',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 38.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'coffee for you',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.poppins(
                    fontSize: 38.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 25,
          ),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Find your coffee....',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 25.0,
          ),
          // horizontal listView of coffee types
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: coffeeType.length,
              itemBuilder: (context, index) {
                return CoffeeType(
                  coffeeType: coffeeType[index][0],
                  isSelected: coffeeType[index][1],
                  onTap: (){
                    coffeeTypeSelected(index);
                  },
                );
              },
            ),
          ),

          // horizontal listView of coffee tiles
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CoffeeTile(
                  coffeePrice: '4.20',
                  coffeeImagePath: 'assets/images/latte.jpg',
                  coffeeName: 'Latte',
                  coffeeAdditive: 'With Almond Milk',
                ),
                CoffeeTile(
                  coffeePrice: '4.10',
                  coffeeImagePath: 'assets/images/cappucino.jpg',
                  coffeeName: 'Cappuccino',
                  coffeeAdditive: 'With Oat Milk',
                ),
                CoffeeTile(
                  coffeePrice: '4.60',
                  coffeeImagePath: 'assets/images/milk.jpg',
                  coffeeName: 'Milk Coffee Thing',
                  coffeeAdditive: 'With Cappuccino',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
              'Special for you',
            style: GoogleFonts.poppins(),
          ),
        ],
      ),
    );
  }
}

import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widget/place_card.dart';
import '/widget/popular.place.card.dart';
import '/util/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _places = AppConstants.kDummyData.toList();
  int selectedIndex = 0;

  List<String> categories = [
    'All',
    'Hotels',
    'Beach',
    'Camp',
    'Restaurant',
    'Pool',
    'Home'
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   loadImage('${_places[selectedIndex].image}');
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   precacheImage(AssetImage('${AppConstants.kDummyData[selectedIndex].image}'), context);
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        titleTextStyle: GoogleFonts.workSans(
          fontSize: 22,
          color: AppConstants.kColorOnPrimary
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
              AppConstants.location,
            width: 28,
            height: 28,
            fit: BoxFit.fill,
            color: AppConstants.kColorOnPrimary,
          ),
        ),
        title: const Text(AppConstants.appName),
        actions: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: AppConstants.kColorPrimary,
            ),
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
                onPressed: (){},
                splashColor: Colors.amberAccent,
                icon: Image.asset(AppConstants.notification, height: 30, width: 30,)
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text(
                      'Where you want to go?',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: AppConstants.kColorOnPrimary,),
                  hintText: 'Search your properties....',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.grey)
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  suffixIcon: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(right: 4.0),
                    decoration: const BoxDecoration(
                      color: AppConstants.kColorPrimary,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    child: Image.asset(AppConstants.filter, height: MediaQuery.of(context).size.height * 0.02, width: 30,),
                  )
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Row(
                children: [
                  Text(
                    'Explore places',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              ChipList(
                listOfChipNames: categories,
                listOfChipIndicesCurrentlySeclected: const [1],
                activeBgColorList: [Theme.of(context).primaryColor],
                inactiveBgColorList: const [Colors.white],
                inactiveBorderColorList: const [Color(0xFFE1E6ED)],
                inactiveTextColorList: const [AppConstants.kColorOnPrimary],
                showCheckmark: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: 350,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _places.length,
                  itemBuilder: (context, index) => PlaceCard(place: _places[index]),
                  separatorBuilder: (context, index) => const SizedBox(width: 16,),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Popular places',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: 350,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _places.length,
                  itemBuilder: (context, index) => PopularPlaceCard(place: _places[index]),
                  separatorBuilder: (context, index) => const SizedBox(width: 16,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

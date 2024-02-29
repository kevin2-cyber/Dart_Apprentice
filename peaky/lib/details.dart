import 'package:flutter/material.dart';
import 'package:peaky/model/place.dart';
import 'package:peaky/util/constants.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.place});

  final Place place;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const List<Tab> tabs = [
    Tab(text: 'Overview',),
    Tab(text: 'Reviews',)
  ];

  static List<Widget> tabViews = [
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.yellow,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   toolbarHeight: 80,
        //   flexibleSpace: Container(
        //     decoration: BoxDecoration(
        //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        //       image: DecorationImage(image: AssetImage('${widget.place.image}'), fit: BoxFit.fill)
        //     ),
        //   ),
        //   leading: Container(
        //     margin: const EdgeInsets.all(10),
        //     decoration: const BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //       color: AppConstants.kColorPrimary,
        //     ),
        //     child: IconButton(
        //         onPressed: (){
        //           Navigator.pop(context);
        //         },
        //         splashColor: Colors.amberAccent,
        //         icon: Image.asset(AppConstants.back,)
        //     ),
        //   ),
        //   actions: [
        //     Container(
        //       margin: const EdgeInsets.all(10),
        //       decoration: const BoxDecoration(
        //         borderRadius: BorderRadius.all(Radius.circular(10)),
        //         color: AppConstants.kColorPrimary,
        //       ),
        //       child: IconButton(
        //           onPressed: (){},
        //           splashColor: Colors.amberAccent,
        //           icon: Image.asset(AppConstants.heart, height: 30, width: 30,)
        //       ),
        //     ),
        //   ],
        // ),
        body: CustomScrollView(
          slivers: [
             SliverAppBar(
               automaticallyImplyLeading: false,
              leading: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: AppConstants.kColorPrimary,
                ),
                child: IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    splashColor: Colors.amberAccent,
                    icon: Image.asset(AppConstants.back)
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppConstants.kColorPrimary,
                  ),
                  child: IconButton(
                      onPressed: (){},
                      splashColor: Colors.amberAccent,
                      icon: Image.asset(AppConstants.heart,)
                  ),
                ),
              ],
              floating: true,
              expandedHeight: 300,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('${widget.place.image}'),
                    fit: BoxFit.fill
                  ),
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
                ),
              ),
               bottom: TabBar(tabs: tabs, controller: _tabController,),
            ),
            TabBarView(controller: _tabController,children: tabViews,),
          ],
        ),
      ),
    );
  }
}

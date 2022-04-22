import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../network/recipe_model.dart';
import '../recipe_card.dart';
import 'recipe_details.dart';
import '../widgets/custom_dropdown.dart';
import '../colors.dart';
import '../../network/recipe_service.dart';
import 'package:chopper/chopper.dart';
import '../../network/model_response.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  // Add key
  static const String prefSearchKey = 'previousSearches';
  late TextEditingController searchTextController;
  final ScrollController _scrollController = ScrollController();


  // Replaced with new API class
  List<APIHits> currentSearchList = [];
  int currentCount = 0;
  int currentStartPosition = 0;
  int currentEndPosition = 20;
  int pageCount = 20;
  bool hasMore = false;
  bool loading = false;
  bool inErrorState = false;

  // Add searches array
  List<String> previousSearches = <String>[];


  @override
  void initState() {
    super.initState();
    // Call getPreviousSearches
    getPreviousSearches();
    // Call loadRecipes()
    searchTextController = TextEditingController(text: '');
    _scrollController
        .addListener(() {
      final triggerFetchMoreSize =
          0.7 * _scrollController.position.maxScrollExtent;

      if (_scrollController.position.pixels > triggerFetchMoreSize) {
        if (hasMore &&
            currentEndPosition < currentCount &&
            !loading &&
            !inErrorState) {
          setState(() {
            loading = true;
            currentStartPosition = currentEndPosition;
            currentEndPosition =
                min(currentStartPosition + pageCount, currentCount);
          });
        }
      }
    });
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  // Add savePreviousSearches
  void savePreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(prefSearchKey, previousSearches);
  }

  void getPreviousSearches() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(prefSearchKey)) {
      final searches = prefs.getStringList(prefSearchKey);
      if (searches != null) {
        previousSearches = searches;
      } else {
        previousSearches = <String>[];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildSearchCard(),
            _buildRecipeLoader(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchCard() {
    return Card(
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            // Replace
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                startSearch(searchTextController.text);
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            // *** Start Replace
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: 'Search'
                      ),
                      autofocus: false,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        if (!previousSearches.contains(value)) {
                          previousSearches.add(value);
                          savePreviousSearches();
                        }
                      },
                      controller: searchTextController,
                    ),
                  ),
                  PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: lightGrey,
                      ),
                      onSelected: (String value) {
                        searchTextController.text = value;
                        startSearch(searchTextController.text);
                      },
                      itemBuilder: (BuildContext context) {
                        return previousSearches.map<
                            CustomDropdownMenuItem<String>>((String value) {
                          return CustomDropdownMenuItem<String>(
                            text: value,
                            value: value,
                            callback: () {
                              setState(() {
                                previousSearches.remove(value);
                                Navigator.pop(context);
                              });
                            },
                          );
                        }
                        ).toList();
                      }
                  ),
                ],
              ),
            ),
            // *** End Replace
          ],
        ),
      ),
    );
  }

  // Add startSearch
  void startSearch(String value) {
    setState(() {
      currentSearchList.clear();
      currentCount = 0;
      currentEndPosition = pageCount;
      currentStartPosition = 0;
      hasMore = true;
      value = value.trim();

      if (!previousSearches.contains(value)) {
        previousSearches.add(value);
        savePreviousSearches();
      }
    });
  }

// Replace this _buildRecipeLoader definition
 Widget _buildRecipeLoader(BuildContext context) {
    if (searchTextController.text.length < 3) {
      return Container();
    }
    // Show a loading indicator whilst waiting for the recipes
    return FutureBuilder<Response<Result<APIRecipeQuery>>>(
      future: RecipeService.create().queryRecipes(
          searchTextController.text.trim(),
          currentStartPosition,
          currentEndPosition
      ),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          if(snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          loading = false;
          final result = snapshot.data?.body;
          if (result is Error) {
            // Hit an error
            inErrorState = true;
            return _buildRecipeList(context, currentSearchList);
          }
          final query = (result as Success).value;
          inErrorState = false;
          if(query != null) {
            currentCount = query.counts;
            hasMore = query.more;
            currentSearchList.addAll(query.hits);
            if(query.to < currentEndPosition) {
              currentEndPosition = query.to;
            }
          }
          return _buildRecipeList(context, currentSearchList);
        }
        // Handle not done connection
       else {
         if(currentCount == 0) {
           // Show a loading indicator while waiting for the recipes
           return const Center(
             child: CircularProgressIndicator(),
           );
         }
         else {
           return _buildRecipeList(context, currentSearchList);
         }
        }
      },
    );
  }

  // Add _buildRecipeList()
  Widget _buildRecipeList(BuildContext recipeListContext, List<APIHits> hits) {
    final size = MediaQuery.of(context).size;
    const itemHeight = 310;
    final itemWidth = size.width / 2;
    return Flexible(
      child: GridView.builder(
        controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
          ),
          itemCount: hits.length,
          itemBuilder: (BuildContext context, int index) {
          return _buildRecipeCard(recipeListContext, hits, index);
          },
      ),
    );
  }

// Add _buildRecipeCard
  Widget _buildRecipeCard(BuildContext topLevelContext, List<APIHits> hits,
      int index) {
    final recipe = hits[index].recipe;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          topLevelContext,
          MaterialPageRoute(builder: (context) {
            return const RecipeDetails();
          }
          ),
        );
      },
      // Replace with recipeCard
      child: recipeCard(recipe),
    );
  }
}


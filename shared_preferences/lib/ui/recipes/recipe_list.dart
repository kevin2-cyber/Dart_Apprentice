import 'dart:js';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
//Add imports
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import '../../network/recipe_model.dart';
import '../recipe_card.dart';
import 'recipe_details.dart';
import '../widgets/custom_dropdown.dart';
import '../colors.dart';
import '../../network/recipe_service.dart';

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

  // Add _currentRecipes1
  APIRecipeQuery? _currentRecipes1 = null;


  @override
  void initState() {
    super.initState();
    // Call getPreviousSearches
    getPreviousSearches();
    // Call loadRecipes()
    // TODO: Remove call to loadRecipes()
    loadRecipes();
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


  // Add getRecipeData()
  Future<APIRecipeQuery> getRecipeData(String query, int from, int to) async {
    final recipeJson = await RecipeService().getRecipes(query, from, to);
    final recipeMap = json.decode(recipeJson);
    return APIRecipeQuery.fromJson(recipeMap);
  }


  // TODO: Delete loadRecipes()
  // Add loadRecipes()
  Future loadRecipes() async {
    final jsonString = await rootBundle.loadString('assets/recipes1.json');
    setState(() {
      _currentRecipes1 = APIRecipeQuery.fromJson(jsonDecode(jsonString));
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

// TODO: Replace this _buildRecipeLoader definition
 Widget _buildRecipeLoader(BuildContext context) {
    if (_currentRecipes1 == null || _currentRecipes1?.hits == null) {
      return Container();
    }
    // Show a loading indicator whilst waiting for the recipes
    return Center(
      child: _buildRecipeCard(context, _currentRecipes1!.hits, 0),
    );
  }

  // TODO: Add _buildRecipeList()

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


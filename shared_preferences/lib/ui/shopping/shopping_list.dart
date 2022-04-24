import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repository.dart';

import '../../data/models/ingredient.dart';

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  // TODO 1
  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  final checkBoxValues = <int, bool>{};
  // Remove ingredients declaration

  @override
  Widget build(BuildContext context) {
    // Add Consumer widget
    final repository = Provider.of<Repository>(context);
    return StreamBuilder(
      stream: repository.watchAllIngredients(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final ingredients = snapshot.data as List<Ingredient>?;
          if (ingredients == null) {
            return Container();
          }
          return ListView.builder(
              itemCount: ingredients.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  value: checkBoxValues.containsKey(index) &&
                      checkBoxValues[index]!,
                  // Update title to include name
                  title: Text(ingredients[index].name ?? ''),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        checkBoxValues[index] = newValue;
                      });
                    }
                  },
                );
              });
        } else {
          return Container();
        }
      }
    );
    // Add closing brace and parenthesis
  }
}

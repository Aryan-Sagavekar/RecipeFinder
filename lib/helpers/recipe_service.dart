import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';

class RecipeService {
  List<Recipe> _recipes = [];

  Future<void> loadRecipes() async {
    final String response =
        await rootBundle.loadString('assets/database/recipedata.json');
    final data = await json.decode(response);

    _recipes = (data as List)
        .map((recipeJson) => Recipe.fromJson(recipeJson))
        .toList();
  }

  List<Recipe> searchRecipes(String query) {
    return _recipes
        .where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }
}

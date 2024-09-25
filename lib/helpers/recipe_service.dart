import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';

class RecipeService {
  static List<Recipe> recipes = [];
  Recipe recipeNull = Recipe(
      id: 1,
      name: "Chicken Curry",
      ingredients: ["chicken", "lemon"],
      steps: ["Make chicken ez"]);

  Future<void> loadRecipes() async {
    final String response =
        await rootBundle.loadString('assets/database/recipedata.json');
    final data = await json.decode(response);

    if (data != null && data['recipes'] != null) {
      recipes = (data['recipes'] as List)
          .map((recipeJson) => Recipe.fromJson(recipeJson))
          .toList();
    }

    print(
        "Loaded recipes: ${recipes.length}"); // Check how many recipes are loaded
  }

  List<Recipe> searchRecipes(String query) {
    return recipes
        .where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  Recipe searchOneRecipe(String query) {
    if (recipes.isEmpty) {
      print("No recipes loaded!");
      return recipeNull;
    }

    var filteredRecipes = recipes
        .where(
            (recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (filteredRecipes.isNotEmpty) {
      return filteredRecipes[0];
    } else {
      print("No matching recipe found for query: $query");
      return recipeNull;
    }
  }
}

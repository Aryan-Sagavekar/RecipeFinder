import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';

class RecipeService {
  static List<Recipe> recipes = [];
  static int lastId = 10;
  static Recipe recipeNull = Recipe(
      id: 1,
      name: "Chicken Curry",
      imageUrl: "assets/images/chicken curry.png",
      ingredients: ["chicken", "lemon"],
      steps: ["Make chicken ez"]);

  static Future<void> loadRecipes() async {
    var recipeBox = await Hive.openBox<Recipe>('recipes');

    if (recipeBox.isNotEmpty) {
      recipes = recipeBox.values.toList();

      lastId = recipes.length;

      print("Loaded recipes: ${recipes.length}");
    } else {
      print("No recipes found in Hive.");
    }
  }

  static Future<List<Recipe>> searchRecipes(String query) async {
    var box = await Hive.openBox<Recipe>('recipes');

    List<Recipe> hiveRecipes = box.values.toList();

    return hiveRecipes
        .where((recipe) =>
            recipe.name.toLowerCase().contains(query.toLowerCase()) ||
            recipe.ingredients.any((ingredient) =>
                ingredient.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  static Future<Recipe> searchOneRecipe(String query) async {
    var recipeBox = await Hive.openBox<Recipe>('recipes');

    if (recipeBox.isEmpty) {
      print("No recipes loaded in Hive!");
      return recipeNull;
    }

    var filteredRecipes = recipeBox.values
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

  static Future<void> saveNewRecipe(Recipe newRecipe) async {
    var recipeBox = await Hive.openBox<Recipe>('recipes');

    await recipeBox.add(newRecipe);

    print("Recipe saved successfully in Hive!");
  }
}

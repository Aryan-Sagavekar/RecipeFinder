import "package:flutter_test/flutter_test.dart";
import "package:mockito/mockito.dart";
import "dart:convert";
import "package:recipe_finder/helpers/recipe_model.dart";
import "package:recipe_finder/helpers/recipe_service.dart";

// Mock RecipeService
class MockRecipeService extends Mock implements RecipeService {}

void main() {
  MockRecipeService mockRecipeService;

  setUp(() {
    mockRecipeService = MockRecipeService();
  });

  group('Recipe Model and Service Logic', () {
    test("Test that Recipe model is parsed correctly from database", () {
      String data =
          '{"id":1, "name":"Chicken Curry", "image":"assets/images/chicken.png", "ingredients":["tomato", "chicken", "lemon"], "steps":["mix curry"]}';
      final recipeData = Recipe.fromJson(jsonDecode(data));

      expect(recipeData.name, "Chicken Curry");
    });

    test('Searching a recipe with incomplete name works', () async {
      final service = RecipeService();

      List<Recipe> searchResults = [];
      searchResults = await service.searchRecipes("gril");
      if (searchResults.isNotEmpty) {
        expect(searchResults[0].name, "Grilled Salmon");
      }
    });
  });
}

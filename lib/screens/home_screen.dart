import 'package:flutter/material.dart';
import 'package:recipe_finder/helpers/recipe_service.dart';
import 'package:recipe_finder/screens/search_screen.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ingredientController = TextEditingController();
  RecipeService _recipeService = RecipeService();

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    await _recipeService.loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _ingredientController,
                decoration: const InputDecoration(
                  hintText: 'Enter ingredients you have...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchPage())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Center(
                  child: Text(
                    'Find Recipes',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildFeaturedRecipe(),
              const SizedBox(height: 20),
              const Text(
                'Popular Recipes:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildPopularRecipes(),
            ],
          ),
        ),
      ),
    );
  }

  // Featured Recipe of the Day Section
  Widget _buildFeaturedRecipe() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: const Column(
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image(image: AssetImage("assets/images/grilledsalmon.png")),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Featured Recipe: Grilled Salmon',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Horizontal scrollable popular recipes section
  Widget _buildPopularRecipes() {
    if (RecipeService.recipes.isEmpty) {
      return CircularProgressIndicator();
    }

    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          RecipeCard(
            recipeName: 'Spaghetti Carbonara',
            imageLoc: 'assets/images/spaghetti.png',
          ),
          RecipeCard(
            recipeName: 'Chicken Curry',
            imageLoc: 'assets/images/chicken.png',
          ),
          RecipeCard(
            recipeName: 'Paneer Tikka',
            imageLoc: 'assets/images/paneer.png',
          ),
        ],
      ),
    );
  }

  void _searchRecipes() {
    final ingredients = _ingredientController.text;
    if (ingredients.isNotEmpty) {
      // Placeholder for searching logic - we'll add backend later
      print('Searching recipes with: $ingredients');
    }
  }
}

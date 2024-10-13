import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';
import 'package:recipe_finder/screens/add_recipe.dart';
import 'package:recipe_finder/screens/search_screen.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _ingredientController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Finder'),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            size: 28,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddRecipeScreen()))),
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

  Widget _buildFeaturedRecipe() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: const Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image(image: AssetImage("assets/images/grilled salmon.png")),
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

  Widget _buildPopularRecipes() {
    return FutureBuilder(
      future: Hive.openBox<Recipe>('recipes'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          var box = Hive.box<Recipe>('recipes');
          if (box.values.isEmpty) {
            return const Text('No popular recipes found');
          }

          // return Text(box.values.last.name);
          return SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: box.values.map((recipe) {
                return RecipeCard(
                  recipeName: recipe.name,
                  imageLoc: recipe.imageUrl,
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  void _searchRecipes() {
    final ingredients = _ingredientController.text;
    if (ingredients.isNotEmpty) {
      print('Searching recipes with: $ingredients');
    }
  }
}

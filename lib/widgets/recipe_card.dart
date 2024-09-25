import 'package:flutter/material.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';
import 'package:recipe_finder/helpers/recipe_service.dart';
import 'package:recipe_finder/screens/recipe_screen.dart';

class RecipeCard extends StatefulWidget {
  final String recipeName;
  final String imageLoc;

  RecipeCard({
    required this.recipeName,
    required this.imageLoc,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  RecipeService _recipeService = RecipeService();
  late Recipe _searchResult;

  @override
  void initState() {
    super.initState();
    _fetchRecipe();
  }

  void _fetchRecipe() {
    setState(() {
      _searchResult = _recipeService.searchOneRecipe(widget.recipeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 200, // Control the width for horizontal scrolling
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image(
                width: 200,
                height: 150,
                fit: BoxFit.fill,
                image: AssetImage(widget.imageLoc),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.recipeName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecipeDetails(
                              recipeName: _searchResult.name,
                              imageLoc: _searchResult.imageUrl,
                              ingredients: _searchResult.ingredients,
                              steps: _searchResult.steps,
                            )))
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text('View Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}

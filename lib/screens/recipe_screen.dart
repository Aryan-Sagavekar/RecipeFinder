import 'package:flutter/material.dart';

class RecipeDetails extends StatelessWidget {
  final String recipeName;
  final String imageLoc;
  late List<String> ingredients;
  late List<String> steps;

  RecipeDetails({
    required this.recipeName,
    required this.imageLoc,
    this.ingredients = const [],
    this.steps = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.greenAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Image
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  height: 100,
                  width: 200,
                  image: AssetImage(imageLoc),
                ),
              ),
              SizedBox(height: 20),

              // Ingredients Section
              Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildIngredientsList(),

              SizedBox(height: 20),

              // Steps Section
              Text(
                'Steps',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              _buildStepsList(),
            ],
          ),
        ),
      ),
    );
  }

  // Build a list of ingredients
  Widget _buildIngredientsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients.map((ingredient) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Text(
            '• $ingredient',
            style: TextStyle(fontSize: 16),
          ),
        );
      }).toList(),
    );
  }

  // Build a list of steps to make the dish
  Widget _buildStepsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: steps.asMap().entries.map((entry) {
        int stepNumber = entry.key + 1;
        String step = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$stepNumber. ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Text(
                  step,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

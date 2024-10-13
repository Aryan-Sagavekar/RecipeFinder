import 'package:flutter/material.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';
import 'package:recipe_finder/helpers/recipe_service.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  String _recipeName = '';
  String _ingredients = '';
  String _steps = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      RecipeService.lastId++;
      Recipe newRecipe = Recipe(
        id: RecipeService.lastId,
        name: _recipeName,
        imageUrl: 'assets/images/blank.png',
        ingredients: _ingredients.split(','),
        steps: _steps.split('.'),
      );

      await RecipeService.saveNewRecipe(newRecipe);

      await RecipeService.loadRecipes();
      if (mounted) Navigator.pop(context, newRecipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Recipe Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _recipeName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Ingredients (comma separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter ingredients';
                  }
                  return null;
                },
                onSaved: (value) {
                  _ingredients = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Steps (period separated)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the steps';
                  }
                  return null;
                },
                onSaved: (value) {
                  _steps = value!;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

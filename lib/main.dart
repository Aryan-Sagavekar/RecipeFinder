import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';
import 'dart:async';

import 'package:recipe_finder/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  await initializeDatabaseFromJson();
  await Hive.openBox<Recipe>('recipes');
  runApp(const RecipeFinderApp());
}

class RecipeFinderApp extends StatelessWidget {
  const RecipeFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigate to the home screen after 3 seconds
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Recipe Finder',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> initializeDatabaseFromJson() async {
  var recipeBox = await Hive.openBox<Recipe>('recipes');

  if (recipeBox.isEmpty) {
    final String response =
        await rootBundle.loadString('assets/database/recipedata.json');
    final Map<String, dynamic> data = jsonDecode(response);
    List<Recipe> initialRecipes = (data['recipes'] as List)
        .map((recipeJson) => Recipe.fromJson(recipeJson))
        .toList();

    for (var recipe in initialRecipes) {
      await recipeBox.put(recipe.id, recipe);
    }

    print('Recipes loaded from JSON and added to the Hive database.');
  } else {
    print('Recipes already exist in the database.');
  }
}

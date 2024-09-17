import 'package:flutter/material.dart';
import 'package:recipe_finder/screens/recipe_screen.dart';

class RecipeCard extends StatelessWidget {
  final String recipeName;
  final String imageLoc;

  RecipeCard({
    required this.recipeName,
    required this.imageLoc,
  });

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
                image: AssetImage(imageLoc),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                recipeName,
                style: TextStyle(
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
                            recipeName: recipeName, imageLoc: imageLoc)))
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: Text('View Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}

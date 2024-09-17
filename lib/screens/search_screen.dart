import 'package:flutter/material.dart';
import '../widgets/recipe_card.dart'; // Import the RecipeCard widget

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ['Pasta', 'Salmon', 'Chicken Curry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for recipes...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: 20),

            const Text(
              'Recent Searches:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildRecentSearches(),

            const SizedBox(height: 20),

            const Text(
              'Suggested Recipes:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildSuggestedRecipes(),
          ],
        ),
      ),
    );
  }

  // Display a list of recent searches
  Widget _buildRecentSearches() {
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentSearches.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _searchController.text = recentSearches[index];
                // We can trigger a search logic later here
                print('Recent search selected: ${recentSearches[index]}');
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.greenAccent.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  recentSearches[index],
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSuggestedRecipes() {
    return Expanded(
      child: ListView(
        children: [
          RecipeCard(
            recipeName: 'Spaghetti Bolognese',
            imageLoc: 'assets/images/spaghetti.png',
          ),
          RecipeCard(
            recipeName: 'Chicken Curry',
            imageLoc: 'assets/images/chicken.png',
          ),
          RecipeCard(
            recipeName: 'Vegan Salad',
            imageLoc: 'assets/images/grilledsalmon.png',
          ),
        ],
      ),
    );
  }
}

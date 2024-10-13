import 'package:flutter/material.dart';
import 'package:recipe_finder/helpers/recipe_model.dart';
import 'package:recipe_finder/helpers/recipe_service.dart';
import '../widgets/recipe_card.dart'; // Import the RecipeCard widget

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = ['Pasta', 'Salmon', 'Chicken Curry'];
  List<Recipe> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    await RecipeService.loadRecipes();
  }

  void _updateSearchResults(String query) async {
    _searchResults = [];
    _searchResults = await RecipeService.searchRecipes(query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Recipes'),
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
              onChanged: (query) => _updateSearchResults(query),
              decoration: const InputDecoration(
                hintText: 'Search for recipes...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
            if (_searchController.text != "") _buildSearchResults(),
            const SizedBox(height: 20),
            if (_searchController.text == "")
              const Text(
                'Recent Searches:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 10),
            if (_searchController.text == "") _buildRecentSearches(),
            if (_searchController.text == "") const SizedBox(height: 20),
            if (_searchController.text == "")
              const Text(
                'Suggested Recipes:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (_searchController.text == "") SizedBox(height: 10),
            if (_searchController.text == "") _buildSuggestedRecipes(),
          ],
        ),
      ),
    );
  }

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
                  style: const TextStyle(color: Colors.black),
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
            imageLoc: 'assets/images/spaghetti carbonara.png',
          ),
          RecipeCard(
            recipeName: 'Chicken Curry',
            imageLoc: 'assets/images/chicken curry.png',
          ),
          RecipeCard(
            recipeName: 'Salmon Fry',
            imageLoc: 'assets/images/grilled salmon.png',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Expanded(
      child: Container(
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return RecipeCard(
                recipeName: _searchResults[index].name,
                imageLoc: _searchResults[index].imageUrl);
          },
        ),
      ),
    );
  }
}

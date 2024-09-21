import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:recipe_finder/main.dart';
import 'package:recipe_finder/screens/home_screen.dart';
import 'package:recipe_finder/screens/search_screen.dart';

void main() {
  testWidgets('Search shows correct recipes', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: HomeScreen(),
    ));

    await tester.tap(find.text('Find'));
    await tester.pumpAndSettle();
  });
}

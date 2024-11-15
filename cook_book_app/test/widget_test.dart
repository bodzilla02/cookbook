import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cook_book_app/main.dart';

void main() {
  testWidgets('Splash screen displays CookBook text', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(CookBookApp());

    // Verify that the SplashScreen widget is displayed and contains the "CookBook" text.
    expect(find.text('CookBook'), findsOneWidget);

    // Wait for the splash screen to disappear (3 seconds).
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that the splash screen is no longer visible, and the next screen (RecipeLibraryScreen) is displayed.
    expect(find.text('Recipe Library'), findsOneWidget);
  });
}

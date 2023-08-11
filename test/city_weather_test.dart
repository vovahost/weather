// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather/presentation/city_weather/ui/city_weather_page.dart';

void main() {
  testWidgets('Fetch city weather search bar is displayed and tappable',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CityWeatherPage(),
        ),
      ),
    );
    await tester.idle();

    // // Verify that our search bar is shown initially.
    final searchField = find.ancestor(
      of: find.text('Type a city'),
      matching: find.byType(TextField),
    );

    await tester.enterText(searchField, "London");
    await tester.tap(find.byIcon(Icons.search));
    await tester.idle();
    await tester.pump();
  });
}

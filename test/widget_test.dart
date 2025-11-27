// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exercises_week4_namphuong/main.dart';

void main() {
  testWidgets('Menu screen shows exercise list', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExerciseWeek4App());

    // Verify that the app bar title is correct.
    expect(find.text('Exercise Week 4 - Menu'), findsOneWidget);

    // Verify that the first exercise item is displayed.
    expect(find.text('Bài 1: ListView'), findsOneWidget);
    expect(find.text('Danh sách contact có avatar'), findsOneWidget);
  });
}

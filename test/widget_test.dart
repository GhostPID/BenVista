import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:BenVista/main.dart';

void main() {
  testWidgets('MovieVault app test', (WidgetTester tester) async {
    await tester.pumpWidget(const MovieVaultApp());

    expect(find.text('My Watch List'), findsOneWidget);
  });
}
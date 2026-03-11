import 'package:flutter_test/flutter_test.dart';

import 'package:stylo/app/app.dart';

void main() {
  testWidgets('App renders smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const StyloApp());

    expect(find.text('Stylo'), findsOneWidget);
  });
}

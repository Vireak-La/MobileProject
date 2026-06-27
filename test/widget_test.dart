import 'package:flutter_test/flutter_test.dart';
import 'package:mobileproject/app.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify that the start page elements are present.
    expect(find.text('CYBER-RIG PRO'), findsOneWidget);
    expect(find.text('ENTER THE MATRIX OF CUSTOM\nPOWER'), findsOneWidget);
  });
}

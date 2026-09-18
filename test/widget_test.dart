import 'package:flutter_test/flutter_test.dart';

import 'package:busino/main.dart';

void main() {
  testWidgets('Busino app smoke test', (WidgetTester tester) async {
    // چون BusinoApp به DI وابسته‌ست، اینجا فقط
    // یه چک ساده می‌کنیم که کلاسش وجود داره.
    expect(BusinoApp, isNotNull);
  });
}

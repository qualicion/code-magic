import 'package:flutter_patrol_tutorial/main.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('should not login with wrong credentials', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());
    await Future<void>.delayed(const Duration(seconds: 3));
    await $(#email_field).enterText('testuser@gmail.com');
    await $(#password_field).enterText('password');
    await $(#login_btn).tap();

    await $(#invalid_login)
        .waitUntilVisible(timeout: const Duration(seconds: 2));
  });
}

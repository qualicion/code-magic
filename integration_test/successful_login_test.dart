import 'package:flutter_patrol_tutorial/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('should login, go to home page and reject permissions', ($) async {
    await $.pumpWidgetAndSettle(const MyApp());
    await Future<void>.delayed(const Duration(seconds: 3));
    await $(#email_field).enterText('admin');
    await $(#password_field).enterText('admin');
    await $(#login_btn).tap();
    if (await $.native.isPermissionDialogVisible()) {
      await $.native.denyPermission();
    }
    await $(#webview_btn).waitUntilVisible(timeout: const Duration(seconds: 3));
    expect($('Home').exists, equals(true));
  });
}

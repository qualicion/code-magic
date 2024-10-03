import 'package:flutter_patrol_tutorial/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  patrolTest('full e2e test', ($) async {
    // first we initialize our app for test (pumping and settle)
    await $.pumpWidgetAndSettle(const MyApp());

    await Future<void>.delayed(const Duration(seconds: 2));

    // find the email textfield by its key and enter the text `admin`
    await $(#email_field).enterText('admin');

    // enter password also
    await $(#password_field).enterText('admin');

    // tap on our sign in button to sign in
    await $(#login_btn).tap();

    // wait for the permission dialog to become visible then dismiss it by denying permission
    if (await $.native.isPermissionDialogVisible()) {
      await $.native.denyPermission();
    }
    await $.pumpAndSettle();
    await $(#request_btn).waitUntilVisible(timeout: const Duration(seconds: 3));
    await Future<void>.delayed(const Duration(seconds: 2));

    // tap on the button to open our webview
    await $(#webview_btn).tap();
    await Future<void>.delayed(const Duration(seconds: 5));

    // dismiss the webview by going back to previous screen
    await $.native.pressBack();
    await Future<void>.delayed(const Duration(seconds: 2));

    // request for permission and grant them when the dialog becomes visible
    await $(#request_btn).tap();
    if (await $.native.isPermissionDialogVisible()) {
      await $.native.grantPermissionWhenInUse();
    }
    await $.pumpAndSettle();

    // if permission was granted, the request button should be removed
    expect($(#request_btn), findsNothing);
    await Future<void>.delayed(const Duration(seconds: 2));

    // we tap on sign out button
    await $(#signout_btn).tap();

// if signed out, we should be taken back to the Login page.
    expect($('Login').exists, equals(true));
  });
}

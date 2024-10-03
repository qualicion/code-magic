import 'package:flutter/material.dart';
import 'package:flutter_patrol_tutorial/login_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? permissionDenied;
  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeButton(
                    btnKey: 'webview_btn',
                    onPressed: openLink,
                    btnIcon: Icons.open_in_browser,
                    btnIconColor: const Color.fromRGBO(255, 255, 255, 1),
                    avatarBgColor: Colors.green,
                    btnTitle: 'Open webview'),
                const SizedBox(
                  width: 50,
                ),
                HomeButton(
                    btnKey: 'signout_btn',
                    onPressed: logOut,
                    btnIcon: Icons.exit_to_app,
                    btnIconColor: Colors.white,
                    avatarBgColor: Colors.red,
                    btnTitle: 'Sign out'),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            if (permissionDenied ?? false)
              HomeButton(
                  btnKey: 'request_btn',
                  onPressed: requestPermission,
                  btnIcon: Icons.notifications_active,
                  btnIconColor: Colors.white,
                  avatarBgColor: Colors.amber,
                  btnTitle: 'Request Permission'),
          ],
        )),
      ),
    );
  }

  requestPermission() async {
    var notificationsPermission = await Permission.notification.status;

    if (notificationsPermission != PermissionStatus.granted) {
      var newStatus = await Permission.notification.request();
      bool wasDenied = newStatus.isDenied || newStatus.isPermanentlyDenied;
      if (wasDenied && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please grant permissions')));

        permissionDenied = true;
        setState(() {});
      } else {
        permissionDenied = false;
        setState(() {});
      }
    }
  }

  openLink() async {
    var wasLaunched = await launchUrl(Uri.parse('https://google.com'));
    if (!wasLaunched && mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Could not launch link')));
    }
  }

  logOut() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton(
      {super.key,
      required this.btnIcon,
      required this.btnIconColor,
      required this.avatarBgColor,
      required this.btnTitle,
      required this.btnKey,
      required this.onPressed});
  final IconData btnIcon;
  final Color btnIconColor, avatarBgColor;
  final String btnTitle, btnKey;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          key: Key(btnKey),
          onTap: onPressed,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: avatarBgColor,
            child: Icon(
              btnIcon,
              color: btnIconColor,
              size: 35,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          btnTitle,
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}

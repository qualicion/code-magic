import 'package:flutter/material.dart';
import 'package:flutter_patrol_tutorial/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: Center(
                  child: Text(
                    'Welcome back!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                key: const Key('email_field'),
                controller: _emailController,
                decoration: const InputDecoration(
                    label: Text('Email'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                key: const Key('password_field'),
                controller: _passwordController,
                decoration: const InputDecoration(
                    label: Text('Password'),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelAlignment: FloatingLabelAlignment.start),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: 150,
                child: OutlinedButton.icon(
                    key: const Key('login_btn'),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)),
                    onPressed: signInUser,
                    icon: const Icon(
                      Icons.exit_to_app,
                      size: 25,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              )
            ],
          ),
        )),
      ),
    );
  }

  signInUser() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email == 'admin' && password == 'admin') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 5),
          key: Key('invalid_login'),
          content: Text('Invalid credentials')));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void signInWithGoogle(BuildContext context) async {
    final response = await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google
    );

    if (response == false ) {
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to sign in with Google')));
    } else {
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signInWithGoogle(context),
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}

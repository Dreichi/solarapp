import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up / Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('images/logo.png')),
              const SizedBox(
                  height: 15
              ),
              SupaEmailAuth(
                onSignInComplete: (response) {
                  if (response.user != null) {
                    Navigator.of(context).pushReplacementNamed('/main');
                  }
                },
                onSignUpComplete: (response) {
                  if (response.user != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Inscription réussie'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: const <Widget>[
                                Text('Veuillez vérifier votre e-mail pour activer votre compte.'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                metadataFields: [
                  MetaDataField(
                    prefixIcon: const Icon(Icons.person),
                    label: 'Nom',
                    key: 'name',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Rentrez quelque chose';
                      }
                      return null;
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),


              SupaSocialsAuth(
                socialProviders: [
                  OAuthProvider.google,
                ],
                colored: true,
                onSuccess: (Session response) {
                  Navigator.of(context).pushReplacementNamed('/main');
                },
                onError: (error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Authentication error: $error')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

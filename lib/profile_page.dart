import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  List<String> surfaces = ['Maison', 'Boulot'];

  var _loading = true;

  Future<void> _getProfile() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data =
      await supabase.auth.getUserIdentities();
      _usernameController.text = (data[0].identityData?['name'] ?? 'Toto') as String;
      _emailController.text = (supabase.auth.currentUser?.email ?? 'toto@gmail.com') as String;
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  /// Called when user taps `Update` button
  Future<void> _updateProfile() async {
    setState(() {
      _loading = true;
    });
    try {
      final UserResponse res = await supabase.auth.updateUser(
        UserAttributes(
            data: {
              'name': _usernameController.text.trim()
            }
        ),
      );
      final User? updatedUser = res.user;
    } on PostgrestException catch (error) {
      SnackBar(
        content: Text(error.message),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } catch (error) {
      SnackBar(
        content: const Text('Unexpected error occurred'),
        backgroundColor: Theme.of(context).colorScheme.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Widget userForm() {
    return Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const SizedBox(
          height: 15
        ),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              labelText: 'Nom d\'utilisateur', border: OutlineInputBorder()),
          style: TextStyle(fontSize: 20),
          validator: (userName) {
            if (userName == null || userName.isEmpty) {
              return 'Vous devez avoir un nom d\'utitlisateur';
            }
          },
        ),
        const SizedBox(
            height: 15
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
              labelText: 'Email', border: OutlineInputBorder()),
          style: TextStyle(fontSize: 20),
          validator: (email) {
            if (email == null || email.isEmpty) {
              return 'Vous devez avoir un email';
            }
          },
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStatePropertyAll(Size(90, 60)),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _updateProfile();
              }
            },
            child: const Text('Mettre à jour'),
          ),
        ),]));
  }

  Widget showRegisteredSurfaces() {
    List<Widget> registeredSurfaces = [const SizedBox(
      height: 15,
    ),
      ElevatedButton(onPressed: () {
      print('Toto');
    }, child: const Text('Nouvelle surface')), const SizedBox(
        height: 50,
      ),];
    for (String surface in surfaces) {
      registeredSurfaces.add(const SizedBox(
        height: 15,
      ),);
      registeredSurfaces.add(Text(surface));
    }
    return Column(children: registeredSurfaces,);
  }

  Widget profileBody(){
    return Center(child: Column(children: [SizedBox(height: 15,), userForm(), const Divider(), showRegisteredSurfaces()],),);
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mon profil'),
      ),
      body: profileBody(),
    );
  }
}
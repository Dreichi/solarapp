import 'package:flutter/material.dart';
import 'package:solar/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page.dart';
import 'main_page.dart';
import 'splash_screen.dart';


Future<void> main() async {
  await Supabase.initialize(
    url: 'https://butjjjolfrvpnltlcrcd.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ1dGpqam9sZnJ2cG5sdGxjcmNkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDgzMzU3MTEsImV4cCI6MjAyMzkxMTcxMX0.5pt26gci9ecKkFtypYaR9KuV6RL3WqKAn9cQbZOxWMM',
  );

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/main': (_) => MainPage(),
        '/profile': (_) => const ProfilePage(),
      },
    );
  }
}
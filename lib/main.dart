import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qnjdosjjlrjmpdwxzfjy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFuamRvc2pqbHJqbXBkd3h6Zmp5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY1MzQsImV4cCI6MjA0NzMwMjUzNH0.JNWo8FhDIHwYy72twEYYnp0uxalRJJa6eEEqqD-TipE',);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Library',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

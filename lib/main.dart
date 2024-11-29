import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud_perpustakaan/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // mencari gunanya
  await Supabase.initialize(
    url: 'https://dbdaajjrcqggaixwolgr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRiZGFhampyY3FnZ2FpeHdvbGdyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY2OTIsImV4cCI6MjA0NzMwMjY5Mn0.xJh7Ki0qfKY4At0EfKtepPUYtPmDHODU2iR95q2aKeY',);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Library',
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
      );
  }
}

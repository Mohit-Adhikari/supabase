import 'package:flutter/material.dart';
import 'package:supabase_bucket/upload_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  await Supabase.initialize(
    url: 'https://fwhponoldzlbxzkxpowv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ3aHBvbm9sZHpsYnh6a3hwb3d2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg2MDE0ODIsImV4cCI6MjA1NDE3NzQ4Mn0.SeKxK7vKKI7wmBr9d0R0Wy4yCR9AqhukwuPA4QEZN0o',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadPage(),
      
    );
  }
}


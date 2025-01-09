import 'package:flutter/material.dart';
import 'package:kasir/loginpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xlkyexmwakwzkpfcpwge.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhsa3lleG13YWt3emtwZmNwd2dlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYyOTY4OTksImV4cCI6MjA1MTg3Mjg5OX0.mir4kUlkj6GfU7c1GBnz_dmyc6EhEq649ZQ2RCIkmII',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Kasir App Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Desain lingkaran dekorasi
          Positioned(
            top: -250,
            left: -150,
            child: Container(
              width: 450,
              height: 380,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 100,
            right: 100,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -90,
            right: -200,
            child: Container(
              width: 450,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.pink[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            left: -250,
            child: Container(
              width: 450,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Gambar toko
          Positioned(
            top: 170,
            left: 20,
            right: 20,
            child: Image.asset(
              'assets/images/toko-removebg-preview.png',
              width: 370,
              height: 370,
              fit: BoxFit.contain,
            )
          ),
          // Tombol login
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyLoginPage()),
                );
              },
              child: const Text('Login'),
            ),
          )

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -65,
            child: Container(
              width: 200, // Menambahkan ukuran lebar
              height: 200, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 175,
            child: Container(
              width: 45, // Menambahkan ukuran lebar
              height: 45, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 205,
            child: Container(
              width: 65, // Menambahkan ukuran lebar
              height: 65, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: 45,
            child: Container(
              width: 275, // Menambahkan ukuran lebar
              height: 215, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 122,
            left: 170,
            child: Container(
              width: 350, // Menambahkan ukuran lebar
              height: 315, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -60,
            child: Container(
              width: 150, // Menambahkan ukuran lebar
              height: 115, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.blue[200],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -90,
            child: Container(
              width: 150, // Menambahkan ukuran lebar
              height: 115, // Menambahkan ukuran tinggi
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 450,
            right: 50,
            left: 50,
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),
            ),
          ),
          Positioned(
            top: 520,
            right: 50,
            left: 50,
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),
            ),
          ),
          Positioned(
            top: 600,
            left: 90,
            right: 90,
            child: ElevatedButton(
              onPressed: (){}, 
              child: Text('Login')
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Image.asset('assets/images/toko3-removebg-preview.png'))
        ],
      ),
    );
  }
}

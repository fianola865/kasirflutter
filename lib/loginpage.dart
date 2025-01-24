import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin/homepage.dart';

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

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final supabaseClient = Supabase.instance.client;

  Future<void> _login() async {
    final Username = _username.text.trim();
    final Password = _password.text.trim();

    if (Username.isEmpty || Password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password tidak boleh kosong')),
      );
      return;
    }

    try {
      final response = await supabaseClient
          .from('user')
          .select('Username, Password')
          .eq('Username', Username)
          .single();

      if (response != null && response['Password'] == Password) {
        // Login berhasil, navigasi ke homepage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan, coba lagi nanti')),
      );
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -80,
            left: -65,
            child: Container(
              width: 200,
              height: 200,
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
              width: 45,
              height: 45,
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
              width: 65,
              height: 65,
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
              width: 275,
              height: 215,
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
              width: 350,
              height: 315,
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
              width: 150,
              height: 115,
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
              width: 150,
              height: 115,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 20,
            right: 20,
            child: Image.asset('assets/images/toko3-removebg-preview.png'),
          ),
          Positioned(
            top: 450,
            right: 50,
            left: 50,
            child: TextField(
              controller: _username,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'Username',
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          // Password field
          Positioned(
            top: 520,
            right: 50,
            left: 50,
            child: TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          // Login button
          Positioned(
            top: 600,
            left: 90,
            right: 90,
            child: ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}





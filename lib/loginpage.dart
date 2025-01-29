import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin/adminhomepage.dart';
import 'petugas/petugashomepage.dart'; // Tambahkan halaman untuk petugas jika diperlukan

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
    final username = _username.text.trim();
    final password = _password.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan password tidak boleh kosong')),
      );
      return;
    }

    try {
      // Ambil data username, password, dan role
      final response = await supabaseClient
          .from('user ')
          .select('Username, Password, Role')
          .eq('Username', username)
          .single();

      if (response != null && response['Password'] == password) {
        final role = response['Role'];

        if (role == 'admin') {
          // Jika admin, navigasi ke halaman AdminHomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        } else if (role == 'petugas') {
          // Jika petugas, navigasi ke halaman PetugasHomePage
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PetugasHomePage()),
          );
        } else {
          // Role lain, tampilkan pesan
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Role tidak dikenal')),
          );
        }
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
          // Latar belakang dan UI tetap sama seperti sebelumnya
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
          // Field username
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
          // Field password
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
          // Tombol login
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

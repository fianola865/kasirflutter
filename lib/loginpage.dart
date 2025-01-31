import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'admin/adminhomepage.dart';

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
      final response = await supabaseClient
          .from('user')
          .select('Userid, Username, Password, Role')
          .eq('Username', username)
          .maybeSingle();

      if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username tidak ditemukan')),
        );
        return;
      }

      if (response['Password'] == password) {
        final role = response['Role'];
        final userId = response['Userid']; // ID user berhasil diambil

        print('User ID: $userId'); // Debugging untuk melihat User ID

        if (role == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        } else if (role == 'petugas'){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Role tidak dikenal')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password salah')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan: $error')),
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

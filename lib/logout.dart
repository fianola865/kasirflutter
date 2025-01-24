import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginpage.dart'; // Make sure to import your login page here

class PetugasHomePage extends StatelessWidget {
  // Function to clear user session data
  void _clearUserSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('role');
  }

  // Logout function
  void _logout(BuildContext context) {
    // Clear user session data
    _clearUserSession();

    // Navigate back to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyLoginPage()), // Assuming MyLoginPage is your login screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Petugas Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Petugas action here
              },
              child: Text('Petugas Action'),
            ),
            ElevatedButton(
              onPressed: () => _logout(context), // Call logout function
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

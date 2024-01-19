import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:schluckspecht_app/Admin.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;

    String apiUrl = 'http://localhost:8080/login';

    try {

      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPage()),
        );
      } else {
        // Handle unsuccessful login
        print('Login failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any network or other errors
      print('Error during login: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: handleLogin,
              child: Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_import
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:api_pgms/register.dart';
// ignore: unused_import
import 'package:api_pgms/webservices/webservices.dart';
import 'homepage.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

String? loggedInUsername;

class _MyLoginPageState extends State<MyLoginPage> {
  late SharedPreferences _prefs;
  bool isLoggedin = false;

  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  Future<void> checkLoginState() async {
    _prefs = await SharedPreferences.getInstance();
    isLoggedin = _prefs.getBool('isloggedin') ?? false;

    if (isLoggedin) {
       loggedInUsername = _prefs.getString("username");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Homepage(), // Replace 'Homepage' with your actual home page widget
        ),
      );
    }
  }

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    try {
      final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/login.php"),
        body: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          _prefs.setBool("isloggedin", true);
          _prefs.setString("username", username);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
            
            return Homepage();
          }));
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Invalid username or password'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to connect to the server'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An unexpected error occurred'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WELCOME BACK",
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
            SizedBox(
              height: 10,
            ),
            Text("Login with your username and password"),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an Account?"),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctd) {
                        return RegisterPage();
                      }));
                    },
                    child: Text(
                      " Register Now",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter_csdl/session_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isObscure = true;
  late ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, String> jsonData = {
        "username": _userIdController.text,
        "password": _passwordController.text
      };
      Map<String, String> requestBody = {
        "json": jsonEncode(jsonData),
        "operation": "login",
      };
      var res = await http.post(
        Uri.parse("${SessionStorage.url}users.php"),
        body: requestBody,
      );
      // print("print ni login: " + res.body);
      if (res.body != "0") {
        // goes to home page
      } else {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text("Invalid username or password"),
            duration: Duration(seconds: 2),
          ),
        );
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text("There was an unexpected error: $e"),
          duration: const Duration(seconds: 5),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _userIdController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Id",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                obscureText: _isObscure,
                controller: _passwordController,
                autofocus: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => _isObscure = !_isObscure);
                    },
                    icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: _isLoading ? null : _login,
                  color: Colors.blue,
                  height: 60.0,
                  elevation: 5.0,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

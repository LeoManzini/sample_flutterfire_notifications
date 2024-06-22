import 'package:flutter/material.dart';

import '../controllers/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30)),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                    hintText: "Enter your email"
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                    hintText: "Enter your password"
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                    onPressed: () async {
                      await AuthService.createAccountWithEmail(_emailController.text, _passwordController.text)
                      .then((value) {
                        if (value == "Account created") {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                          Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content:
                              Text(value, style: TextStyle(color: Colors.white),
                              ), backgroundColor: Colors.red.shade400,
                            )
                          );
                        }
                      });
                    },
                    child: const Text("Sign Up")
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Login")
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _authController = AuthController();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  bool loading = false;

  void signUp() async {
    if (passCtrl.text != confirmCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Les mots de passe ne correspondent pas")),
      );
      return;
    }

    setState(() => loading = true);

    final err = await _authController.signUp(
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
      phoneCtrl.text.trim(),
    );

    setState(() => loading = false);

    if (err == null) {
      Navigator.pop(context); // retour login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Compte créé avec succès")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffA8DCD1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ... Ton UI reste pareil

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff0E7C7B),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // EMAIL
                  TextField(
                    controller: emailCtrl,
                    decoration: _decor("Email", Icons.email_outlined),
                  ),

                  const SizedBox(height: 15),

                  // PASSWORD
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: _decor("Password", Icons.lock_outline),
                  ),

                  const SizedBox(height: 15),

                  // CONFIRM
                  TextField(
                    controller: confirmCtrl,
                    obscureText: true,
                    decoration: _decor("Confirm Password", Icons.lock_outline),
                  ),

                  const SizedBox(height: 15),

                  // PHONE
                  TextField(
                    controller: phoneCtrl,
                    decoration: _decor("Phone", Icons.phone),
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: loading ? null : signUp,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: const Color(0xff0E7C7B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Sign Up",
                              style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _decor(String text, IconData icon) {
    return InputDecoration(
      hintText: text,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: const Color(0xffF1F5F9),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}

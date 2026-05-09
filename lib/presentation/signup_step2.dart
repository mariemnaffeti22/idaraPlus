import 'package:flutter/material.dart';
import 'package:idara_plus/administration_page.dart';

class SignupPageTwo extends StatefulWidget {
  const SignupPageTwo({super.key});

  @override
  State<SignupPageTwo> createState() => _SignupPageTwoState();
}

class _SignupPageTwoState extends State<SignupPageTwo> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF1F9FB), Colors.white, Color(0xFFD1EEF8)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset('assets/logo.png', height: 60),
                const SizedBox(height: 10),
                const Text(
                  "Create new account",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                const SizedBox(height: 40),

                _label("Email / CIN"),
                _input("Enter your email address"),
                const SizedBox(height: 20),
                _label("Password"),
                _input("Enter your password", isPwd: true),
                const SizedBox(height: 20),
                _label("Confirm Password"),
                _input("Enter your confirm password", isPwd: true),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdministrationPage(),
                        ),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0091D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                const Text(
                  "other way to sign in",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 20),
                _googleButton(),

                const SizedBox(height: 40),
                _footerLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        t,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );

  Widget _input(String h, {bool isPwd = false}) => TextField(
    obscureText: isPwd ? _isObscure : false,
    decoration: InputDecoration(
      hintText: h,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: isPwd
          ? IconButton(
              icon: Icon(
                _isObscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () => setState(() => _isObscure = !_isObscure),
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF0091D5)),
      ),
    ),
  );

  Widget _googleButton() => Container(
    width: 60,
    height: 60,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
    ),
    child: ClipOval(
      child: Image.asset('assets/ggl_logo.png', fit: BoxFit.cover),
    ),
  );

  Widget _footerLink(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        "Already have an account? ",
        style: TextStyle(color: Colors.grey),
      ),
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: const Text(
          "Back to Step 1",
          style: TextStyle(
            color: Color(0xFF0091D5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

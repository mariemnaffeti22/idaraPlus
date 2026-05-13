import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:idara_plus/presentation/administration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _agreed = false;

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
                const SizedBox(height: 40),
                Image.asset('assets/logo.png', height: 60),
                const SizedBox(height: 10),
                const Text(
                  "Sign in to your account",
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
                _input(
                  "Enter your password",
                  isPwd: true,
                  obscure: _obscurePassword,
                  onToggle: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: _agreed,
                      shape: const CircleBorder(),
                      onChanged: (v) => setState(() => _agreed = v!),
                    ),
                    const Expanded(
                      child: Text(
                        "I've read and agreed to User Agreement and Privacy Policy",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
                _primaryButton("Sign in", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdministrationPage(),
                    ),
                  );
                }),

                const SizedBox(height: 40),
                const Text(
                  "other way to sign in",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 20),
                _googleButton(),

                const SizedBox(height: 40),
                _footerLink("Don't have an account? ", "Create Account", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupPageOne(),
                    ),
                  );
                }),
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

  Widget _input(
    String h, {
    bool isPwd = false,
    bool obscure = false,
    VoidCallback? onToggle,
  }) => TextField(
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: h,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: isPwd
          ? IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Colors.grey,
              ),
              onPressed: onToggle,
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

  Widget _primaryButton(String t, VoidCallback tap) => SizedBox(
    width: double.infinity,
    height: 55,
    child: ElevatedButton(
      onPressed: tap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0091D5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 18)),
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

  Widget _footerLink(String t1, String t2, VoidCallback tap) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(t1, style: const TextStyle(color: Colors.grey)),
      GestureDetector(
        onTap: tap,
        child: Text(
          t2,
          style: const TextStyle(
            color: Color(0xFF0091D5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

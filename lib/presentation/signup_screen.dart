import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'signup_step2.dart';

class SignupPageOne extends StatefulWidget {
  const SignupPageOne({super.key});

  @override
  State<SignupPageOne> createState() => _SignupPageOneState();
}

class _SignupPageOneState extends State<SignupPageOne> {
  final TextEditingController _dateCtrl = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null)
      setState(() => _dateCtrl.text = DateFormat('yyyy-MM-dd').format(picked));
  }

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
                const SizedBox(height: 30),

                _label("Nom"),
                _input("Enter your email address"),
                const SizedBox(height: 20),
                _label("Prenom"),
                _input("Enter your phone number"),
                const SizedBox(height: 20),
                _label("Date de naissance"),
                GestureDetector(
                  onTap: () => _selectDate(context),
                  child: AbsorbPointer(
                    child: _input(
                      "Enter your password",
                      controller: _dateCtrl,
                      hasSuffix: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _label("Region"),
                _input("Enter your confirm password", hasSuffix: true),
                const SizedBox(height: 20),
                _label("Num de tel"),
                _input("Enter your confirm password", hasSuffix: true),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPageTwo(),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0091D5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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

  Widget _input(
    String h, {
    TextEditingController? controller,
    bool hasSuffix = false,
  }) => TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: h,
      filled: true,
      fillColor: Colors.white,
      suffixIcon: hasSuffix
          ? const Icon(Icons.visibility_off_outlined, color: Colors.grey)
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
          "Back to Sign In",
          style: TextStyle(
            color: Color(0xFF0091D5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

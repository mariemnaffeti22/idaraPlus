import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:idara_plus/presentation/splash_screen.dart';

void main() {
   // 1. Hook into the binding
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Keep the native splash screen on screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bouncing Splash Demo',
      theme: ThemeData(
        // Set the background color here to match your splash 
        // to prevent any white/black flicker between screens.
        scaffoldBackgroundColor: Colors.white, 
      ),
      home: const SplashScreen(),
    );
  }
}

// Simple Home Screen for navigation target
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: const Center(child: Text("Welcome!")),
    );
  }
}
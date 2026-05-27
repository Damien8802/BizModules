import 'package:flutter/material.dart';
import 'screens/modules_screen.dart';

void main() {
  runApp(const BizModulesApp());
}

class BizModulesApp extends StatelessWidget {
  const BizModulesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizModules',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1A1A2E),
        primaryColor: const Color(0xFF667EEA),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ModulesScreen(userEmail: 'dev@businessstack.ru'),
      debugShowCheckedModeBanner: false,
    );
  }
}

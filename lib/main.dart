import 'package:flutter/material.dart';
import 'screens/scan_screen.dart';

void main() {
  runApp(const WifiLanApp());
}

class WifiLanApp extends StatelessWidget {
  const WifiLanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wifi LAN Manager',
      theme: ThemeData.dark().copyWith(primaryColor: Colors.blueAccent),
      home: const ScanScreen(),
    );
  } // build
} // WifiLanApp

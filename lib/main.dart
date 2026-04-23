import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'screens/whatsapp.dart';
import 'screens/email.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WhatsappScreen(),
    const GmailScreen(),
  ];

  @override
  void initState() {
    super.initState();


    Future.delayed(Duration.zero, () {
      checkForUpdate(context);
    });
  }


  Future<void> checkForUpdate(BuildContext context) async {
    final response = await http.get(
      Uri.parse("https://Abhi-sharma06.github.io/DM-Direct-Message-/version.json"),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      int latestVersionCode = data['versionCode'];
      String apkUrl = data['apk_url'];

      int currentVersionCode = 2;

      if (latestVersionCode > currentVersionCode) {
        _showUpdateDialog(context, apkUrl);
      }
    }
  }


  void _showUpdateDialog(BuildContext context, String apkUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Update Available 🚀"),
        content: const Text("New version available. Please update."),
        actions: [
          TextButton(
            onPressed: () {
              launchUrl(Uri.parse(apkUrl));
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        useMaterial3: true,
      ),

      home: Scaffold(
        body: _screens[_selectedIndex],

        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onTap,

              backgroundColor: Colors.white,
              elevation: 0,
              type: BottomNavigationBarType.fixed,

              selectedItemColor: _selectedIndex == 0
                  ? const Color(0xFF128C7E)
                  : const Color(0xFFEA4335),

              unselectedItemColor: Colors.grey,

              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  activeIcon: Icon(Icons.chat_bubble),
                  label: "WhatsApp",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline),
                  activeIcon: Icon(Icons.mail),
                  label: "Email",
                ),
              ],
            ),
          ),
        ),
      ),

      routes: {
        '/whatsapp': (context) => const WhatsappScreen(),
        '/email': (context) => const GmailScreen(),
      },
    );
  }
}